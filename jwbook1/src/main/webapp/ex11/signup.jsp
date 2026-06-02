<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<title>회원가입</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">카페 멤버십 회원가입</h1>
		</div>
	</div>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<c:if test="${not empty signupError}">
					<div class="alert alert-danger">${signupError}</div>
				</c:if>
				<form action="${pageContext.request.contextPath}/memberControl?action=processSignup" method="post">
					<div class="form-group">
						<label>회원 ID</label>
						<input type="text" name="memberId" class="form-control" value="${member.memberId}" required>
					</div>
					<div class="form-group">
						<label>비밀번호</label>
						<input type="password" name="password" class="form-control" required>
					</div>
					<div class="form-group">
						<label>이름</label>
						<input type="text" name="name" class="form-control" value="${member.name}" required>
					</div>
					<div class="form-group">
						<label>전화번호</label>
						<input type="text" name="phone" class="form-control" value="${member.phone}" placeholder="010-1234-5678" required>
					</div>
					<div class="form-group">
						<label>프로필 이미지 URL</label>
						<input type="url" name="imageUrl" class="form-control" value="${member.imageUrl}" placeholder="https://example.com/profile.jpg">
						<small class="form-text text-muted">원하는 프로필 이미지 주소가 있으면 등록할 수 있습니다.</small>
					</div>
					<c:if test="${not empty member.imageUrl}">
						<div class="form-group">
							<p class="mb-2">미리보기</p>
							<img src="${member.imageUrl}" alt="프로필 미리보기" style="width: 120px; height: 120px; object-fit: cover; border-radius: 12px; border: 1px solid #dee2e6;">
						</div>
					</c:if>
					<button type="submit" class="btn btn-primary btn-block">회원가입</button>
					<a href="${pageContext.request.contextPath}/memberControl?action=login" class="btn btn-outline-secondary btn-block">로그인으로 돌아가기</a>
				</form>
			</div>
		</div>
	</div>
</body>
</html>