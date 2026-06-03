<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ex11.Member" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <title>회원 목록 - 카페 멤버십 시스템</title>
    
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fcfbfa; /* 따뜻한 아이보리 배경 */
            color: #3e332e;
        }
        
        /* 상단 타이틀 배너 */
        .hero-banner {
            background: linear-gradient(135deg, #4a3728 0%, #2b1e15 100%);
            color: #f7f3e9;
            padding: 3.5rem 2rem;
            text-align: center;
            border-bottom: 3px solid #d4b296;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .hero-title {
            font-weight: 700;
            font-size: 2.3rem;
            letter-spacing: -1px;
        }

        /* 메인 대시보드 컨테이너 카드 */
        .list-card {
            background: #ffffff;
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(74, 55, 40, 0.06);
            padding: 2.5rem;
            margin-top: 2.5rem;
        }

        /* 검색창 커스텀 디자인 */
        .search-box {
            border-radius: 8px 0 0 8px !important;
            border: 1px solid #e1dbd6;
            background-color: #fdfdfd;
            height: 42px;
            transition: all 0.2s ease;
        }
        .search-box:focus {
            border-color: #a07855;
            box-shadow: 0 0 0 0.2rem rgba(160, 120, 85, 0.15);
        }

        .btn-cafe-search {
            background-color: #a07855;
            color: white !important;
            border: none;
            border-radius: 0 8px 8px 0 !important;
            padding: 0 1.5rem;
            font-weight: 700;
            height: 42px;
            transition: all 0.2s;
        }
        .btn-cafe-search:hover { background-color: #7c5a3c; }

        .btn-cafe-reset {
            background-color: #ece5df;
            color: #4a3728 !important;
            border: none;
            border-radius: 8px !important;
            padding: 0 1.2rem;
            font-weight: 500;
            height: 42px;
            display: inline-flex;
            align-items: center;
            transition: all 0.2s;
        }
        .btn-cafe-reset:hover { background-color: #decbc0; }

        /* 테이블 모던 스타일 레이아웃 */
        .custom-table {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            margin-top: 1rem;
        }
        
        .custom-table thead th {
            background-color: #f5f0eb !important;
            color: #4a3728;
            font-weight: 700;
            border-top: 1px solid #e1dbd6 !important;
            border-bottom: 2px solid #d4b296 !important;
            padding: 1rem;
            text-align: center;
            vertical-align: middle;
        }

        .custom-table tbody td {
            padding: 1rem;
            vertical-align: middle !important;
            text-align: center;
            border-bottom: 1px solid #ece5df;
            color: #2b1e15;
        }

        .custom-table tbody tr:hover {
            background-color: #faf8f5 !important;
        }

        /* 테이블 내 미니 프로필 이미지 */
        .table-avatar {
            width: 44px;
            height: 44px;
            object-fit: cover;
            border-radius: 50%;
            border: 2px solid #ece5df;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }

        .table-avatar-empty {
            font-size: 2.2rem;
            color: #d4b296;
            vertical-align: middle;
        }

        /* ID 뱃지 */
        .id-badge {
            background-color: #4a3728;
            color: #f7f3e9;
            padding: 0.2rem 0.5rem;
            border-radius: 5px;
            font-family: 'Courier New', Courier, monospace;
            font-size: 0.9rem;
            font-weight: 600;
        }

        /* 스탬프 개수 원형 엠블럼 */
        .stamp-count-badge {
            background-color: #fdf5ef;
            color: #a07855;
            border: 1px solid #d4b296;
            padding: 0.25rem 0.6rem;
            border-radius: 12px;
            font-weight: 700;
            font-size: 0.95rem;
        }

        /* 액션 버튼 그룹 */
        .table-action-btn {
            border-radius: 6px;
            padding: 0.35rem 0.8rem;
            font-weight: 700;
            font-size: 0.85rem;
            margin: 2px;
            transition: all 0.2s;
        }
    </style>
</head>

<body>

    <jsp:include page="menu.jsp" />

    <div class="hero-banner">
        <div class="container">
            <h1 class="hero-title">카페 멤버십 회원 목록</h1>
        </div>
    </div>

    <div class="container">
        <c:if test="${not empty authError}">
            <div class="alert alert-danger mt-4"><i class="fas fa-exclamation-circle mr-2"></i>${authError}</div>
        </c:if>
        <c:if test="${not empty listError}">
            <div class="alert alert-danger mt-4"><i class="fas fa-exclamation-circle mr-2"></i>${listError}</div>
        </c:if>
        <c:if test="${not empty listMessage}">
            <div class="alert alert-success mt-4"><i class="fas fa-check-circle mr-2"></i>${listMessage}</div>
        </c:if>

        <div class="list-card">
            
            <form class="form-inline mb-4 justify-content-start" method="get" action="${pageContext.request.contextPath}/memberControl">
                <input type="hidden" name="action" value="memberList">
                <div class="input-group">
                    <input type="text" name="keyword" class="form-control search-box" value="${searchKeyword}" placeholder="아이디, 이름, 전화번호 검색" style="width: 280px;">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-cafe-search">
                            <i class="fas fa-search mr-1"></i>검색
                        </button>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/memberControl?action=memberList" class="btn btn-cafe-reset ml-2">
                    <i class="fas fa-sync-alt mr-1"></i>초기화
                </a>
            </form>

            <%
                List<Member> members = (List<Member>)request.getAttribute("members");
                if (members == null || members.size() == 0) {
            %>
                <div class="alert alert-info py-4 text-center" style="background-color: #fdfdfd; border: 1px dashed #d4b296; color: #7c6252; border-radius: 12px;">
                    <i class="fas fa-search-minus mb-2" style="font-size: 2rem; color: #d4b296; display: block;"></i>
                    검색 조건에 일치하는 등록된 카페 회원이 존재하지 않습니다.
                </div>
            <%
                } else {
            %>
                <div class="table-responsive">
                    <table class="table custom-table">
                        <thead>
                            <tr>
                                <th style="width: 80px;">프로필</th>
                                <th>회원 ID</th>
                                <th>이름</th>
                                <th>전화번호</th>
                                <th style="width: 100px;">스탬프</th>
                                <th>가입일자</th>
                                <th style="width: 240px;">데이터 관리</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            for (Member member : members) {
                        %>
                            <tr>
                                <td>
                                    <% if (member.getImageUrl() != null && !member.getImageUrl().trim().isEmpty()) { %>
                                        <img src="<%= member.getImageUrl() %>" alt="프로필" class="table-avatar">
                                    <% } else { %>
                                        <i class="fas fa-user-circle table-avatar-empty"></i>
                                    <% } %>
                                </td>
                                
                                <td><span class="id-badge"><%= member.getMemberId() %></span></td>
                                <td class="font-weight-bold"><%= member.getName() %></td>
                                <td><%= member.getPhone() %></td>
                                
                                <td>
                                    <span class="stamp-count-badge">
                                        <i class="fas fa-stamp text-warning mr-1" style="font-size:0.85rem;"></i><%= member.getStampCount() %>
                                    </span>
                                </td>
                                <td class="text-muted" style="font-size:0.9rem;"><%= member.getJoinDate() %></td>
                                
                                <td>
                                    <a href="<%= request.getContextPath() %>/memberControl?action=memberDetail&id=<%= member.getMemberId() %>" class="btn btn-sm btn-info table-action-btn">
                                        <i class="fas fa-eye mr-1"></i>상세
                                    </a>
                                    
                                    <% if (Boolean.TRUE.equals(session.getAttribute("sessionIsAdmin"))) { %>
                                        <form method="post" action="<%= request.getContextPath() %>/memberControl" style="display:inline; margin: 0;">
                                            <input type="hidden" name="action" value="processIncrementStamp">
                                            <input type="hidden" name="id" value="<%= member.getMemberId() %>">
                                            <input type="hidden" name="keyword" value="<%= request.getAttribute("searchKeyword") == null ? "" : request.getAttribute("searchKeyword") %>">
                                            <button type="submit" class="btn btn-sm btn-success table-action-btn">
                                                <i class="fas fa-plus mr-1"></i>스탬프
                                            </button>
                                        </form>
                                        
                                        <a href="<%= request.getContextPath() %>/memberControl?action=editMember&id=<%= member.getMemberId() %>" class="btn btn-sm btn-warning table-action-btn" style="color:#2b1e15 !important;">
                                            <i class="fas fa-edit mr-1"></i>수정
                                        </a>
                                        
                                        <% if (!member.isAdmin()) { %>
                                            <a href="<%= request.getContextPath() %>/memberControl?action=deleteMember&id=<%= member.getMemberId() %>" class="btn btn-sm btn-danger table-action-btn" onclick="return confirm('이 회원을 정말로 영구 삭제하시겠습니까?');">
                                                <i class="fas fa-trash-alt mr-1"></i>삭제
                                            </a>
                                        <% } %>
                                    <% } %>
                                </td>
                            </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            <%
                }
            %>
        </div>
        <div class="my-5 py-1"></div>
    </div>

    <jsp:include page="footer.jsp" />

</body>
</html>