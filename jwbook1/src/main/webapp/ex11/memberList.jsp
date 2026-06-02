<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ex11.Member" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

    <title>회원 목록</title>
</head>

<body>

    <jsp:include page="menu.jsp" />

    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">카페 멤버십 회원 목록</h1>
        </div>
    </div>

    <div class="container">
        <c:if test="${not empty authError}">
            <div class="alert alert-danger">${authError}</div>
        </c:if>
        <c:if test="${not empty listError}">
            <div class="alert alert-danger">${listError}</div>
        </c:if>
        <c:if test="${not empty listMessage}">
            <div class="alert alert-success">${listMessage}</div>
        </c:if>
		<form class="form-inline mb-3" method="get" action="${pageContext.request.contextPath}/memberControl">
			<input type="hidden" name="action" value="memberList">
			<input type="text" name="keyword" class="form-control mr-2" value="${searchKeyword}" placeholder="아이디, 이름, 전화번호 검색">
			<button type="submit" class="btn btn-primary mr-2">검색</button>
			<a href="${pageContext.request.contextPath}/memberControl?action=memberList" class="btn btn-outline-secondary">초기화</a>
		</form>
        <%
            List<Member> members = (List<Member>)request.getAttribute("members");
            if (members == null || members.size() == 0) {
        %>
            <div class="alert alert-info">검색 조건에 맞는 회원이 없습니다.</div>
        <%
            } else {
        %>
            <table class="table table-bordered table-hover">
                <thead class="thead-light">
                    <tr>
                        <th>프로필</th>
                        <th>회원 ID</th>
                        <th>이름</th>
                        <th>전화번호</th>
                        <th>스탬프</th>
                        <th>가입일</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (Member member : members) {
                %>
                    <tr>
                        <td>
                            <% if (member.getImageUrl() != null && !member.getImageUrl().trim().isEmpty()) { %>
                            <img src="<%= member.getImageUrl() %>" alt="프로필" style="width:48px; height:48px; object-fit:cover; border-radius:50%;">
                            <% } else { %>
                            <span class="text-muted">없음</span>
                            <% } %>
                        </td>
                        <td><%= member.getMemberId() %></td>
                        <td><%= member.getName() %></td>
                        <td><%= member.getPhone() %></td>
                        <td><%= member.getStampCount() %></td>
                        <td><%= member.getJoinDate() %></td>
                        <td>
                            <a href="<%= request.getContextPath() %>/memberControl?action=memberDetail&id=<%= member.getMemberId() %>" class="btn btn-sm btn-info">상세</a>
                            <% if (Boolean.TRUE.equals(session.getAttribute("sessionIsAdmin"))) { %>
                            <form method="post" action="<%= request.getContextPath() %>/memberControl" style="display:inline;">
                                <input type="hidden" name="action" value="processIncrementStamp">
                                <input type="hidden" name="id" value="<%= member.getMemberId() %>">
                                <input type="hidden" name="keyword" value="<%= request.getAttribute("searchKeyword") == null ? "" : request.getAttribute("searchKeyword") %>">
                                <button type="submit" class="btn btn-sm btn-success">스탬프 +1</button>
                            </form>
                            <a href="<%= request.getContextPath() %>/memberControl?action=editMember&id=<%= member.getMemberId() %>" class="btn btn-sm btn-warning">수정</a>
                            <% if (!member.isAdmin()) { %>
                            <a href="<%= request.getContextPath() %>/memberControl?action=deleteMember&id=<%= member.getMemberId() %>" class="btn btn-sm btn-danger" onclick="return confirm('이 회원을 삭제하시겠습니까?');">삭제</a>
                            <% } %>
                            <% } %>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        <%
            }
        %>

        <hr>
    </div>

    <jsp:include page="footer.jsp" />

</body>
</html>
