<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head></head>
<body>
	<%
		System.out.println("--pw_modify_process.jsp페이지-- ");
	
		String r_pw = request.getParameter("passwd");
		System.out.println("request정보=> password : " + r_pw);
	%>
					
	<jsp:useBean id="u1" class="ex7.User" scope="application" />
	<jsp:setProperty name="u1" property="pw" value="<%=r_pw%>"/>	
	
	<jsp:getProperty name="u1" property="id"/>	
	<jsp:getProperty name="u1" property="pw"/>	

	<% response.sendRedirect("login.jsp"); %>
</body>
</html>
