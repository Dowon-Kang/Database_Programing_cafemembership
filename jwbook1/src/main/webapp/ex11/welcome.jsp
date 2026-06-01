<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date"%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>Welcome 환영페이지</title>
</head>
<body>
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h2 class="display-3">카페 멤버십 관리 시스템</h2>
		</div>
	</div>	
	<div class="container">
		<div class="text-center">
			<h3>Welcome to Cafe Membership Manager!</h3>
			<%!
				int pageCount = 0;
				void addCount() {
					pageCount++;
				}
			%>
			<% 	addCount();  %>
			<p>	이 페이지 방문자는 <span style="color:red"> <%=pageCount%> </span> 번째 입니다.</p>			
		</div>
		<hr>
	</div>	
	<jsp:include page="footer.jsp" />
</body>
</html>