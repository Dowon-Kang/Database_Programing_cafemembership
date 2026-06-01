<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<nav class="navbar navbar-expand  navbar-dark bg-dark">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="/jwbook1/memberControl?action=welcome">Home</a>
		</div>	
		<div>
			<ul class="navbar-nav mr-auto">
				<c:choose>
					<c:when test="${empty sessionId}">
						<li class="nav-item"><a class="nav-link" href="<c:url value="/memberControl?action=login"/>">로그인 </a></li>
					</c:when>
					<c:otherwise>
						<li style="padding-top: 7px; color: white">[${sessionName}님<c:if test="${sessionIsAdmin}"> | 관리자</c:if>]</li>	
						<li class="nav-item"><a class="nav-link" href="<c:url value="/memberControl?action=myInfo"/>">내 정보</a></li>
						<li class="nav-item"><a class="nav-link" href="<c:url value="/memberControl?action=processLogout"/>">로그아웃</a></li>		
					</c:otherwise>
				</c:choose>
				<c:if test="${sessionIsAdmin}">
					<li class="nav-item"><a class="nav-link" href="<c:url value="/memberControl?action=memberList"/>">회원목록</a></li>
					<li class="nav-item"><a class="nav-link" href="<c:url value="/memberControl?action=addMember"/>">회원등록</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</nav>