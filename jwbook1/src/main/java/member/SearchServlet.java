package member;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private MemberDAO dao = new MemberDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String keyword = request.getParameter("keyword");
        List<MemberDTO> list = (keyword != null && !keyword.trim().isEmpty())
                ? dao.search(keyword.trim())
                : dao.findAll();

        request.setAttribute("memberList", list);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/member/memberList.jsp").forward(request, response);
    }
}
