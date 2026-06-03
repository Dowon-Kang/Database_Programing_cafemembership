<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date"%>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&family=Playfair+Display:ital,wght@0,700;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <title>Welcome - 카페 멤버십 관리 시스템</title>
    
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fcfbfa;
            color: #3e332e;
        }
        
        /* 히어로 섹션 (구 jumbotron 개조) */
        .hero-banner {
            background: linear-gradient(135deg, #4a3728 0%, #2b1e15 100%);
            color: #f7f3e9;
            padding: 5rem 2rem;
            text-align: center;
            border-bottom: 4px solid #d4b296;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .hero-title {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            letter-spacing: -1px;
            margin-bottom: 1rem;
        }
        
        .hero-subtitle {
            font-size: 1.25rem;
            color: #d4b296;
            font-weight: 300;
        }
        
        /* 메인 콘텐츠 카드 */
        .welcome-card {
            background: #ffffff;
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(74, 55, 40, 0.05);
            padding: 3.5rem 2rem;
            margin-top: -3rem; /* 배너 위로 살짝 겹치는 트렌디한 효과 */
            position: relative;
            z-index: 10;
        }
        
        .brand-logo {
            font-size: 3.5rem;
            color: #a07855;
            margin-bottom: 1.5rem;
            animation: float 3s ease-in-out infinite;
        }
        
        /* 은은한 아이콘 둥둥 뜨는 애니메이션 */
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }
        
        /* 바로가기 버튼 스타일 */
        .btn-cafe {
            background-color: #a07855;
            color: #ffffff;
            border: none;
            border-radius: 30px;
            padding: 0.75rem 2rem;
            font-weight: 700;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(160, 120, 85, 0.3);
        }
        
        .btn-cafe:hover {
            background-color: #7c5a3c;
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(160, 120, 85, 0.4);
        }
        
        .btn-outline-cafe {
            border: 2px solid #a07855;
            color: #a07855;
            border-radius: 30px;
            padding: 0.70rem 2rem;
            font-weight: 700;
            transition: all 0.3s ease;
        }
        
        .btn-outline-cafe:hover {
            background-color: #a07855;
            color: #ffffff;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp"/>
    
    <div class="hero-banner">
        <div class="container">
            <h1 class="display-4 hero-title">Cafe Membership</h1>
            <p class="hero-subtitle">더 스마트하고 특별한 고객 관리의 시작</p>
        </div>
    </div>	
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                
                <div class="welcome-card text-center">
                    <div class="brand-logo">
                        <i class="fas fa-coffee"></i>
                    </div>
                    
                    <h2 class="mb-3 font-weight-bold" style="color: #2b1e15;">
                        Welcome to Cafe Manager
                    </h2>
                    
                    <p class="text-muted mb-5 leading-relaxed">
                        카페 멤버십 관리 시스템에 오신 것을 환영합니다.<br>
                        회원 등록, 스탬프 적립, 실시간 명단 조회까지 간편하게 관리해 보세요.
                    </p>
                    
                    <div class="d-flex justify-content-center flex-wrap" style="gap: 15px;">
                        <a href="${pageContext.request.contextPath}/memberControl?action=memberList" class="btn btn-cafe">
                            <i class="fas fa-users mr-2"></i>회원 목록 보기
                        </a>
                        <a href="${pageContext.request.contextPath}/memberControl?action=addMember" class="btn btn-outline-cafe">
                            <i class="fas fa-user-plus mr-2"></i>신규 회원 등록
                        </a>
                    </div>
                </div>
                
            </div>
        </div>
        <div class="my-5 py-2"></div>
    </div>	
    
    <jsp:include page="footer.jsp" />
</body>
</html>