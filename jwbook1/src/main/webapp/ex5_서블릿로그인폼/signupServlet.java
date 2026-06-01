package ex5;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(description = "signup 서블릿", urlPatterns = { "/signup" })
public class signupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public signupServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String res = "<html><h3>User ID: " + request.getParameter("id") + "</h3>";
		res += "<h3>Password: " + request.getParameter("ps") + "</h3>";
		res += "<h3>Name: " + request.getParameter("name") + "</h3></html>";
	
		response.getWriter().print(res);
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}
}
