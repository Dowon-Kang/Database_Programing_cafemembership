<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<link rel="stylesheet" 	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<title>회원 등록/수정</title>
</head>
<body>
	<jsp:include page="menu.jsp" />	
	<div class="jumbotron">
		<div class="container">
			<c:choose>
				<c:when test="${mode eq 'edit'}"><h1 class="display-3">회원 수정</h1></c:when>
				<c:otherwise><h1 class="display-3">회원 등록</h1></c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="container">
		<c:if test="${not empty formError}">
			<div class="alert alert-danger">${formError}</div>
		</c:if>
		<form name="memberForm" action="${pageContext.request.contextPath}/memberControl?action=${mode eq 'edit' ? (isMyInfo ? 'processMyInfoUpdate' : 'processUpdateMember') : 'processAddMember'}" class="form-horizontal" method="post">
			<div class="form-group row">
				<label class="col-sm-2">회원 ID</label>
				<div class="col-sm-3">
					<input type="text" name="memberId" class="form-control" value="${member.memberId}" <c:if test="${mode eq 'edit'}">readonly</c:if> required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input type="password" name="password" class="form-control" value="" <c:if test="${mode ne 'edit'}">required</c:if> placeholder="${mode eq 'edit' ? '변경할 때만 입력' : '비밀번호 입력'}">
					<small class="form-text text-muted"><c:choose><c:when test="${mode eq 'edit'}">비워두면 기존 비밀번호를 유지합니다.</c:when><c:otherwise>입력한 비밀번호는 SHA-256 해시로 저장됩니다.</c:otherwise></c:choose></small>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">이름</label>
				<div class="col-sm-3">
					<input type="text" name="name" class="form-control" value="${member.name}" required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">전화번호</label>
				<div class="col-sm-3">
					<input type="text" name="phone" class="form-control" value="${member.phone}" required>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">스탬프 개수</label>
				<div class="col-sm-3">
					<input type="number" name="stampCount" class="form-control" value="${empty member.stampCount ? 0 : member.stampCount}" min="0" <c:if test="${allowStampEdit eq false}">readonly</c:if>>
					<c:if test="${allowStampEdit eq false}">
						<small class="form-text text-muted">스탬프 개수는 관리자만 수정할 수 있습니다.</small>
					</c:if>
				</div>
			</div>
			<c:if test="${allowAdminEdit ne false}">
				<div class="form-group row">
					<label class="col-sm-2">관리자 여부</label>
					<div class="col-sm-5">
						<input type="radio" name="adminYn" value="Y" <c:if test="${member.adminYn eq 'Y'}">checked</c:if>> 관리자
						<input type="radio" name="adminYn" value="N" <c:if test="${empty member.adminYn or member.adminYn eq 'N'}">checked</c:if>> 일반 회원
					</div>
				</div>
			</c:if>
			<div class="form-group row">
				<label class="col-sm-2">가입일</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" value="${empty member.joinDate ? '자동 입력' : member.joinDate}" readonly>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary" value="${mode eq 'edit' ? '수정' : '등록'}" >
					<c:choose>
						<c:when test="${isMyInfo}">
							<a href="${pageContext.request.contextPath}/memberControl?action=myInfo" class="btn btn-secondary">취소</a>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath}/memberControl?action=memberList" class="btn btn-secondary">목록</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
