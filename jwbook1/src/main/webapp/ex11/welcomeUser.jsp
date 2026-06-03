<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&family=Playfair+Display:ital,wght=0,700;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <title>Welcome - 카페 멤버십 관리 시스템</title>
    
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fcfbfa;
            color: #3e332e;
        }
        
        /* 히어로 섹션 (그라데이션 배너) */
        .hero-banner {
            background: linear-gradient(135deg, #4a3728 0%, #2b1e15 100%);
            color: #f7f3e9;
            padding: 5rem 2rem;
            text-align: center;
            border-bottom: 4px solid #d4b296;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .hero-title {
            font-weight: 700;
            letter-spacing: -1px;
            margin-bottom: 0.5rem;
        }
        
        .hero-title .user-name {
            color: #d4b296; /* 기존 blue 대신 세련된 포인트 베이지로 변경 */
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
        }
        
        .hero-subtitle {
            font-size: 1.15rem;
            color: #e5dec9;
            font-weight: 300;
        }
        
        /* 대시보드 웰컴 카드 */
        .welcome-card {
            background: #ffffff;
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(74, 55, 40, 0.05);
            padding: 3rem 2rem;
            margin-top: -3rem; /* 배너 위로 살짝 겹치는 트렌디한 효과 */
            position: relative;
            z-index: 10;
        }
        
        /* 원형 프로필 이미지 프레임 */
        .profile-img-wrapper {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            overflow: hidden;
            border: 4px solid #fdfdfd;
            box-shadow: 0 6px 15px rgba(160, 120, 85, 0.15);
            background-color: #f5f0eb;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
        }
        
        .profile-img-fallback {
            font-size: 5rem;
            color: #d4b296;
        }
        
        /* 유저 명세 정보 뱃지 박스 */
        .user-spec-box {
            background-color: #fbf9f6;
            border: 1px solid #f2ebe6;
            border-radius: 12px;
            padding: 1.25rem;
            max-width: 380px;
            margin: 1.5rem auto 2.5rem auto;
        }
        
        .spec-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.4rem 0;
            font-size: 1rem;
        }
        
        .spec-item:not(:last-child) {
            border-bottom: 1px dashed #e6e0da;
        }
        
        .spec-label {
            color: #7c6252;
            font-weight: 500;
        }
        
        .spec-value {
            color: #2b1e15;
            font-weight: 700;
        }
        
        /* 권한 별 라벨 등급 뱃지 */
        .role-badge {
            padding: 0.25rem 0.6rem;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: bold;
        }
        .role-admin {
            background-color: #a07855;
            color: #ffffff;
        }
        .role-member {
            background-color: #ece5df;
            color: #4a3728;
        }
        
        /* 내 정보 보기 바로가기 버튼 */
        .btn-cafe {
            background-color: #a07855;
            color: #ffffff;
            border: none;
            border-radius: 30px;
            padding: 0.75rem 2.5rem;
            font-weight: 700;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(160, 120, 85, 0.3);
            display: inline-block;
        }
        
        .btn-cafe:hover {
            background-color: #7c5a3c;
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(160, 120, 85, 0.4);
            text-decoration: none;
        }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp"/>
    
    <div class="hero-banner">
        <div class="container">
            <h1 class="display-4 hero-title">
                <span class="user-name">${sessionName}</span>님 환영합니다!
            </h1>
            <p class="hero-subtitle">오늘도 향기로운 커피 한 잔과 함께 즐거운 시간 보내세요.</p>
        </div>
    </div>	
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                
                <div class="welcome-card text-center">
                    
                    <c:if test="${not empty authError}">
                        <div class="alert alert-danger max-width-380 mx-auto text-left mb-4">
                            <i class="fas fa-exclamation-circle mr-2"></i>${authError}
                        </div>
                    </c:if>
                    
                    <div class="profile-img-wrapper">
                        <c:choose>
                            <c:when test="${not empty sessionImageUrl}">
                                <img src="${sessionImageUrl}" alt="프로필 이미지" style="width: 100%; height: 100%; object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-user-circle profile-img-fallback"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <h3 class="font-weight-bold" style="color: #2b1e15;">Welcome Back!</h3>
                    <p class="text-muted small">Cafe Membership Management System</p>
                    
                    <div class="user-spec-box text-left">
                        <div class="spec-item">
                            <span class="spec-label"><i class="fas fa-id-badge mr-2" style="color:#a07855;"></i>회원 계정(ID)</span>
                            <span class="spec-value" style="font-family:'Courier New', monospace;">${sessionId}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label"><i class="fas fa-user-shield mr-2" style="color:#a07855;"></i>접근 권한 등급</span>
                            <span class="spec-value">
                                <c:choose>
                                    <c:when test="${sessionIsAdmin}">
                                        <span class="role-badge role-admin"><i class="fas fa-crown mr-1"></i>관리자</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="role-badge role-member"><i class="fas fa-coffee mr-1"></i>일반 회원</span>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                    
                    <c:if test="${not sessionIsAdmin}">
                        <div class="mt-2">
                            <a href="${pageContext.request.contextPath}/memberControl?action=myInfo" class="btn btn-cafe">
                                <i class="fas fa-user-cog mr-2"></i>내 정보 확인하기
                            </a>
                        </div>
                    </c:if>
                    
                </div>
                
            </div>
        </div>
        <div class="my-5 py-2"></div>
    </div>	
    
    <jsp:include page="footer.jsp" />
</body>
</html>