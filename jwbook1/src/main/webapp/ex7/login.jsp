<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head></head>
<body>
	<%
		System.out.println("--login.jsp페이지-- ");
	%>
	<h5>== 로그인 화면 ==</h5>
	
	<form action="login_process.jsp" method="post">
		<p>	아 이 디 : <input type="text" name="id">
		<p>	비밀번호 : <input type="text" name="passwd">
		<p>	<input type="submit" value="로그인" />
	</form>

</body>
</html>