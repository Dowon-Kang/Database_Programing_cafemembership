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
			<h2 class="display-3">북스토어에 오신 것을 환영합니다</h2>
		</div>
	</div>	
	<div class="container">
		<div class="text-center">
			<h3>Welcome to Book Market!</h3>
			<%!
				int pageCount = 0;
				void addCount() {
					pageCount++;
				}
			%>
			<% 	addCount();  %>
			<p>	이 사이트 방문자로는 <span style="color:red"> <%=pageCount%> </span> 번째 입니다.</p>			
		</div>
		<hr>
	</div>	
	<jsp:include page="footer.jsp" />
</body>
</html>