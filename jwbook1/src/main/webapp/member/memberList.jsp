<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="member.MemberDTO" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <title>회원 목록</title>
</head>
<body>
    <div class="container" style="margin-top:40px;">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2>회원 목록</h2>
            <div>
                <a href="<%= request.getContextPath() %>/register" class="btn btn-primary">신규 회원 등록</a>
                <form action="<%= request.getContextPath() %>/logout" method="post" style="display:inline;">
                    <button type="submit" class="btn btn-secondary">로그아웃</button>
                </form>
            </div>
        </div>

        <form action="<%= request.getContextPath() %>/search" method="get" class="form-inline mb-3">
            <input type="text" class="form-control mr-2" name="keyword" placeholder="이름 또는 전화번호">
            <button type="submit" class="btn btn-outline-primary">검색</button>
        </form>

        <%
            List<MemberDTO> memberList = (List<MemberDTO>) request.getAttribute("memberList");
            if (memberList == null || memberList.isEmpty()) {
        %>
            <p>등록된 회원이 없습니다.</p>
        <%
            } else {
        %>
        <table class="table table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>스탬프</th>
                    <th>가입일</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <% for (MemberDTO m : memberList) { %>
                <tr>
                    <td><%= m.getMemberId() %></td>
                    <td><%= m.getName() %></td>
                    <td><%= m.getPhone() %></td>
                    <td><%= m.getStampCount() %></td>
                    <td><%= m.getJoinDate() %></td>
                    <td>
                        <a href="<%= request.getContextPath() %>/memberDetail?memberId=<%= m.getMemberId() %>"
                           class="btn btn-sm btn-info">상세</a>
                        <a href="<%= request.getContextPath() %>/update?memberId=<%= m.getMemberId() %>"
                           class="btn btn-sm btn-warning">수정</a>
                        <form action="<%= request.getContextPath() %>/delete" method="post" style="display:inline;"
                              onsubmit="return confirm('<%= m.getName() %> 회원을 삭제하시겠습니까?');">
                            <input type="hidden" name="memberId" value="<%= m.getMemberId() %>">
                            <button type="submit" class="btn btn-sm btn-danger">삭제</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } %>
    </div>
</body>
</html>
