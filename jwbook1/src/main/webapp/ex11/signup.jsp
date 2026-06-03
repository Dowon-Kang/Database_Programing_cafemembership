<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <title>회원가입 - 카페 멤버십 시스템</title>
    
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fcfbfa; /* 따뜻한 아이보리 톤 배경 */
            color: #3e332e;
        }
        
        /* 미니 히어로 타이틀 배너 */
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

        /* 회원가입 카드 상자 */
        .signup-card {
            background: #ffffff;
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(74, 55, 40, 0.06);
            padding: 3rem 2.5rem;
            margin-top: 2.5rem;
            margin-bottom: 3rem;
        }

        /* 폼 라벨 커스텀 스타일 */
        .form-label-custom {
            font-weight: 700;
            color: #4a3728;
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
        }
        
        .form-label-custom i {
            width: 22px;
            color: #a07855;
            margin-right: 6px;
            font-size: 0.95rem;
        }

        /* 입력창 모던 커스텀 스타일 */
        .form-control-custom {
            border-radius: 8px;
            border: 1px solid #e1dbd6;
            background-color: #fdfdfd;
            height: 44px;
            transition: all 0.2s ease;
        }

        .form-control-custom:focus {
            border-color: #a07855;
            box-shadow: 0 0 0 0.2rem rgba(160, 120, 85, 0.15);
            background-color: #ffffff;
        }

        /* 가입 및 취소 버튼 스타일링 */
        .btn-cafe-submit {
            background-color: #a07855;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            height: 46px;
            font-weight: 700;
            font-size: 1.05rem;
            transition: all 0.2s ease;
            box-shadow: 0 4px 10px rgba(160, 120, 85, 0.2);
        }

        .btn-cafe-submit:hover {
            background-color: #7c5a3c;
            color: #ffffff;
            transform: translateY(-1px);
        }

        .btn-cafe-outline {
            border: 1.5px solid #a07855;
            color: #a07855;
            border-radius: 8px;
            height: 44px;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
            background-color: transparent;
        }

        .btn-cafe-outline:hover {
            background-color: #a07855;
            color: #ffffff;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp" />
    
    <div class="hero-banner">
        <div class="container">
            <h1 class="hero-title">멤버십 가입 신청</h1>
        </div>
    </div>
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                
                <c:if test="${not empty signupError}">
                    <div class="alert alert-danger mt-4">
                        <i class="fas fa-exclamation-circle mr-2"></i>${signupError}
                    </div>
                </c:if>
                
                <div class="signup-card">
                    <form action="${pageContext.request.contextPath}/memberControl?action=processSignup" method="post">
                        
                        <div class="form-group mb-4">
                            <label class="form-label-custom"><i class="fas fa-fingerprint"></i>회원 ID</label>
                            <input type="text" name="memberId" class="form-control form-control-custom" value="${member.memberId}" placeholder="사용할 고유 아이디를 입력하세요" required>
                        </div>
                        
                        <div class="form-group mb-4">
                            <label class="form-label-custom"><i class="fas fa-key"></i>비밀번호</label>
                            <input type="password" name="password" class="form-control form-control-custom" placeholder="안전한 암호를 설정하세요" required>
                        </div>
                        
                        <div class="form-group mb-4">
                            <label class="form-label-custom"><i class="fas fa-user"></i>이름</label>
                            <input type="text" name="name" class="form-control form-control-custom" value="${member.name}" placeholder="고객님의 실명을 입력하세요" required>
                        </div>
                        
                        <div class="form-group mb-4">
                            <label class="form-label-custom"><i class="fas fa-phone-alt"></i>전화번호</label>
                            <input type="text" name="phone" class="form-control form-control-custom" value="${member.phone}" placeholder="010-1234-5678" required>
                        </div>
                        
                        <div class="form-group mb-4">
                            <label class="form-label-custom"><i class="fas fa-image"></i>프로필 이미지 URL (선택)</label>
                            <input type="url" name="imageUrl" class="form-control form-control-custom" value="${member.imageUrl}" placeholder="https://example.com/profile.jpg">
                            <small class="form-text text-muted mt-2">
                                <i class="fas fa-info-circle mr-1"></i>나만의 웹 프로필 주소를 넣으면 회원 상세/리스트 화면에 적용됩니다.
                            </small>
                        </div>
                        
                        <c:if test="${not empty member.imageUrl}">
                            <div class="form-group mb-4">
                                <p class="mb-2 font-weight-bold small text-muted"><i class="fas fa-eye mr-1"></i>프로필 미리보기</p>
                                <img src="${member.imageUrl}" alt="프로필 미리보기" style="width: 100px; height: 100px; object-fit: cover; border-radius: 50%; border: 3px solid #ece5df; box-shadow: 0 4px 8px rgba(0,0,0,0.05);">
                            </div>
                        </c:if>
                        
                        <div class="mt-5" style="border-top: 2px dashed #f2ebe6; padding-top: 1.5rem;">
                            <button type="submit" class="btn btn-cafe-submit btn-block mb-3">
                                <i class="fas fa-user-plus mr-2"></i>회원가입 신청하기
                            </button>
                            <a href="${pageContext.request.contextPath}/memberControl?action=login" class="btn btn-cafe-outline btn-block">
                                <i class="fas fa-undo mr-2"></i>로그인 화면으로 돌아가기
                            </a>
                        </div>
                        
                    </form>
                </div>
                
            </div>
        </div>
    </div>
</body>
</html>