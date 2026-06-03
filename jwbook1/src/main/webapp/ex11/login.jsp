<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <title>로그인 - 카페 멤버십 시스템</title>
    
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fcfbfa; /* 부드러운 아이보리 톤 배경 */
            color: #3e332e;
        }
        
        /* 점보트론 개조 */
        .hero-banner {
            background: linear-gradient(135deg, #4a3728 0%, #2b1e15 100%);
            color: #f7f3e9;
            padding: 3.5rem 2rem;
            text-align: center;
            border-bottom: 3px solid #d4b296;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .hero-title {
            font-family: 'Noto Sans KR', sans-serif;
            font-weight: 700;
            font-size: 2.5rem;
            letter-spacing: -1px;
        }

        /* 로그인 카드 상자 */
        .login-card {
            background: #ffffff;
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(74, 55, 40, 0.06);
            padding: 2.5rem 2rem;
            margin-top: 2.5rem;
            max-width: 420px;
            width: 100%;
        }

        .login-icon {
            font-size: 2.5rem;
            color: #a07855;
            margin-bottom: 1rem;
        }

        /* 입력창 커스텀 디자인 */
        .custom-input-group {
            position: relative;
            margin-bottom: 1.25rem;
        }

        .custom-input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #a07855;
            z-index: 10;
        }

        .custom-input {
            padding-left: 45px !important;
            height: 50px;
            border-radius: 8px;
            border: 1px solid #e1dbd6;
            background-color: #fdfdfd;
            transition: all 0.2s ease;
        }

        .custom-input:focus {
            border-color: #a07855;
            box-shadow: 0 0 0 0.2rem rgba(160, 120, 85, 0.15);
            background-color: #ffffff;
        }

        /* 버튼 커스텀 */
        .btn-cafe-submit {
            background-color: #a07855;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            height: 50px;
            font-weight: 700;
            font-size: 1.1rem;
            transition: all 0.2s ease;
            box-shadow: 0 4px 10px rgba(160, 120, 85, 0.2);
        }

        .btn-cafe-submit:hover {
            background-color: #7c5a3c;
            color: #ffffff;
            transform: translateY(-1px);
        }

        .btn-outline-cafe {
            border: 1.5px solid #a07855;
            color: #a07855;
            border-radius: 8px;
            height: 45px;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
        }

        .btn-outline-cafe:hover {
            background-color: #a07855;
            color: #ffffff;
            text-decoration: none;
        }
        
        .info-box {
            background-color: #f5effa;
            border-left: 4px solid #a07855;
            padding: 12px;
            border-radius: 4px;
            font-size: 0.85rem;
            text-align: left;
            line-height: 1.5;
        }
    </style>
</head>
<body>
    <jsp:include page="./menu.jsp" />
    
    <div class="hero-banner">
        <div class="container">
            <h1 class="hero-title">멤버십 서비스</h1>
        </div>
    </div>
    
    <div class="container d-flex justify-content-center">
        <div class="login-card text-center">
            
            <div class="login-icon">
                <i class="fas fa-lock"></i>
            </div>
            
            <h4 class="font-weight-bold mb-4" style="color: #2b1e15;">로그인</h4>
            
            <% if (request.getAttribute("loginError") != null) { %>
                <div class="alert alert-danger text-left small py-2"><i class="fas fa-exclamation-circle mr-2"></i><%= request.getAttribute("loginError") %></div>
            <% } %>
            <% if (request.getAttribute("signupMessage") != null) { %>
                <div class="alert alert-success text-left small py-2"><i class="fas fa-check-circle mr-2"></i><%= request.getAttribute("signupMessage") %></div>
            <% } %>
            
            <form class="form-signin" action="/jwbook1/memberControl?action=processLogin" method="post">
                
                <div class="custom-input-group">
                    <i class="fas fa-user"></i>
                    <input type="text" class="form-control custom-input" placeholder="아이디(ID)를 입력하세요" name="id" value="${enteredId}" required autofocus>
                </div>
                
                <div class="custom-input-group">
                    <i class="fas fa-key"></i>
                    <input type="password" class="form-control custom-input" placeholder="비밀번호(Password)" name="password" required>
                </div>		
                
                <button class="btn btn-cafe-submit btn-block mt-4" type="submit">로그인</button>
            </form>
            
            <div class="hr-sect my-4 text-muted small" style="display: flex; align-items: center; text-align: center;"><span style="flex-grow: 1; border-bottom: 1px solid #e1dbd6; margin-right: 10px;"></span>처음 방문하셨나요?<span style="flex-grow: 1; border-bottom: 1px solid #e1dbd6; margin-left: 10px;"></span></div>
            
            <a class="btn btn-outline-cafe btn-block" href="${pageContext.request.contextPath}/memberControl?action=signup">
                <i class="fas fa-user-plus mr-2"></i>신규 회원가입
            </a>
            
            <div class="info-box mt-4 text-muted">
                <i class="fas fa-shield-alt text-secondary mr-1"></i> 개인정보 보호를 위해 비밀번호는 <strong>SHA-256 안전 해시</strong> 알고리즘으로 안전하게 암호화되어 관리됩니다.<br>
                <i class="fas fa-info-circle text-secondary mr-1"></i> 테스트 관리자 계정: <code style="color: #a07855; font-weight:bold;">admin / 1234</code>
            </div>
            
        </div>
    </div>
    
    <div class="my-5 py-3"></div>
</body>
</html>