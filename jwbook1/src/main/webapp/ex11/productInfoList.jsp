<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ex11.Book" %>

<html>
<head>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

    <title>도서 정보 목록</title>
</head>

<body>

    <jsp:include page="menu.jsp" />

    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">도서목록</h1>
        </div>
    </div>

    <div class="container">
        <div class="row" align="center">

            <%
                List<Book> books =
                    (List<Book>)request.getAttribute("books");

                if(books == null || books.size() == 0){
            %>

                    <h3>등록된 도서가 없습니다.</h3>

            <%
                } else {

                    for(Book b : books){
            %>

                        <div class="col-md-4">

                            <img src="<%= request.getContextPath() %><%= b.getProductImg() %>"style="width:100%">
                            <h3><%= b.getPname() %></h3>

                            <p><%= b.getDescription() %></p>

                            <p><%= b.getUnitPrice() %>원</p>

                            <p>
                                <a href="<%= request.getContextPath() %>/bm3control?action=productInfo&id=<%= b.getProductId() %>"
                                   class="btn btn-secondary"
                                   role="button">

                                   상세 정보 &raquo;

                                </a>
                            </p>

                        </div>

            <%
                    }
                }
            %>

        </div>

        <hr>
    </div>

    <jsp:include page="footer.jsp" />

</body>
</html>