<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <title>회원 상세 정보 - 카페 멤버십 시스템</title>
    
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

        /* 메인 프로필 레이아웃 카드 */
        .profile-card {
            background: #ffffff;
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(74, 55, 40, 0.06);
            padding: 3rem 2.5rem;
            margin-top: 2.5rem;
        }

        /* 이미지 액자 스타일 구현 */
        .profile-img-wrapper {
            width: 140px;
            height: 140px;
            border-radius: 50%; /* 원형 프로필로 변경 */
            overflow: hidden;
            border: 4px solid #f2eb text;
            box-shadow: 0 4px 12px rgba(160, 120, 85, 0.2);
            background-color: #f5f0eb;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .profile-img-fallback {
            font-size: 4rem;
            color: #d4b296;
        }

        /* 회원 상세 명세 항목 리스트 스타일 */
        .info-list {
            list-style: none;
            padding-left: 0;
            margin-bottom: 2rem;
        }

        .info-item {
            display: flex;
            align-items: center;
            padding: 0.9rem 0;
            border-bottom: 1px solid #f2eb e6;
            font-size: 1.05rem;
        }

        .info-label {
            font-weight: 700;
            color: #7c6252;
            width: 130px;
            display: flex;
            align-items: center;
        }
        
        .info-label i {
            width: 24px;
            color: #a07855;
            margin-right: 8px;
        }

        .info-value {
            color: #2b1e15;
            flex-grow: 1;
        }

        /* 스탬프 카운트 특별 강조 디자인 */
        .stamp-status {
            background-color: #fdf5ef;
            border: 1px dashed #d4b296;
            border-radius: 10px;
            padding: 0.8rem 1.2rem;
            display: inline-flex;
            align-items: center;
            font-weight: 700;
        }
        
        .stamp-status i {
            color: #e67e22;
            font-size: 1.3rem;
            margin-right: 8px;
        }
        
        .stamp-number {
            font-size: 1.2rem;
            color: #a07855;
            margin-left: 5px;
        }

        /* 버튼 바 가다듬기 */
        .action-group {
            gap: 10px;
            margin-top: 2.5rem;
            border-top: 2px dashed #f2ebe6;
            padding-top: 2rem;
        }

        .btn-cafe-primary {
            background-color: #a07855;
            color: white !important;
            border: none;
            border-radius: 8px;
            padding: 0.6rem 1.5rem;
            font-weight: 700;
            transition: all 0.2s ease;
        }
        .btn-cafe-primary:hover { background-color: #7c5a3c; transform: translateY(-1px); }

        .btn-cafe-secondary {
            background-color: #ece5df;
            color: #4a3728 !important;
            border: none;
            border-radius: 8px;
            padding: 0.6rem 1.5rem;
            font-weight: 700;
            transition: all 0.2s ease;
        }
        .btn-cafe-secondary:hover { background-color: #decbc0; }
        
        .btn-cafe-outline {
            border: 1.5px solid #a07855;
            color: #a07855 !important;
            background: transparent;
            border-radius: 8px;
            padding: 0.55rem 1.5rem;
            font-weight: 700;
            transition: all 0.2s ease;
        }
        .btn-cafe-outline:hover { background-color: #a07855; color: white !important; }

        .id-badge {
            background-color: #2b1e15;
            color: #f7f3e9;
            padding: 0.2rem 0.6rem;
            border-radius: 6px;
            font-family: 'Courier New', Courier, monospace;
            font-size: 0.95rem;
        }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp" />
    
    <div class="hero-banner">
        <div class="container">
            <h1 class="hero-title">회원 상세 정보</h1>
        </div>
    </div>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-9 col-md-11">
                
                <c:if test="${not empty detailError}">
                    <div class="alert alert-danger mt-4"><i class="fas fa-exclamation-circle mr-2"></i>${detailError}</div>
                </c:if>
                <c:if test="${not empty detailMessage}">
                    <div class="alert alert-success mt-4"><i class="fas fa-check-circle mr-2"></i>${detailMessage}</div>
                </c:if>
                
                <div class="profile-card">
                    <div class="row align-items-center">
                        
                        <div class="col-md-3 d-flex flex-column align-items-center mb-4 mb-md-0">
                            <div class="profile-img-wrapper mb-3">
                                <c:choose>
                                    <c:when test="${not empty member.imageUrl}">
                                        <img src="${member.imageUrl}" alt="프로필 이미지" style="width: 100%; height: 100%; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-user-circle profile-img-fallback"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <h4 class="font-weight-bold text-center mt-2" style="color:#2b1e15;">${member.name}</h4>
                        </div>
                        
                        <div class="col-md-9 pl-md-4">
                            <ul class="info-list">
                                <li class="info-item">
                                    <div class="info-label"><i class="fas fa-fingerprint"></i>회원 ID</div>
                                    <div class="info-value"><span class="id-badge">${member.memberId}</span></div>
                                </li>
                                <li class="info-item">
                                    <div class="info-label"><i class="fas fa-phone-alt"></i>전화번호</div>
                                    <div class="info-value">${member.phone}</div>
                                </li>
                                <li class="info-item">
                                    <div class="info-label"><i class="fas fa-link"></i>이미지 경로</div>
                                    <div class="info-value text-muted text-break" style="font-size:0.9rem;">
                                        <c:choose>
                                            <c:when test="${not empty member.imageUrl}">${member.imageUrl}</c:when>
                                            <c:otherwise>등록된 프로필 주소가 없습니다.</c:otherwise>
                                        </c:choose>
                                    </div>
                                </li>
                                <li class="info-item">
                                    <div class="info-label"><i class="fas fa-calendar-alt"></i>가입일자</div>
                                    <div class="info-value">${member.joinDate}</div>
                                </li>
                                <li class="info-item" style="border-bottom: none;">
                                    <div class="info-label"><i class="fas fa-award"></i>멤버십 상태</div>
                                    <div class="info-value">
                                        <div class="stamp-status">
                                            <i class="fas fa-stamp"></i>보유 스탬프: <span class="stamp-number">${member.stampCount} 개</span>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        
                    </div>
                    
                    <div class="action-group d-flex flex-wrap align-items-center justify-content-end">
                        
                        <%-- 1. 본인 정보일 때 수정 단추 --%>
                        <c:if test="${isMyInfo}">
                            <a href="${pageContext.request.contextPath}/memberControl?action=editMyInfo" class="btn btn-cafe-primary">
                                <i class="fas fa-user-edit mr-2"></i>내 정보 수정
                            </a>
                        </c:if>
                        
                        <%-- 2. 관리자 전용 어드민 관리 단추 세트 --%>
                        <c:if test="${sessionIsAdmin}">
                            <form method="post" action="${pageContext.request.contextPath}/memberControl" style="display:inline; margin:0;">
                                <input type="hidden" name="action" value="processIncrementStamp">
                                <input type="hidden" name="id" value="${member.memberId}">
                                <input type="hidden" name="returnView" value="detail">
                                <button type="submit" class="btn btn-cafe-outline">
                                    <i class="fas fa-plus-circle mr-2"></i>스탬프 +1 적립
                                </button>
                            </form>
                            
                            <a href="${pageContext.request.contextPath}/memberControl?action=editMember&id=${member.memberId}" class="btn btn-cafe-secondary">
                                <i class="fas fa-edit mr-2"></i>회원 수정
                            </a>
                            
                            <c:if test="${member.adminYn ne 'Y'}">
                                <a href="${pageContext.request.contextPath}/memberControl?action=deleteMember&id=${member.memberId}" class="btn btn-danger" style="border-radius:8px; padding: 0.6rem 1.5rem;" onclick="return confirm('이 회원을 영구적으로 삭제하시겠습니까?');">
                                    <i class="fas fa-user-slash mr-2"></i>회원 삭제
                                </a>
                            </c:if>
                        </c:if>
                        
                        <%-- 3. 목록 및 메인으로 회귀하는 돌아가기 단추 --%>
                        <c:choose>
                            <c:when test="${isMyInfo}">
                                <a href="${pageContext.request.contextPath}/memberControl?action=welcomeUser" class="btn btn-secondary" style="border-radius:8px; padding: 0.6rem 1.5rem;">
                                    <i class="fas fa-undo mr-2"></i>돌아가기
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/memberControl?action=memberList" class="btn btn-secondary" style="border-radius:8px; padding: 0.6rem 1.5rem;">
                                    <i class="fas fa-list-ul mr-2"></i>회원 목록
                                </a>
                            </c:otherwise>
                        </c:choose>
                        
                    </div>
                </div>
                
            </div>
        </div>
        <div class="my-5 py-2"></div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>