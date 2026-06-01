<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<title>멤버십 로그인</title>
</head>
<body>
	<jsp:include page="./menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">관리자 로그인</h1>
		</div>
	</div>
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h5 class="form-signin-heading">관리용 아이디와 비밀번호를 입력하세요</h5>
			<% if (request.getAttribute("loginError") != null) { %>
				<div class="alert alert-danger"><%= request.getAttribute("loginError") %></div>
			<% } %>
			<form class="form-signin" action="/jwbook1/memberControl?action=processLogin" method="post">
				<div class="form-group">
					<label for="inputUserName" class="sr-only">User Name</label> 
					<input type="text" class="form-control" placeholder="ID" name="id" value="${enteredId}" required autofocus>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">Password</label> 
					<input type="password" class="form-control" placeholder="Password" name="password" required>
				</div>		
				<button class="btn btn btn-lg btn-success btn-block" type="submit">로그인</button>
			</form>
			<p class="mt-3 text-muted">비밀번호는 SHA-256 해시로 저장됩니다. 관리자 전용 계정은 admin / 1234 입니다.</p>
		</div>
	</div>
</body>
</html>