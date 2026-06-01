<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>한신대학교 컴퓨터공학부</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    :root {
      --brand-navy: #12325b;
      --brand-gold: #f0b429;
    }

    body {
      background: linear-gradient(180deg, #f5f8fc 0%, #ffffff 55%, #eef3f9 100%);
      color: #1f2937;
    }

    .navbar {
      box-shadow: 0 0.5rem 1.5rem rgba(18, 50, 91, 0.12);
    }

    .hero {
      padding-top: 2.5rem;
      padding-bottom: 3.5rem;
      background: radial-gradient(circle at top left, rgba(255, 255, 255, 0.18), transparent 28%), linear-gradient(135deg, #1b4677 0%, #2f6fa1 50%, #5e9fc7 100%);
    }

    .hero-banner,
    .section-image,
    .carousel-image,
    .poster-image,
    .professor-image {
      width: 100%;
      display: block;
    }

    .hero-banner {
      height: auto;
      object-fit: contain;
      background-color: transparent;
    }

    .hero-banner,
    .section-image,
    .carousel-image,
    .poster-image {
      border-radius: 1.25rem;
      box-shadow: 0 1rem 2.5rem rgba(18, 50, 91, 0.16);
    }

    .section-image {
      aspect-ratio: 4 / 3;
      object-fit: contain;
      background-color: #ffffff;
    }

    .carousel-image {
      height: auto;
      object-fit: contain;
      background-color: transparent;
    }

    .section-chip {
      display: inline-flex;
      align-items: center;
      padding: 0.45rem 0.85rem;
      border-radius: 999px;
      background-color: rgba(18, 50, 91, 0.08);
      color: var(--brand-navy);
      font-weight: 700;
      letter-spacing: 0.02em;
    }

    .info-card,
    .poster-card,
    .professor-card {
      border: 0;
      border-radius: 1.25rem;
      box-shadow: 0 0.75rem 2rem rgba(15, 23, 42, 0.08);
      overflow: hidden;
      height: 100%;
    }

    .professor-image {
      aspect-ratio: 3 / 4;
      object-fit: cover;
      background-color: #f2f5f8;
    }

    .poster-image {
      aspect-ratio: 4 / 5;
      object-fit: cover;
      background-color: #f2f5f8;
    }

    .table-panel {
      border-radius: 1.25rem;
      overflow: hidden;
      box-shadow: 0 0.75rem 2rem rgba(15, 23, 42, 0.08);
    }

    .table-panel .table {
      margin-bottom: 0;
    }

    @media (max-width: 991.98px) {
      .hero {
        padding-top: 2rem;
        padding-bottom: 2.5rem;
      }
    }
  </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark sticky-top" style="background-color: var(--brand-navy);">
    <div class="container">
      <a class="navbar-brand fw-semibold" href="#top">한신대 컴퓨터공학부</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav" aria-controls="mainNav" aria-expanded="false" aria-label="메뉴 열기">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="mainNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link" href="#intro">학부소개</a></li>
          <li class="nav-item"><a class="nav-link" href="#course">교과과정</a></li>
          <li class="nav-item"><a class="nav-link" href="#professors">교수진</a></li>
          <li class="nav-item"><a class="nav-link" href="#capstone">졸업작품</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <header id="top" class="hero text-white">
    <div class="container">
      <div class="row align-items-center g-4 g-lg-5">
        <div class="col-lg-5">
          <span class="badge rounded-pill text-bg-warning text-dark mb-3 px-3 py-2">Bootstrap Department Landing</span>
          <h1 class="display-4 fw-bold mb-3">여러분의 꽃길을 컴퓨터공학부가 함께하겠습니다.</h1>
          <p class="lead mb-4">첨부한 학부 자료 이미지를 중심으로 메인 소개, 카드뉴스, 교과과정, 교수진, 졸업작품 섹션을 한 페이지에 정리했습니다.</p>
          <div class="d-flex flex-wrap gap-2">
            <a class="btn btn-warning btn-lg" href="#course">교과과정 보기</a>
            <a class="btn btn-outline-light btn-lg" href="#capstone">졸업작품 보기</a>
          </div>
        </div>
        <div class="col-lg-7">
          <img src="${pageContext.request.contextPath}/assets/images/m3.png" alt="한신대학교 컴퓨터공학부 메인 배너" class="hero-banner img-fluid">
        </div>
      </div>
    </div>
  </header>

  <main>
    <section id="intro" class="py-5">
      <div class="container">
        <div class="mb-4">
          <span class="section-chip mb-2">학부소개</span>
          <h2 class="fw-bold mb-2">비전과 진로를 한 번에 보여주는 소개 영역</h2>
          <p class="text-secondary mb-0">학부 환영 배너, 교육 목표, 이수 체계 이미지를 한 화면에서 확인할 수 있게 구성했습니다.</p>
        </div>
        <div class="row g-4 align-items-stretch">
          <div class="col-lg-7">
            <img src="${pageContext.request.contextPath}/assets/images/c1.jpg" alt="신입생 환영 배너" class="section-image img-fluid">
          </div>
          <div class="col-lg-5 d-flex flex-column gap-4">
            <div class="info-card card">
              <div class="card-body p-4">
                <h3 class="h5 fw-bold">교육 목표</h3>
                <p class="text-secondary">정보기술 기반의 실무 역량과 문제 해결 능력을 함께 키우는 학부 방향을 요약했습니다.</p>
                <img src="${pageContext.request.contextPath}/assets/images/model.png" alt="컴퓨터공학부 교육 목표" class="section-image img-fluid mt-3">
              </div>
            </div>
            <div class="info-card card">
              <div class="card-body p-4">
                <h3 class="h5 fw-bold">2021 이수체계</h3>
                <p class="text-secondary">교양, 전공선택, 전공필수 흐름을 한 장의 이미지로 확인할 수 있습니다.</p>
                <img src="${pageContext.request.contextPath}/assets/images/c2.jpg" alt="컴퓨터공학부 2021 이수체계" class="section-image img-fluid mt-3">
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="py-5 bg-body-tertiary">
      <div class="container">
        <div class="mb-4">
          <span class="section-chip mb-2">카드뉴스</span>
          <h2 class="fw-bold mb-2">학부 활동 이미지를 캐러셀로 배치</h2>
          <p class="text-secondary mb-0">메인 홍보 이미지와 비교적 큰 카드뉴스 이미지를 부트스트랩 캐러셀로 순환하도록 구성했습니다.</p>
        </div>
        <div id="departmentCarousel" class="carousel slide" data-bs-ride="carousel">
          <div class="carousel-indicators">
            <button type="button" data-bs-target="#departmentCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="슬라이드 1"></button>
            <button type="button" data-bs-target="#departmentCarousel" data-bs-slide-to="1" aria-label="슬라이드 2"></button>
            <button type="button" data-bs-target="#departmentCarousel" data-bs-slide-to="2" aria-label="슬라이드 3"></button>
            <button type="button" data-bs-target="#departmentCarousel" data-bs-slide-to="3" aria-label="슬라이드 4"></button>
          </div>
          <div class="carousel-inner rounded-4 overflow-hidden shadow-lg">
            <div class="carousel-item active">
              <img src="${pageContext.request.contextPath}/assets/images/cardnews1.png" alt="카드뉴스 1" class="carousel-image">
            </div>
            <div class="carousel-item">
              <img src="${pageContext.request.contextPath}/assets/images/cardnews2.png" alt="카드뉴스 2" class="carousel-image">
            </div>
            <div class="carousel-item">
              <img src="${pageContext.request.contextPath}/assets/images/cardnews3.png" alt="카드뉴스 3" class="carousel-image">
            </div>
            <div class="carousel-item">
              <img src="${pageContext.request.contextPath}/assets/images/cardnews4.png" alt="카드뉴스 4" class="carousel-image">
            </div>
          </div>
          <button class="carousel-control-prev" type="button" data-bs-target="#departmentCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">이전</span>
          </button>
          <button class="carousel-control-next" type="button" data-bs-target="#departmentCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">다음</span>
          </button>
        </div>
      </div>
    </section>

    <section id="course" class="py-5">
      <div class="container">
        <div class="mb-4">
          <span class="section-chip mb-2">교과과정</span>
          <h2 class="fw-bold mb-2">졸업 기준과 교과 운영 정보를 함께 배치</h2>
          <p class="text-secondary mb-0">교과과정 표 이미지와 함께 주요 졸업 기준을 Bootstrap 표로 정리했습니다.</p>
        </div>
        <div class="row g-4">
          <div class="col-lg-7">
            <img src="${pageContext.request.contextPath}/assets/images/c3.jpg" alt="졸업학점 및 필수과목 안내" class="section-image img-fluid mb-4">
            <img src="${pageContext.request.contextPath}/assets/images/c4-1.jpg" alt="졸업이수학점 및 교양필수 안내" class="section-image img-fluid">
          </div>
          <div class="col-lg-5 d-flex flex-column gap-4">
            <div class="table-panel bg-white">
              <div class="p-4 border-bottom">
                <h3 class="h5 fw-bold mb-1">졸업 기준 요약</h3>
                <p class="text-secondary mb-0">2021 기준 샘플 데이터를 기반으로 주요 조건만 간단히 정리했습니다.</p>
              </div>
              <div class="table-responsive">
                <table class="table align-middle">
                  <thead class="table-light">
                    <tr>
                      <th>구분</th>
                      <th>기준</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>교양</td>
                      <td>35학점 이상</td>
                    </tr>
                    <tr>
                      <td>전공</td>
                      <td>72학점 이상</td>
                    </tr>
                    <tr>
                      <td>총 졸업학점</td>
                      <td>130학점 이상</td>
                    </tr>
                    <tr>
                      <td>졸업 논문</td>
                      <td>4학년 1, 2학기 졸업논문 이수</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
            <img src="${pageContext.request.contextPath}/assets/images/c4-2.jpg" alt="컴퓨터공학부 시간표 예시" class="section-image img-fluid">
          </div>
        </div>
      </div>
    </section>

    <section id="professors" class="py-5 bg-body-tertiary">
      <div class="container">
        <div class="mb-4">
          <span class="section-chip mb-2">교수진</span>
          <h2 class="fw-bold mb-2">교수진 카드 섹션</h2>
          <p class="text-secondary mb-0">첨부된 인물 사진을 활용해 Bootstrap 카드 형태로 전임 교수진을 정리했습니다.</p>
        </div>
        <div class="row g-4">
          <div class="col-sm-6 col-xl-3">
            <div class="professor-card card">
              <img src="${pageContext.request.contextPath}/assets/images/p2.jpg" alt="양영욱 교수" class="professor-image">
              <div class="card-body">
                <h3 class="h5 fw-bold">양영욱</h3>
                <p class="text-secondary mb-2">조교수</p>
                <p class="mb-0 small">소프트웨어전공<br>yeongwook.yang@hs.ac.kr</p>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-xl-3">
            <div class="professor-card card">
              <img src="${pageContext.request.contextPath}/assets/images/p3.jpg" alt="윤효석 교수" class="professor-image">
              <div class="card-body">
                <h3 class="h5 fw-bold">윤효석</h3>
                <p class="text-secondary mb-2">조교수</p>
                <p class="mb-0 small">정보통신(컴퓨터공학)<br>hyoon@hs.ac.kr</p>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-xl-3">
            <div class="professor-card card">
              <img src="${pageContext.request.contextPath}/assets/images/p4.jpg" alt="이양선 교수" class="professor-image">
              <div class="card-body">
                <h3 class="h5 fw-bold">이양선</h3>
                <p class="text-secondary mb-2">조교수</p>
                <p class="mb-0 small">컴퓨터멀티미디어공학<br>yslee48@hs.ac.kr</p>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-xl-3">
            <div class="professor-card card">
              <img src="${pageContext.request.contextPath}/assets/images/p6.jpg" alt="박성진 교수" class="professor-image">
              <div class="card-body">
                <h3 class="h5 fw-bold">박성진</h3>
                <p class="text-secondary mb-2">교수</p>
                <p class="mb-0 small">데이터베이스<br>sjpark@hs.ac.kr</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section id="capstone" class="py-5">
      <div class="container">
        <div class="mb-4">
          <span class="section-chip mb-2">졸업작품</span>
          <h2 class="fw-bold mb-2">캡스톤 결과물 포스터 갤러리</h2>
          <p class="text-secondary mb-0">포스터 이미지를 카드 그리드로 묶어서 작품 소개 영역처럼 보이도록 구성했습니다.</p>
        </div>
        <div class="row g-4">
          <div class="col-md-6 col-xl-4">
            <div class="poster-card card">
              <img src="${pageContext.request.contextPath}/assets/images/cap1.jpg" alt="캡스톤 작품 포스터 1" class="poster-image">
            </div>
          </div>
          <div class="col-md-6 col-xl-4">
            <div class="poster-card card">
              <img src="${pageContext.request.contextPath}/assets/images/cap2.jpg" alt="캡스톤 작품 포스터 2" class="poster-image">
            </div>
          </div>
          <div class="col-md-6 col-xl-4">
            <div class="poster-card card">
              <img src="${pageContext.request.contextPath}/assets/images/cap3.jpg" alt="캡스톤 작품 포스터 3" class="poster-image">
            </div>
          </div>
          <div class="col-md-6 col-xl-4">
            <div class="poster-card card">
              <img src="${pageContext.request.contextPath}/assets/images/cap4.jpg" alt="캡스톤 작품 포스터 4" class="poster-image">
            </div>
          </div>
          <div class="col-md-6 col-xl-4">
            <div class="poster-card card">
              <img src="${pageContext.request.contextPath}/assets/images/cap5.jpg" alt="캡스톤 작품 포스터 5" class="poster-image">
            </div>
          </div>
          <div class="col-md-6 col-xl-4">
            <div class="poster-card card">
              <img src="${pageContext.request.contextPath}/assets/images/cap6.jpg" alt="캡스톤 작품 포스터 6" class="poster-image">
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>

  <footer class="py-4 text-center text-white" style="background-color: var(--brand-navy);">
    <div class="container">
      <p class="mb-1 fw-semibold">한신대학교 컴퓨터공학부</p>
      <p class="mb-0 small">Bootstrap 5 기반 샘플 메인 페이지</p>
    </div>
  </footer>
</body>
</html>
