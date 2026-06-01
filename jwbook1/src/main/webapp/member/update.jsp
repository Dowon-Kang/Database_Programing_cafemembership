<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="member.MemberDTO" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <title>회원 정보 수정</title>
</head>
<body>
    <div class="container" style="max-width:480px; margin-top:60px;">
        <%
            MemberDTO m = (MemberDTO) request.getAttribute("member");
        %>
        <h2 class="mb-4">회원 정보 수정</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/update" method="post">
            <input type="hidden" name="memberId" value="<%= m.getMemberId() %>">

            <div class="form-group">
                <label>아이디</label>
                <input type="text" class="form-control" value="<%= m.getMemberId() %>" disabled>
            </div>
            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" class="form-control" name="password" value="<%= m.getPassword() %>" required>
            </div>
            <div class="form-group">
                <label>이름</label>
                <input type="text" class="form-control" name="name" value="<%= m.getName() %>" required>
            </div>
            <div class="form-group">
                <label>전화번호</label>
                <input type="text" class="form-control" name="phone" value="<%= m.getPhone() %>" required>
            </div>
            <div class="form-group">
                <label>스탬프 개수</label>
                <input type="number" class="form-control" name="stampCount" value="<%= m.getStampCount() %>" min="0" required>
            </div>
            <button type="submit" class="btn btn-warning btn-block">수정 완료</button>
            <a href="<%= request.getContextPath() %>/memberDetail?memberId=<%= m.getMemberId() %>"
               class="btn btn-secondary btn-block">취소</a>
        </form>
    </div>
</body>
</html>
