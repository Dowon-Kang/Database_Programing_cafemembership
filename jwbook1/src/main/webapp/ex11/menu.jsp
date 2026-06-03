<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
    /* 메뉴 바 기본 베이스 디자인 */
    .custom-navbar {
        background-color: #2b1e15 !important; /* 깊은 에스프레소 브라운 */
        border-bottom: 2px solid #d4b296;    /* 은은한 라떼 베이지 라인 */
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        padding: 0.8rem 1rem;
    }

    /* 로고 스타일 (Home) */
    .custom-navbar .navbar-brand {
        font-family: 'Playfair Display', serif;
        font-weight: 700;
        color: #f7f3e9 !important;
        letter-spacing: 1px;
        transition: all 0.3s ease;
    }
    
    .custom-navbar .navbar-brand:hover {
        color: #d4b296 !important;
        transform: scale(1.05);
    }

    /* 일반 메뉴 링크 스타일 */
    .custom-navbar .nav-link {
        color: #e5dec9 !important; /* 부드러운 밀크티 색상 */
        font-weight: 500;
        padding: 0.5rem 1rem !important;
        transition: all 0.2s ease-in-out;
        border-radius: 20px;
    }

    /* 마우스 올렸을 때 효과 */
    .custom-navbar .nav-link:hover {
        color: #2b1e15 !important;
        background-color: #d4b296; /* 베이지 배경으로 반전 */
    }

    /* 사용자 정보 텍스트 (몇님 환영합니다) */
    .user-info-text {
        font-size: 0.95rem;
        color: #f7f3e9;
        background-color: rgba(212, 178, 150, 0.15); /* 은은한 투명 베이지 박스 */
        padding: 0.4rem 1rem;
        border-radius: 20px;
        border: 1px solid rgba(212, 178, 150, 0.3);
        display: inline-block;
    }
    
    .user-info-text i {
        color: #d4b296;
    }

    /* 관리자 뱃지 스타일 */
    .admin-badge {
        background-color: #a07855;
        color: #ffffff;
        font-size: 0.75rem;
        padding: 0.15rem 0.5rem;
        border-radius: 10px;
        font-weight: bold;
        vertical-align: middle;
    }
</style>

<nav class="navbar navbar-expand custom-navbar">
    <div class="container">
        <a class="navbar-brand" href="/jwbook1/memberControl?action=welcome">
            <i class="fas fa-coffee mr-2"></i>Cafe Home
        </a>
        
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav align-items-center" style="gap: 8px;">
                <c:choose>
                    <%-- 로그인하지 않은 상태 --%>
                    <c:when test="${empty sessionId}">
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/memberControl?action=login'/>">
                                <i class="fas fa-sign-in-alt mr-1"></i>로그인
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/memberControl?action=signup'/>">
                                <i class="fas fa-user-plus mr-1"></i>회원가입
                            </a>
                        </li>
                    </c:when>
                    
                    <%-- 로그인 완료된 상태 --%>
                    <c:otherwise>
                        <li class="nav-item mr-2">
                            <span class="user-info-text">
                                <i class="fas fa-user mr-2"></i>${sessionName}님
                                <c:if test="${sessionIsAdmin}">
                                    <span class="admin-badge ml-1">Admin</span>
                                </c:if>
                            </span>
                        </li>	
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/memberControl?action=myInfo'/>">
                                <i class="fas fa-id-card mr-1"></i>내 정보
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/memberControl?action=processLogout'/>">
                                <i class="fas fa-sign-out-alt mr-1"></i>로그아웃
                            </a>
                        </li>		
                    </c:otherwise>
                </c:choose>
                
                <%-- 관리자 전용 메뉴 --%>
                <c:if test="${sessionIsAdmin}">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/memberControl?action=memberList'/>">
                            <i class="fas fa-list-ul mr-1"></i>회원목록
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/memberControl?action=addMember'/>">
                            <i class="fas fa-user-cog mr-1"></i>회원등록
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>