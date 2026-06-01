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
	private ServletContext ctx;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		dao = new MemberDAO();
		ctx = getServletContext();
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
			case "welcome": view = welcome(request, response); break;
			case "login": view = login(request, response); break;
			case "welcomeUser": view = welcomeUser(request, response); break;
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
			default: view = welcome(request, response); break;
		}

		getServletContext().getRequestDispatcher("/ex11/" + view).forward(request, response);
	}

	private String welcome(HttpServletRequest request, HttpServletResponse response) {
		return "welcome.jsp";
	}

	private String login(HttpServletRequest request, HttpServletResponse response) {
		return "login.jsp";
	}

	private String welcomeUser(HttpServletRequest request, HttpServletResponse response) {
		return "welcomeUser.jsp";
	}

	private String myInfo(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("sessionId") == null) {
			request.setAttribute("loginError", "로그인이 필요합니다.");
			return "login.jsp";
		}

		request.setAttribute("member", dao.find((String) session.getAttribute("sessionId")));
		request.setAttribute("isMyInfo", true);
		return "memberDetail.jsp";
	}

	private String editMyInfo(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("sessionId") == null) {
			request.setAttribute("loginError", "로그인이 필요합니다.");
			return "login.jsp";
		}

		request.setAttribute("mode", "edit");
		request.setAttribute("member", dao.find((String) session.getAttribute("sessionId")));
		request.setAttribute("isMyInfo", true);
		request.setAttribute("allowAdminEdit", false);
		request.setAttribute("allowStampEdit", false);
		return "memberForm.jsp";
	}

	private String memberList(HttpServletRequest request, HttpServletResponse response) {
		String keyword = request.getParameter("keyword");
		request.setAttribute("searchKeyword", keyword);
		request.setAttribute("members", dao.findByKeyword(keyword));
		return "memberList.jsp";
	}

	private String memberDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
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

	private String processLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		Member member = dao.authenticate(id, password);

		if (member == null) {
			request.setAttribute("loginError", "아이디 또는 비밀번호가 올바르지 않습니다.");
			request.setAttribute("enteredId", id);
			return "login.jsp";
		}

		HttpSession session = request.getSession();
		session.setAttribute("sessionId", member.getMemberId());
		session.setAttribute("sessionName", member.getName());
		session.setAttribute("sessionIsAdmin", member.isAdmin());

		return "welcomeUser.jsp";
	}

	private String processLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		session.invalidate();
		return "welcome.jsp";
	}

	private String processAddMember(HttpServletRequest request, HttpServletResponse response) {
		Member member = new Member();

		try {
			BeanUtils.populate(member, request.getParameterMap());
			dao.insert(member);
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("회원 추가 과정에서 문제 발생!!");
			request.setAttribute("mode", "create");
			request.setAttribute("member", member);
			request.setAttribute("formError", "회원 등록에 실패했습니다. 입력값을 확인하세요.");
			return "memberForm.jsp";
		}

		return memberList(request, response);
	}

	private String processUpdateMember(HttpServletRequest request, HttpServletResponse response) {
		Member member = new Member();

		try {
			BeanUtils.populate(member, request.getParameterMap());
			dao.update(member);
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("회원 수정 과정에서 문제 발생!!");
			request.setAttribute("mode", "edit");
			request.setAttribute("member", dao.find(request.getParameter("memberId")));
			request.setAttribute("formError", "회원 수정에 실패했습니다. 입력값을 확인하세요.");
			return "memberForm.jsp";
		}

		request.setAttribute("member", dao.find(request.getParameter("memberId")));
		return "memberDetail.jsp";
	}

	private String processMyInfoUpdate(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("sessionId") == null) {
			request.setAttribute("loginError", "로그인이 필요합니다.");
			return "login.jsp";
		}

		String sessionMemberId = (String) session.getAttribute("sessionId");
		Member member = new Member();

		try {
			BeanUtils.populate(member, request.getParameterMap());
			Member existingMember = dao.find(sessionMemberId);
			member.setMemberId(sessionMemberId);
			member.setAdminYn(existingMember == null ? "N" : existingMember.getAdminYn());
			member.setStampCount(existingMember == null ? 0 : existingMember.getStampCount());
			dao.update(member);
			Member updatedMember = dao.find(sessionMemberId);
			session.setAttribute("sessionName", updatedMember.getName());
			request.setAttribute("member", updatedMember);
			request.setAttribute("isMyInfo", true);
			return "memberDetail.jsp";
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("내 정보 수정 과정에서 문제 발생!!");
			request.setAttribute("mode", "edit");
			request.setAttribute("member", dao.find(sessionMemberId));
			request.setAttribute("isMyInfo", true);
			request.setAttribute("allowAdminEdit", false);
			request.setAttribute("allowStampEdit", false);
			request.setAttribute("formError", "내 정보 수정에 실패했습니다. 입력값을 확인하세요.");
			return "memberForm.jsp";
		}
	}

	private String deleteMember(HttpServletRequest request, HttpServletResponse response) {
		Member targetMember = dao.find(request.getParameter("id"));
		if (targetMember != null && targetMember.isAdmin()) {
			request.setAttribute("member", targetMember);
			request.setAttribute("detailError", "관리자 계정은 삭제할 수 없습니다.");
			return "memberDetail.jsp";
		}

		dao.delete(request.getParameter("id"));
		return memberList(request, response);
	}

	private String processIncrementStamp(HttpServletRequest request, HttpServletResponse response) {
		String memberId = request.getParameter("id");
		String returnView = request.getParameter("returnView");

		if (memberId == null || memberId.trim().isEmpty()) {
			request.setAttribute("listError", "스탬프를 올릴 회원 ID가 없습니다.");
			return memberList(request, response);
		}

		dao.incrementStamp(memberId);

		if ("detail".equals(returnView)) {
			request.setAttribute("member", dao.find(memberId));
			request.setAttribute("detailMessage", "스탬프가 1개 적립되었습니다.");
			return "memberDetail.jsp";
		}

		request.setAttribute("listMessage", "스탬프가 1개 적립되었습니다.");
		return memberList(request, response);
	}

	private String requireAdminIfNeeded(String action, HttpServletRequest request, HttpServletResponse response) {
		if (!isAdminAction(action)) {
			return null;
		}

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("sessionId") == null) {
			request.setAttribute("loginError", "관리자 로그인이 필요합니다.");
			request.setAttribute("enteredId", request.getParameter("id"));
			return "login.jsp";
		}

		if (!Boolean.TRUE.equals(session.getAttribute("sessionIsAdmin"))) {
			request.setAttribute("authError", "관리자 계정만 회원 관리 기능을 사용할 수 있습니다.");
			return "welcomeUser.jsp";
		}

		return null;
	}

	private boolean isAdminAction(String action) {
		return "memberList".equals(action)
			|| "memberDetail".equals(action)
			|| "addMember".equals(action)
			|| "editMember".equals(action)
			|| "processAddMember".equals(action)
			|| "processUpdateMember".equals(action)
			|| "processIncrementStamp".equals(action)
			|| "deleteMember".equals(action);
	}
}