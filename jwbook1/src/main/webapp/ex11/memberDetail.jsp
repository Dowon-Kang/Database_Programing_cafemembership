<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <title>회원 상세 정보</title>
    <style>
        .detail-label { font-weight: bold; width: 150px; display: inline-block; }
        .info-container { background-color: #f8f9fa; padding: 20px; border-radius: 10px; margin-bottom: 20px; }
    </style>
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

                <div class="info-container">
                    <h3>${member.name} <small class="text-muted">님의 정보</small></h3>
                    <hr>
                    <p><span class="detail-label">회원 ID</span> : <span class="badge badge-primary">${member.memberId}</span></p>
                    <p><span class="detail-label">전화번호</span> : ${member.phone}</p>
                    <p><span class="detail-label">스탬프 개수</span> : <span class="badge badge-success">${member.stampCount} 개</span></p>
                    
                    <p><span class="detail-label">가입일</span> : 
                        <c:choose>
                            <c:when test="${not empty member.joinDate}">
                                <fmt:formatDate value="${member.joinDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </c:when>
                            <c:otherwise>
                                <span class="text-danger">정보 없음</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
                    
                    <p><span class="detail-label">관리자 여부</span> : ${member.adminYn}</p>
                </div>

                <div class="mt-4">
                    <%-- 1. 내 정보 페이지일 때 (본인) --%>
                    <c:if test="${isMyInfo}">
                        <a href="${pageContext.request.contextPath}/memberControl?action=editMyInfo" class="btn btn-primary">내 정보 수정 &raquo;</a>
                    </c:if>

                    <%-- 2. 관리자가 다른 회원을 볼 때 --%>
                    <c:if test="${sessionIsAdmin}">
                        <form method="post" action="${pageContext.request.contextPath}/memberControl" style="display:inline;">
                            <input type="hidden" name="action" value="processIncrementStamp">
                            <input type="hidden" name="id" value="${member.memberId}">
                            <input type="hidden" name="returnView" value="detail">
                            <button type="submit" class="btn btn-success">스탬프 +1</button>
                        </form>
                        
                        <a href="${pageContext.request.contextPath}/memberControl?action=editMember&id=${member.memberId}" class="btn btn-warning">회원 수정 &raquo;</a>
                        
                        <%-- 본인이 본인(관리자)을 삭제하지 못하도록 설정 --%>
                        <c:if test="${member.memberId ne sessionId}">
                            <a href="${pageContext.request.contextPath}/memberControl?action=deleteMember&id=${member.memberId}" class="btn btn-danger" onclick="return confirm('이 회원을 삭제하시겠습니까?');">회원 삭제 &raquo;</a>
                        </c:if>
                    </c:if>

                    <%-- 3. 돌아가기 버튼 --%>
                    <c:choose>
                        <c:when test="${isMyInfo}">
                            <a href="${pageContext.request.contextPath}/memberControl?action=welcomeUser" class="btn btn-secondary">홈으로 &raquo;</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/memberControl?action=memberList" class="btn btn-secondary">회원 목록으로 &raquo;</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <hr>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>