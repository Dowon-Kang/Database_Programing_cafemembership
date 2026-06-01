<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<title>Welcome 사용자 페이지</title>
</head>
<body>
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h2 class="display-3"><span style="color: blue">${sessionName}</span>님 반갑습니다!!</h2>
		</div>
	</div>	
	<div class="container">
		<div class="text-center">
			<c:if test="${not empty authError}">
				<div class="alert alert-danger">${authError}</div>
			</c:if>
			<h4>Welcome to Cafe Membership Manager!</h4>
			<p>회원 아이디: <strong>${sessionId}</strong></p>
			<p>권한: <strong><c:choose><c:when test="${sessionIsAdmin}">관리자</c:when><c:otherwise>일반 회원</c:otherwise></c:choose></strong></p>
			<c:if test="${not sessionIsAdmin}">
				<p><a href="${pageContext.request.contextPath}/memberControl?action=myInfo" class="btn btn-outline-primary">내 정보 보기</a></p>
			</c:if>
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