CREATE TABLE book3 (
    productid VARCHAR(10) NOT NULL Primary Key,
    pname VARCHAR(20),
    unitprice INT,
    description VARCHAR(100), 
    manufacturer VARCHAR(40),
    category VARCHAR(20),
    unitsinstock INT,
    condition VARCHAR(10),
    productimg VARCHAR(20)
)

INSERT INTO book3(productid, pname, unitprice, description, manufacturer, category, unitsInstock, condition, productimg) values('B1111', '데이터베이스', 30000, '데이터베이스 이론, SQL, 정규화, E-R 다이아그램', '생생출판사', 'DB', 100, '신상도서', '/img/book1.jpg');
INSERT INTO book3(productid, pname, unitprice, description, manufacturer, category, unitsInstock, condition,  productimg) values('B2222', 'DB와 JSP', 25000, '데이터베이스, JSP, HTML, Servlet, JDBC', '한물출판사', 'Web', 2000, '중고도서', '/img/book2.jpg');
INSERT INTO book3(productid, pname, unitprice, description, manufacturer, category, unitsInstock, condition,  productimg) values('B3333', 'Spring', 40000, 'Spring Framwork, Spring Boot, Java Bean', '생생출판사', 'Web', 500, '재생도서', '/img/book3.jpg');

SELECT * FROM book3;

DROP TABLE book3;