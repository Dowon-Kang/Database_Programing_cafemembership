<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
</head>
<body>
	<h4>---------- 첫번째 페이지 START -------------</h4>
	<jsp:forward page="2th.jsp">
		<jsp:param name="city" value='<%=java.net.URLEncoder.encode("서울특별시")%>'/>
	</jsp:forward>
	<h4>---------- 첫번째 페이지 END -------------</h4>
</body>
</html>