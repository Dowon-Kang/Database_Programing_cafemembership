<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head></head>
<body>
	<%
		System.out.println("--pw_modify.jsp페이지--");
	
		String s_id = (String) session.getAttribute("s_id"); 
	%>

	<h5>== 비번 변경 화면 ==</h5>	
	<form action="pw_modify_process.jsp" method="post">
		<p>	아 이 디 : <input type="text" name="id" value="${s_id}" disabled="disabled">
		<p>	비밀 번호 : <input type="text" name="passwd" value="">
		<p>	<input type="submit" value="비번 변경" />
	</form>
</body>
</html>
