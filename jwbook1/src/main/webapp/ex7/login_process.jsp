<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head></head>
<body>
	<%
		System.out.println("--login_process.jsp페이지-- ");
	
		// request 정보 확인
		request.setCharacterEncoding("utf-8");
		String r_id = request.getParameter("id");
		String r_pw = request.getParameter("passwd");
		System.out.println("request정보=> id : "+ r_id + " password : " + r_pw);
		
		// session 정보 설정 
		session.setAttribute("s_id", r_id);
		session.setAttribute("s_pw", r_pw);
		
		// session 정보 확인
		String s_id = (String) session.getAttribute("s_id");
		String s_pw = (String) session.getAttribute("s_pw");
		System.out.println("session정보=> id : "+ s_id + " password : " + s_pw);
	%>
		<%-- application 정보 확인 --%>
		<jsp:useBean id="u1" class="ex7.User" scope="application" />
		<jsp:getProperty name="u1" property="id"/>
		<jsp:getProperty name="u1" property="pw"/>
	<%
		// 아이디 및 비번 확인후 페이지 이동
		if (r_id.equals(u1.getId()) && r_pw.equals(u1.getPw())) { %>
			<jsp:forward page="login_success.jsp"/> <%;
		} else {
			response.sendRedirect("login_fail.jsp");
		}
	%>	
</body>
</html>
