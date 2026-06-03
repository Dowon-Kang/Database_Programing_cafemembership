<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <title>회원 목록</title>
</head>
<body>
    <jsp:include page="menu.jsp" />
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">회원 목록</h1>
        </div>
    </div>

    <div class="container">
        <form action="./memberControl" method="get" class="form-inline mb-3">
            <input type="hidden" name="action" value="memberList">
            <input type="text" name="keyword" class="form-control mr-sm-2" placeholder="이름 또는 ID 검색" value="${param.keyword}">
            <button class="btn btn-outline-success" type="submit">검색</button>
        </form>

        <table class="table table-hover">
            <thead class="thead-light">
                <tr>
                    <th>아이디</th><th>이름</th><th>전화번호</th><th>스탬프</th><th>가입일</th><th>비고</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="member" items="${members}">
                    <tr>
                        <td>${member.memberId}</td>
                        <td><a href="./memberControl?action=memberDetail&id=${member.memberId}">${member.name}</a></td>
                        <td>${member.phone}</td>
                        <td><span class="badge badge-info">${member.stampCount}</span></td>
                        <td><fmt:formatDate value="${member.joinDate}" pattern="yyyy-MM-dd"/></td>
                        <td>
                            <form action="./memberControl" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="processIncrementStamp">
                                <input type="hidden" name="id" value="${member.memberId}">
                                <button type="submit" class="btn btn-sm btn-success">스탬프+1</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>