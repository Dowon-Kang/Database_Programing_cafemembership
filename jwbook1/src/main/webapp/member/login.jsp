<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <title>로그인</title>
</head>
<body>
    <div class="container" style="max-width:480px; margin-top:60px;">
        <h2 class="mb-4">카페 멤버십 로그인</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/login" method="post">
            <div class="form-group">
                <label>아이디</label>
                <input type="text" class="form-control" name="memberId" required autofocus>
            </div>
            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" class="form-control" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">로그인</button>
            <a href="<%= request.getContextPath() %>/register" class="btn btn-secondary btn-block">회원가입</a>
        </form>
    </div>
</body>
</html>
