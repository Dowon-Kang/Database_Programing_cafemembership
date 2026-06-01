package ch07;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Calc")
public class CalcServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CalcServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String n1Str = request.getParameter("n1");
        String n2Str = request.getParameter("n2");
        String op = request.getParameter("op");

        if (n1Str == null || n2Str == null || op == null ||
            n1Str.isBlank() || n2Str.isBlank()) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("값이 전달되지 않았습니다. n1, n2, op를 확인하세요.");
            return;
        }

        int n1 = Integer.parseInt(n1Str);
        int n2 = Integer.parseInt(n2Str);

        long result = 0;

        switch (op) {
            case "+": result = n1 + n2; break;
            case "-": result = n1 - n2; break;
            case "*": result = n1 * n2; break;
            case "/":
                if (n2 == 0) {
                    response.setContentType("text/html; charset=UTF-8");
                    response.getWriter().println("0으로 나눌 수 없습니다.");
                    return;
                }
                result = n1 / n2;
                break;
        }

        request.setAttribute("result", result);
        getServletContext()
            .getRequestDispatcher("/ch07/calcResult.jsp")
            .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}