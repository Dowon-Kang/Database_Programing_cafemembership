package ex11;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {
    
    public Connection getConnection() throws Exception {
        Class.forName("org.h2.Driver");
        
        // 1. URL 확인 (H2 콘솔의 JDBC URL과 동일해야 함)
        String url = "jdbc:h2:tcp://localhost/~/test"; 
        
        // 2. 접속 계정 정보 (방금 말씀하신 user1 / 1234로 수정)
        // 만약 H2 콘솔 로그인할 때 쓰는 아이디가 sa라면 여기를 다시 sa로 바꿔야 합니다.
        String user = "user1"; 
        String password = "1234"; 
        
        return DriverManager.getConnection(url, user, password);
    }

    public Member authenticate(String id, String password) {
        Member member = null;
        String sql = "SELECT * FROM MEMBER WHERE MEMBER_ID = ? AND PASSWORD = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, id);
            pstmt.setString(2, password);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    member = new Member();
                    member.setMemberId(rs.getString("MEMBER_ID"));
                    member.setPassword(rs.getString("PASSWORD"));
                    member.setName(rs.getString("NAME"));
                    member.setPhone(rs.getString("PHONE"));
                    member.setStampCount(rs.getInt("STAMP_COUNT"));
                    member.setAdminYn(rs.getString("ADMIN_YN"));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return member;
    }

    public void insert(Member m) throws Exception {
        String sql = "INSERT INTO MEMBER(MEMBER_ID, PASSWORD, NAME, PHONE, STAMP_COUNT, ADMIN_YN) VALUES(?,?,?,?,?,?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, m.getMemberId());
            pstmt.setString(2, m.getPassword());
            pstmt.setString(3, m.getName());
            pstmt.setString(4, m.getPhone());
            pstmt.setInt(5, m.getStampCount());
            pstmt.setString(6, m.getAdminYn());
            pstmt.executeUpdate();
        }
    }

    public Member find(String id) {
        Member member = null;
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM MEMBER WHERE MEMBER_ID = ?")) {
            pstmt.setString(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    member = new Member();
                    member.setMemberId(rs.getString("MEMBER_ID"));
                    member.setName(rs.getString("NAME"));
                    member.setPhone(rs.getString("PHONE"));
                    member.setStampCount(rs.getInt("STAMP_COUNT"));
                    member.setAdminYn(rs.getString("ADMIN_YN"));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return member;
    }

    public List<Member> findByKeyword(String keyword) {
        List<Member> list = new ArrayList<>();
        String sql = "SELECT * FROM MEMBER";
        if (keyword != null && !keyword.isEmpty()) sql += " WHERE NAME LIKE ? OR MEMBER_ID LIKE ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            if (keyword != null && !keyword.isEmpty()) {
                pstmt.setString(1, "%" + keyword + "%");
                pstmt.setString(2, "%" + keyword + "%");
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Member m = new Member();
                    m.setMemberId(rs.getString("MEMBER_ID"));
                    m.setName(rs.getString("NAME"));
                    m.setPhone(rs.getString("PHONE"));
                    m.setStampCount(rs.getInt("STAMP_COUNT"));
                    m.setAdminYn(rs.getString("ADMIN_YN"));
                    list.add(m);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void update(Member m) throws Exception {
        String sql = "UPDATE MEMBER SET PASSWORD=?, NAME=?, PHONE=?, STAMP_COUNT=?, ADMIN_YN=? WHERE MEMBER_ID=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, m.getPassword());
            pstmt.setString(2, m.getName());
            pstmt.setString(3, m.getPhone());
            pstmt.setInt(4, m.getStampCount());
            pstmt.setString(5, m.getAdminYn());
            pstmt.setString(6, m.getMemberId());
            pstmt.executeUpdate();
        }
    }

    public void delete(String id) {
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement("DELETE FROM MEMBER WHERE MEMBER_ID = ?")) {
            pstmt.setString(1, id);
            pstmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void incrementStamp(String id) {
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement("UPDATE MEMBER SET STAMP_COUNT = STAMP_COUNT + 1 WHERE MEMBER_ID = ?")) {
            pstmt.setString(1, id);
            pstmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}