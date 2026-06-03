package ex5;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(description = "생명주기 테스트", urlPatterns = { "/lifecycleServlet1" })
public class lifecycleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public lifecycleServlet() {
        super();
    }

	public void init(ServletConfig config) throws ServletException {
		System.out.println("init 실행");
	}

	public void destroy() {
		System.out.println("destroy 실행");
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("service 실행");
		if (request.getMethod().equals("GET"))
			doGet(request, response);
		else if (request.getMethod().equals("POST"))
			doPost(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		System.out.println("doGet 실행");
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8"); 
		System.out.println("doPost 실행");
		response.getWriter().append("이름: ").append(request.getParameter("name"));
	}

}
