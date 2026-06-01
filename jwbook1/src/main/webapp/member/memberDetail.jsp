<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="member.MemberDTO" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <title>회원 상세 정보</title>
</head>
<body>
    <div class="container" style="max-width:560px; margin-top:60px;">
        <%
            MemberDTO m = (MemberDTO) request.getAttribute("member");
        %>
        <h2 class="mb-4">회원 상세 정보</h2>

        <table class="table table-bordered">
            <tr>
                <th style="width:30%">아이디</th>
                <td><%= m.getMemberId() %></td>
            </tr>
            <tr>
                <th>이름</th>
                <td><%= m.getName() %></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><%= m.getPhone() %></td>
            </tr>
            <tr>
                <th>스탬프 개수</th>
                <td><%= m.getStampCount() %></td>
            </tr>
            <tr>
                <th>가입일</th>
                <td><%= m.getJoinDate() %></td>
            </tr>
        </table>

        <div class="mt-3">
            <a href="<%= request.getContextPath() %>/update?memberId=<%= m.getMemberId() %>"
               class="btn btn-warning">수정</a>
            <form action="<%= request.getContextPath() %>/delete" method="post" style="display:inline;"
                  onsubmit="return confirm('<%= m.getName() %> 회원을 삭제하시겠습니까?');">
                <input type="hidden" name="memberId" value="<%= m.getMemberId() %>">
                <button type="submit" class="btn btn-danger">삭제</button>
            </form>
            <a href="<%= request.getContextPath() %>/memberList" class="btn btn-secondary">목록으로</a>
        </div>
    </div>
</body>
</html>
