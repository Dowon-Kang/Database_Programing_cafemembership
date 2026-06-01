<%@ page contentType="text/html; charset=utf-8"%>

<html>
<head>
	<link rel="stylesheet" 	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<title>도서 상세 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">도서 정보</h1>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<img src="${b.productImg}" style="width: 100%">
				<h3>${b.pname}</h3>
				<p>${b.description}</p>
				<p><b>도서 코드 : </b><span class="badge badge-danger">${b.productId}</span></p>
				<p><b>출판사</b> : ${b.manufacturer}</p>
				<p><b>분류</b> : ${b.category}</p>
				<p><b>재고 수</b> : ${b.unitsInStock}</p>
				<p><b>상태</b> : ${b.condition}</p>
				<h4>${b.unitPrice}원</h4>
				<p><a href="#" class="btn btn-info"> 도서 주문 &raquo;</a> <a	href="/jwbook1/bm3control?action=productInfoList" class="btn btn-secondary"> 도서 목록 &raquo;</a>
			</div>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
