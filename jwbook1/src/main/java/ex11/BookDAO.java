package ex11;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
	Connection conn = null;
	PreparedStatement pstmt;

	final String JDBC_DRIVER = "org.h2.Driver";
	final String JDBC_URL = "jdbc:h2:~/bookmarketdb";

	public void open(){
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL,"user1","1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void close() {
	    try {
	        if (pstmt != null) pstmt.close();
	        if (conn != null) conn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	public void insert(Book b) {
	    open();
	    System.out.println("insert 실행됨");
	    System.out.println("상품ID: " + b.getProductId());
	    System.out.println("도서명: " + b.getPname());

	    String sql = "INSERT INTO book3(productid, pname, unitprice, description, manufacturer, category, unitsinstock, \"condition\", productimg) values(?,?,?,?,?,?,?,?,?)";

	    try {
	        pstmt = conn.prepareStatement(sql);

	        pstmt.setString(1, b.getProductId());
	        pstmt.setString(2, b.getPname());
	        pstmt.setInt(3, b.getUnitPrice());
	        pstmt.setString(4, b.getDescription());
	        pstmt.setString(5, b.getManufacturer());
	        pstmt.setString(6, b.getCategory());
	        pstmt.setInt(7, b.getUnitsInStock());
	        pstmt.setString(8, b.getCondition());
	        pstmt.setString(9, b.getProductImg());

	        int result = pstmt.executeUpdate();
	        System.out.println("insert 결과: " + result);

	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        close();
	    }
	}
	
	public List<Book> findAll() {
	    open();
	    List<Book> books = new ArrayList<>();

	    try {
	        System.out.println("conn = " + conn);

	        pstmt = conn.prepareStatement("select * from book3");
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            System.out.println("DB 도서명: " + rs.getString("pname"));

	            Book b = new Book();
	            b.setProductId(rs.getString("productid"));
	            b.setPname(rs.getString("pname"));
	            b.setUnitPrice(rs.getInt("unitprice"));
	            b.setDescription(rs.getString("description"));
	            b.setManufacturer(rs.getString("manufacturer"));
	            b.setCategory(rs.getString("category"));
	            b.setUnitsInStock(rs.getInt("unitsinstock"));
	            b.setCondition(rs.getString("condition"));
	            b.setProductImg(rs.getString("productimg"));

	            books.add(b);
	        }

	        System.out.println("books size = " + books.size());

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        close();
	    }

	    return books;
	}
	
	public Book find(String id) {
		open();
		Book b = new Book();
		
		try {
			pstmt = conn.prepareStatement("select * from book3 where productId = ?");
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();	
			
			rs.next();
			
			b.setProductId(rs.getString("productId"));
			b.setPname(rs.getString("pname"));
			b.setUnitPrice(rs.getInt("unitPrice"));
			b.setDescription(rs.getString("description"));
			b.setManufacturer(rs.getString("manufacturer"));
			b.setCategory(rs.getString("category"));
			b.setUnitsInStock(rs.getInt("unitsinstock"));
			b.setCondition(rs.getString("condition"));
			b.setProductImg(rs.getString("productimg"));
	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return b;
	}
	
}