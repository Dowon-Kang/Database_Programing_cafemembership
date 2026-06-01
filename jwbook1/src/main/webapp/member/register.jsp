<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <title>회원가입</title>
</head>
<body>
    <div class="container" style="max-width:480px; margin-top:60px;">
        <h2 class="mb-4">회원가입</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/register" method="post">
            <div class="form-group">
                <label>아이디</label>
                <input type="text" class="form-control" name="memberId" required>
            </div>
            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" class="form-control" name="password" required>
            </div>
            <div class="form-group">
                <label>이름</label>
                <input type="text" class="form-control" name="name" required>
            </div>
            <div class="form-group">
                <label>전화번호</label>
                <input type="text" class="form-control" name="phone" placeholder="010-0000-0000" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">가입하기</button>
            <a href="<%= request.getContextPath() %>/login" class="btn btn-secondary btn-block">로그인으로 돌아가기</a>
        </form>
    </div>
</body>
</html>
