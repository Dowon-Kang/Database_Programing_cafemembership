package ex11;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletContext;


import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.Part;
import java.io.File;

@WebServlet("/bm3control")

@MultipartConfig(maxFileSize=1024*1024*2, location="c:/Temp/img")

public class BookMarket3Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private BookDAO dao;
	private ServletContext ctx;
	
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		dao = new BookDAO();
		ctx = getServletContext();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		String view = "";
		
		if(action == null) {
			getServletContext().getRequestDispatcher("/bm3control?action=welcome").forward(request, response);
		} else {
			switch(action) {
				case "welcome": view = welcome(request, response);break;
				case "login": view = login(request, response);break;
				case "welcomeUser": view = welcomeUser(request, response);break;
				case "productInfoList": view = productInfoList(request, response);break;
				case "productInfo": view = productInfo(request, response);break;
				case "addProduct": view = addProduct(request, response);break;
				case "processLogin": view = processLogin(request, response);break;
				case "processLogout": view = processLogout(request, response);break;
				case "processAddProduct": view = processAddProduct(request, response);break;
			}
			getServletContext().getRequestDispatcher("/ex11/"+view).forward(request, response);		
		}
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

	private String productInfoList(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("books", dao.findAll());
		return "productInfoList.jsp";
	}

	private String productInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		request.setAttribute("b", dao.find(request.getParameter("id")));
		return "productInfo.jsp";
	}
	
	private String addProduct(HttpServletRequest request, HttpServletResponse response) {
		return "addProduct.jsp";
	}
		
	private String processLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String password = request.getParameter("password");

		HttpSession session = request.getSession();
		session.setAttribute("sessionId", id);

		return "welcomeUser.jsp";		
	}

	private String processLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		session.invalidate();

		return "welcome.jsp";		
	}

	public String processAddProduct(HttpServletRequest request, HttpServletResponse response) {
	    Book b = new Book();

	    try {
	        BeanUtils.populate(b, request.getParameterMap());

	        Part part = request.getPart("file");
	        String fileName = getFilename(part);

	        if (fileName != null && !fileName.isEmpty()) {
	            String uploadPath = request.getServletContext().getRealPath("/assets/img");
	            part.write(uploadPath + java.io.File.separator + fileName);
	            b.setProductImg("/assets/img/" + fileName);
	        }

	        System.out.println("등록할 상품ID = " + b.getProductId());
	        System.out.println("등록할 도서명 = " + b.getPname());
	        System.out.println("등록할 이미지 = " + b.getProductImg());

	        dao.insert(b);

	    } catch (Exception e) {
	        e.printStackTrace();
	        ctx.log("도서 추가 과정에서 문제 발생!!");
	    }

	    return productInfoList(request, response);
	}
	
    // multipart 헤더에서 파일이름 추출
	private String getFilename(Part part) {
        String fileName = null;   
        // 파일이름이 들어있는 헤더 영역을 가지고 옴
        String header = part.getHeader("content-disposition");
        //part.getHeader -> form-data; name="file"; filename="book1.jpg"
        System.out.println("Header => "+header);

        // 파일 이름이 들어있는 속성 부분의 시작위치를 가져와 쌍따옴표 사이의 값 부분만 가지고옴
        int start = header.indexOf("filename=");
        fileName = header.substring(start+10,header.length()-1);        
        ctx.log("파일명:"+fileName);        
        return fileName; 
	}
}