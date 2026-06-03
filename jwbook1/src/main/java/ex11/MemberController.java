package ex11;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;

@WebServlet("/memberControl")
public class MemberController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MemberDAO dao;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        dao = new MemberDAO();
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String action = request.getParameter("action");
        String view;

        if (action == null) {
            getServletContext().getRequestDispatcher("/memberControl?action=welcome").forward(request, response);
            return;
        }

        String adminView = requireAdminIfNeeded(action, request, response);
        if (adminView != null) {
            getServletContext().getRequestDispatcher("/ex11/" + adminView).forward(request, response);
            return;
        }

        switch (action) {
            case "welcome": view = "welcome.jsp"; break;
            case "login": view = "login.jsp"; break;
            case "welcomeUser": view = "welcomeUser.jsp"; break;
            case "myInfo": view = myInfo(request, response); break;
            case "editMyInfo": view = editMyInfo(request, response); break;
            case "memberList": view = memberList(request, response); break;
            case "memberDetail": view = memberDetail(request, response); break;
            case "addMember": view = addMember(request, response); break;
            case "editMember": view = editMember(request, response); break;
            case "processLogin": view = processLogin(request, response); break;
            case "processLogout": view = processLogout(request, response); break;
            case "processAddMember": view = processAddMember(request, response); break;
            case "processUpdateMember": view = processUpdateMember(request, response); break;
            case "processMyInfoUpdate": view = processMyInfoUpdate(request, response); break;
            case "processIncrementStamp": view = processIncrementStamp(request, response); break;
            case "deleteMember": view = deleteMember(request, response); break;
            default: view = "welcome.jsp"; break;
        }
        getServletContext().getRequestDispatcher("/ex11/" + view).forward(request, response);
    }

    private String myInfo(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("sessionId") == null) return "login.jsp";
        request.setAttribute("member", dao.find((String) session.getAttribute("sessionId")));
        request.setAttribute("isMyInfo", true);
        return "memberDetail.jsp";
    }

    private String editMyInfo(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("sessionId") == null) return "login.jsp";
        request.setAttribute("mode", "edit");
        request.setAttribute("member", dao.find((String) session.getAttribute("sessionId")));
        request.setAttribute("isMyInfo", true);
        return "memberForm.jsp";
    }

    private String memberList(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("members", dao.findByKeyword(request.getParameter("keyword")));
        return "memberList.jsp";
    }

    private String memberDetail(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("member", dao.find(request.getParameter("id")));
        return "memberDetail.jsp";
    }

    private String addMember(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("mode", "create");
        request.setAttribute("member", new Member());
        return "memberForm.jsp";
    }

    private String editMember(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("mode", "edit");
        request.setAttribute("member", dao.find(request.getParameter("id")));
        return "memberForm.jsp";
    }

    private String processLogin(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        Member member = dao.authenticate(id, password);
        if (member == null) {
            request.setAttribute("loginError", "아이디 또는 비밀번호가 틀렸습니다.");
            return "login.jsp";
        }
        HttpSession session = request.getSession();
        session.setAttribute("sessionId", member.getMemberId());
        session.setAttribute("sessionName", member.getName());
        session.setAttribute("sessionIsAdmin", member.isAdmin());
        return "welcomeUser.jsp";
    }

    private String processLogout(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().invalidate();
        return "welcome.jsp";
    }

    private String processAddMember(HttpServletRequest request, HttpServletResponse response) {
        Member member = new Member();
        try {
            BeanUtils.populate(member, request.getParameterMap());
            member.setStampCount(0);
            member.setAdminYn("N");
            dao.insert(member);
        } catch (Exception e) {
            e.printStackTrace(); // 콘솔에 구체적인 에러 출력
            request.setAttribute("formError", "가입 실패: " + e.getMessage());
            return "memberForm.jsp";
        }
        HttpSession session = request.getSession(false);
        if (session != null && Boolean.TRUE.equals(session.getAttribute("sessionIsAdmin"))) {
            return memberList(request, response);
        }
        return "login.jsp";
    }

    private String processUpdateMember(HttpServletRequest request, HttpServletResponse response) {
        Member member = new Member();
        try {
            BeanUtils.populate(member, request.getParameterMap());
            dao.update(member);
        } catch (Exception e) { e.printStackTrace(); }
        request.setAttribute("member", dao.find(member.getMemberId()));
        return "memberDetail.jsp";
    }

    private String processMyInfoUpdate(HttpServletRequest request, HttpServletResponse response) {
        String sid = (String) request.getSession().getAttribute("sessionId");
        Member m = new Member();
        try {
            BeanUtils.populate(m, request.getParameterMap());
            Member old = dao.find(sid);
            m.setMemberId(sid);
            m.setAdminYn(old.getAdminYn());
            m.setStampCount(old.getStampCount());
            dao.update(m);
            request.getSession().setAttribute("sessionName", m.getName());
        } catch (Exception e) { e.printStackTrace(); }
        request.setAttribute("member", dao.find(sid));
        request.setAttribute("isMyInfo", true);
        return "memberDetail.jsp";
    }

    private String deleteMember(HttpServletRequest request, HttpServletResponse response) {
        dao.delete(request.getParameter("id"));
        return memberList(request, response);
    }

    private String processIncrementStamp(HttpServletRequest request, HttpServletResponse response) {
        dao.incrementStamp(request.getParameter("id"));
        return memberList(request, response);
    }

    private String requireAdminIfNeeded(String action, HttpServletRequest request, HttpServletResponse response) {
        if (!isAdminAction(action)) return null;
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("sessionId") == null) return "login.jsp";
        if (!Boolean.TRUE.equals(session.getAttribute("sessionIsAdmin"))) return "welcomeUser.jsp";
        return null;
    }

    private boolean isAdminAction(String action) {
        return "memberList".equals(action) || "memberDetail".equals(action) || "editMember".equals(action) 
            || "processUpdateMember".equals(action) || "processIncrementStamp".equals(action) || "deleteMember".equals(action);
    }
}