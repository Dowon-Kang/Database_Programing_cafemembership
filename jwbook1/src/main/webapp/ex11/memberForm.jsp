<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 양식</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">
				<c:choose>
					<c:when test="${mode == 'create'}">회원 등록</c:when>
					<c:otherwise>회원 정보 수정</c:otherwise>
				</c:choose>
			</h1>
		</div>
	</div>

	<div class="container">
		<c:if test="${not empty formError}">
			<div class="alert alert-danger">${formError}</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/memberControl" method="post">
			<input type="hidden" name="action" value="${mode == 'create' ? 'processAddMember' : 'processUpdateMember'}">
			
			<div class="form-group row">
				<label class="col-sm-2">아이디</label>
				<div class="col-sm-3">
					<input type="text" name="memberId" class="form-control" value="${member.memberId}" ${mode == 'edit' ? 'readonly' : ''} required>
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input type="password" name="password" class="form-control" value="${member.password}" required>
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
					<input type="text" name="phone" class="form-control" value="${member.phone}">
				</div>
			</div>

			<%-- 수정 모드(관리자가 수정할 때)에서만 보이는 칸들 --%>
			<c:if test="${mode == 'edit'}">
				<div class="form-group row">
					<label class="col-sm-2">스탬프 개수</label>
					<div class="col-sm-3">
						<input type="number" name="stampCount" class="form-control" value="${member.stampCount}" ${sessionIsAdmin ? '' : 'readonly'}>
					</div>
				</div>

				<c:if test="${sessionIsAdmin}">
					<div class="form-group row">
						<label class="col-sm-2">관리자 여부 (Y/N)</label>
						<div class="col-sm-3">
							<input type="text" name="adminYn" class="form-control" value="${member.adminYn}">
						</div>
					</div>
				</c:if>
			</c:if>

			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="submit" class="btn btn-primary" value="${mode == 'create' ? '등록' : '수정'}">
					<a href="${pageContext.request.contextPath}/memberControl?action=welcome" class="btn btn-secondary">취소</a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>