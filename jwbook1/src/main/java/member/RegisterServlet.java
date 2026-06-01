package member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private MemberDAO dao = new MemberDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/member/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String memberId = request.getParameter("memberId");
        String password = request.getParameter("password");
        String name     = request.getParameter("name");
        String phone    = request.getParameter("phone");

        if (dao.existsId(memberId)) {
            request.setAttribute("error", "이미 사용 중인 아이디입니다.");
            request.getRequestDispatcher("/member/register.jsp").forward(request, response);
            return;
        }
        if (dao.existsPhone(phone)) {
            request.setAttribute("error", "이미 등록된 전화번호입니다.");
            request.getRequestDispatcher("/member/register.jsp").forward(request, response);
            return;
        }

        MemberDTO m = new MemberDTO();
        m.setMemberId(memberId);
        m.setPassword(password);
        m.setName(name);
        m.setPhone(phone);
        dao.insert(m);

        response.sendRedirect(request.getContextPath() + "/login");
    }
}
