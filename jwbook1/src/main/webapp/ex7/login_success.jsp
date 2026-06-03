<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head></head>
<body>
	<%
		System.out.println("--login_success.jsp페이지-- ");
	
		request.setCharacterEncoding("utf-8");
		String r_id = request.getParameter("id");
		String r_pw = request.getParameter("passwd");
		System.out.println("request정보=> id : "+ r_id + " password : " + r_pw);
		
		String s_id = (String) session.getAttribute("s_id");
		String s_pw = (String) session.getAttribute("s_pw");
		System.out.println("session정보=> id : "+ s_id + " password : " + s_pw);
	%>
	<p> [아이디 : <%=s_id%>]  |  [비밀번호 : <%=s_pw%>] </p>	

	<jsp:useBean id="u1" class="ex7.User" scope="application" />	
	<p>	<span style="color:blue"> <jsp:getProperty name="u1" property="name"/></span>님, 로그인을 성공했습니다!!</p>

	<input type="button" value="비번변경하기" onclick="location.href='./pw_modify.jsp'"/>
</body>
</html>