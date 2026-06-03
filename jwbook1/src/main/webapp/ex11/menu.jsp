<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<nav class="navbar navbar-expand navbar-dark bg-dark">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/memberControl?action=welcome">Home</a>
        </div>
        
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav mr-auto">
                <c:choose>
                    <%-- 1. 로그인 전 (비회원 상태) --%>
                    <c:when test="${empty sessionId}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/memberControl?action=login">로그인</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/memberControl?action=addMember">회원등록</a>
                        </li>
                    </c:when>

                    <%-- 2. 로그인 후 (일반 회원 & 관리자 공통 메뉴) --%>
                    <c:otherwise>
                        <li class="nav-item">
                            <span class="nav-link" style="color: white; font-weight: bold;">[${sessionName}님]</span>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/memberControl?action=myInfo">내 정보</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/memberControl?action=processLogout">로그아웃</a>
                        </li>

                        <%-- 3. 관리자 계정일 때만 추가로 보이는 메뉴 --%>
                        <c:if test="${sessionIsAdmin == true}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/memberControl?action=memberList">회원목록</a>
                            </li>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>