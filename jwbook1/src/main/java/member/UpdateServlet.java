package member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/update")
public class UpdateServlet extends HttpServlet {

    private MemberDAO dao = new MemberDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String memberId = request.getParameter("memberId");
        MemberDTO m = dao.findById(memberId);

        if (m == null) {
            response.sendRedirect(request.getContextPath() + "/memberList");
            return;
        }

        request.setAttribute("member", m);
        request.getRequestDispatcher("/member/update.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String memberId  = request.getParameter("memberId");
        String password  = request.getParameter("password");
        String name      = request.getParameter("name");
        String phone     = request.getParameter("phone");
        int    stampCount = Integer.parseInt(request.getParameter("stampCount"));

        MemberDTO m = new MemberDTO();
        m.setMemberId(memberId);
        m.setPassword(password);
        m.setName(name);
        m.setPhone(phone);
        m.setStampCount(stampCount);
        dao.update(m);

        response.sendRedirect(request.getContextPath() + "/memberDetail?memberId=" + memberId);
    }
}
