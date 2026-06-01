<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<link rel="stylesheet" 	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<title>회원 상세 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 상세 정보</h1>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<c:if test="${not empty detailError}">
					<div class="alert alert-danger">${detailError}</div>
				</c:if>
				<c:if test="${not empty detailMessage}">
					<div class="alert alert-success">${detailMessage}</div>
				</c:if>
				<h3>${member.name}</h3>
				<p><b>회원 ID</b> : <span class="badge badge-primary">${member.memberId}</span></p>
				<p><b>전화번호</b> : ${member.phone}</p>
				<p><b>스탬프 개수</b> : ${member.stampCount}</p>
				<p><b>가입일</b> : ${member.joinDate}</p>
				<p>
					<c:if test="${isMyInfo}">
					<a href="${pageContext.request.contextPath}/memberControl?action=editMyInfo" class="btn btn-primary">내 정보 수정 &raquo;</a>
					</c:if>
					<c:if test="${sessionIsAdmin}">
					<form method="post" action="${pageContext.request.contextPath}/memberControl" style="display:inline;">
						<input type="hidden" name="action" value="processIncrementStamp">
						<input type="hidden" name="id" value="${member.memberId}">
						<input type="hidden" name="returnView" value="detail">
						<button type="submit" class="btn btn-success">스탬프 +1</button>
					</form>
					<a href="${pageContext.request.contextPath}/memberControl?action=editMember&id=${member.memberId}" class="btn btn-warning">회원 수정 &raquo;</a>
					<c:if test="${member.adminYn ne 'Y'}">
					<a href="${pageContext.request.contextPath}/memberControl?action=deleteMember&id=${member.memberId}" class="btn btn-danger" onclick="return confirm('이 회원을 삭제하시겠습니까?');">회원 삭제 &raquo;</a>
					</c:if>
					</c:if>
					<c:choose>
						<c:when test="${isMyInfo}">
							<a href="${pageContext.request.contextPath}/memberControl?action=welcomeUser" class="btn btn-secondary">돌아가기 &raquo;</a>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath}/memberControl?action=memberList" class="btn btn-secondary">회원 목록 &raquo;</a>
						</c:otherwise>
					</c:choose>
				</p>
			</div>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
