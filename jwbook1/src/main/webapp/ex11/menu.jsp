<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<nav class="navbar navbar-expand  navbar-dark bg-dark">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="/jwbook1/bm3control?action=welcome">Home</a>
		</div>	
		<div>
			<ul class="navbar-nav mr-auto">
				<c:choose>
					<c:when test="${empty sessionId}">
						<li class="nav-item"><a class="nav-link" href="<c:url value="/bm3control?action=login"/>">로그인 </a></li>
					</c:when>
					<c:otherwise>
						<li style="padding-top: 7px; color: white">[${sessionId}님]</li>	
						<li class="nav-item"><a class="nav-link" href="<c:url value="/bm3control?action=processLogout"/>">로그아웃</a></li>		
					</c:otherwise>
				</c:choose>
				<li class="nav-item"><a class="nav-link" href="<c:url value="/bm3control?action=productInfoList"/>">도서목록</a></li>
				<li class="nav-item"><a class="nav-link" href="<c:url value="/bm3control?action=addProduct"/>">도서등록</a></li>
			</ul>
		</div>
	</div>
</nav>