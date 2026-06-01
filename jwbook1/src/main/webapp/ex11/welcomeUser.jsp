<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date"%>

<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<title>Welcome 사용자 페이지</title>
</head>
<body>
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h2 class="display-3"><span style="color: blue">${sessionId}</span>님 반갑습니다!!</h2>
		</div>
	</div>	
	<div class="container">
		<div class="text-center">
			<h4>Welcome to Book Market!</h4>
			<%!
				int pageCount = 0;
				void addCount() {
					pageCount++;
				}
			%>
			<% 	addCount();  %>
			<p>	이 사이트 로그인 사용자로는 <span style="color:red"> <%=pageCount%> </span> 번째 입니다.</p>			
		</div>
		<hr>
	</div>	
	<jsp:include page="footer.jsp" />
</body>
</html>