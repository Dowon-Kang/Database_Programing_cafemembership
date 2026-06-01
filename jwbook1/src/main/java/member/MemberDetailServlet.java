package member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/memberDetail")
public class MemberDetailServlet extends HttpServlet {

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
        request.getRequestDispatcher("/member/memberDetail.jsp").forward(request, response);
    }
}
