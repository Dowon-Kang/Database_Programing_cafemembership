<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <title><c:choose><c:when test="${mode eq 'edit'}">회원 정보 수정</c:when><c:otherwise>신규 회원 등록</c:otherwise></c:choose> - 카페 멤버십 시스템</title>
    
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

        /* 입력 폼 플레이트 카드 */
        .form-card {
            background: #ffffff;
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(74, 55, 40, 0.06);
            padding: 3rem 2.5rem;
            margin-top: 2.5rem;
        }

        /* 폼 그룹 라벨 스타일 */
        .form-label-custom {
            font-weight: 700;
            color: #4a3728;
            display: flex;
            align-items: center;
            padding-top: calc(0.375rem + 1px);
        }
        
        .form-label-custom i {
            width: 24px;
            color: #a07855;
            margin-right: 6px;
        }

        /* 커스텀 인풋 스타일 */
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
        
        .form-control-custom[readonly] {
            background-color: #f5f0eb;
            color: #7c6252;
            border-color: #e1dbd6;
        }

        /* 라디오 버튼 커스텀 스타일 */
        .custom-radio-group {
            display: inline-flex;
            align-items: center;
            margin-top: calc(0.375rem + 1px);
            gap: 20px;
        }
        
        .custom-radio-item {
            cursor: pointer;
            font-weight: 500;
        }
        
        .custom-radio-item input[type="radio"] {
            accent-color: #a07855; /* 모던 브라우저 라디오 색상 커스텀 */
            margin-right: 6px;
            transform: scale(1.1);
            vertical-align: middle;
        }

        /* 하단 푸터 버튼 컨트롤 영역 */
        .form-action-group {
            border-top: 2px dashed #f2ebe6;
            padding-top: 2rem;
            margin-top: 2.5rem;
        }

        .btn-cafe-save {
            background-color: #a07855;
            color: white !important;
            border: none;
            border-radius: 8px;
            padding: 0.65rem 2rem;
            font-weight: 700;
            font-size: 1.05rem;
            transition: all 0.2s ease;
            box-shadow: 0 4px 10px rgba(160, 120, 85, 0.2);
        }
        .btn-cafe-save:hover { background-color: #7c5a3c; transform: translateY(-1px); }

        .btn-cafe-cancel {
            background-color: #ece5df;
            color: #4a3728 !important;
            border: none;
            border-radius: 8px;
            padding: 0.65rem 2rem;
            font-weight: 700;
            font-size: 1.05rem;
            transition: all 0.2s ease;
        }
        .btn-cafe-cancel:hover { background-color: #decbc0; }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp" />	
    
    <div class="hero-banner">
        <div class="container">
            <c:choose>
                <c:when test="${mode eq 'edit'}"><h1 class="hero-title">회원 정보 수정</h1></c:when>
                <c:otherwise><h1 class="hero-title">신규 회원 등록</h1></c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                
                <c:if test="${not empty formError}">
                    <div class="alert alert-danger mt-4"><i class="fas fa-exclamation-circle mr-2"></i>${formError}</div>
                </c:if>
                
                <div class="form-card">
                    <form name="memberForm" action="${pageContext.request.contextPath}/memberControl?action=${mode eq 'edit' ? (isMyInfo ? 'processMyInfoUpdate' : 'processUpdateMember') : 'processAddMember'}" method="post">
                        
                        <div class="form-group row mb-4">
                            <label class="col-sm-3 form-label-custom"><i class="fas fa-fingerprint"></i>회원 ID</label>
                            <div class="col-sm-5">
                                <input type="text" name="memberId" class="form-control form-control-custom" value="${member.memberId}" <c:if test="${mode eq 'edit'}">readonly</c:if> required>
                            </div>
                        </div>
                        
                        <div class="form-group row mb-4">
                            <label class="col-sm-3 form-label-custom"><i class="fas fa-key"></i>비밀번호</label>
                            <div class="col-sm-6">
                                <input type="password" name="password" class="form-control form-control-custom" value="" <c:if test="${mode ne 'edit'}">required</c:if> placeholder="${mode eq 'edit' ? '변경할 때만 새 비밀번호 입력' : '사용할 비밀번호 입력'}">
                                <small class="form-text text-muted mt-2">
                                    <i class="fas fa-info-circle mr-1"></i>
                                    <c:choose>
                                        <c:when test="${mode eq 'edit'}">비워두면 기존 비밀번호를 변경하지 않고 안전하게 유지합니다.</c:when>
                                        <c:otherwise>입력한 암호는 고도화된 SHA-256 해시 데이터로 안전하게 암호화 보관됩니다.</c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                        </div>
                        
                        <div class="form-group row mb-4">
                            <label class="col-sm-3 form-label-custom"><i class="fas fa-user"></i>이름</label>
                            <div class="col-sm-5">
                                <input type="text" name="name" class="form-control form-control-custom" value="${member.name}" required>
                            </div>
                        </div>
                        
                        <div class="form-group row mb-4">
                            <label class="col-sm-3 form-label-custom"><i class="fas fa-phone-alt"></i>전화번호</label>
                            <div class="col-sm-5">
                                <input type="text" name="phone" class="form-control form-control-custom" value="${member.phone}" placeholder="010-0000-0000" required>
                            </div>
                        </div>
                        
                        <div class="form-group row mb-4">
                            <label class="col-sm-3 form-label-custom"><i class="fas fa-image"></i>프로필 이미지 URL</label>
                            <div class="col-sm-8">
                                <input type="url" name="imageUrl" class="form-control form-control-custom" value="${member.imageUrl}" placeholder="https://example.com/image.jpg">
                                <small class="form-text text-muted mt-2"><i class="fas fa-link mr-1"></i>웹 주소(.jpg, .png 등)를 입력하면 회원 카드 및 리스트 화면에 실시간 노출됩니다.</small>
                            </div>
                        </div>
                        
                        <c:if test="${not empty member.imageUrl}">
                            <div class="form-group row mb-4">
                                <label class="col-sm-3 form-label-custom"><i class="fas fa-eye"></i>현재 프로필 이미지</label>
                                <div class="col-sm-4">
                                    <img src="${member.imageUrl}" alt="프로필 미리보기" style="width: 100px; height: 100px; object-fit: cover; border-radius: 50%; border: 3px solid #ece5df; box-shadow: 0 4px 8px rgba(0,0,0,0.05);">
                                </div>
                            </div>
                        </c:if>
                        
                        <div class="form-group row mb-4">
                            <label class="col-sm-3 form-label-custom"><i class="fas fa-stamp"></i>스탬프 개수</label>
                            <div class="col-sm-4">
                                <input type="number" name="stampCount" class="form-control form-control-custom" value="${empty member.stampCount ? 0 : member.stampCount}" min="0" <c:if test="${allowStampEdit eq false}">readonly</c:if>>
                                <c:if test="${allowStampEdit eq false}">
                                    <small class="form-text text-muted mt-2"><i class="fas fa-lock mr-1"></i>스탬프 적립 수정 권한은 최고 관리자 권한만 허용됩니다.</small>
                                </c:if>
                            </div>
                        </div>
                        
                        <c:if test="${allowAdminEdit ne false}">
                            <div class="form-group row mb-4">
                                <label class="col-sm-3 text-dark font-weight-bold form-label-custom"><i class="fas fa-user-shield"></i>관리자 권한 부여</label>
                                <div class="col-sm-8">
                                    <div class="custom-radio-group">
                                        <label class="custom-radio-item mb-0">
                                            <input type="radio" name="adminYn" value="Y" <c:if test="${member.adminYn eq 'Y'}">checked</c:if>> 마스터 관리자
                                        </label>
                                        <label class="custom-radio-item mb-0">
                                            <input type="radio" name="adminYn" value="N" <c:if test="${empty member.adminYn or member.adminYn eq 'N'}">checked</c:if>> 일반 카페 멤버
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <div class="form-group row mb-4">
                            <label class="col-sm-3 form-label-custom"><i class="fas fa-calendar-check"></i>최초 가입일</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control form-control-custom" value="${empty member.joinDate ? '시스템 자동 등록 예정' : member.joinDate}" readonly>
                            </div>
                        </div>
                        
                        <div class="form-group row mb-0">
                            <div class="col-sm-10 offset-sm-3 form-action-group">
                                <button type="submit" class="btn btn-cafe-save mr-2">
                                    <i class="fas fa-check mr-1"></i>${mode eq 'edit' ? '정보 수정하기' : '신규 등록하기'}
                                </button>
                                <c:choose>
                                    <c:when test="${isMyInfo}">
                                        <a href="${pageContext.request.contextPath}/memberControl?action=myInfo" class="btn btn-cafe-cancel">
                                            <i class="fas fa-times mr-1"></i>취소
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/memberControl?action=memberList" class="btn btn-cafe-cancel">
                                            <i class="fas fa-list-ul mr-1"></i>목록으로
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </form>
                </div>
                
            </div>
        </div>
        <div class="my-5 py-2"></div>
    </div>
</body>
</html>