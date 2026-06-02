package ex11;

import java.sql.*;
import java.util.*;

public class MemberDAO {
    
    public Connection getConnection() throws Exception {
        Class.forName("org.h2.Driver");
        String url = "jdbc:h2:tcp://localhost/~/test"; 
        return DriverManager.getConnection(url, "user1", "1234");
    }

    public Member authenticate(String id, String password) {
        Member member = null;
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM MEMBER WHERE MEMBER_ID = ? AND PASSWORD = ?")) {
            pstmt.setString(1, id);
            pstmt.setString(2, password);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) member = mapMember(rs);
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
                if (rs.next()) member = mapMember(rs);
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
                while (rs.next()) list.add(mapMember(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    private Member mapMember(ResultSet rs) throws Exception {
        Member m = new Member();
        m.setMemberId(rs.getString("MEMBER_ID"));
        m.setPassword(rs.getString("PASSWORD"));
        m.setName(rs.getString("NAME"));
        m.setPhone(rs.getString("PHONE"));
        m.setStampCount(rs.getInt("STAMP_COUNT"));
        m.setAdminYn(rs.getString("ADMIN_YN"));
        m.setJoinDate(rs.getTimestamp("JOIN_DATE")); // 가입일 처리
        return m;
    }

    public void incrementStamp(String id) {
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement("UPDATE MEMBER SET STAMP_COUNT = STAMP_COUNT + 1 WHERE MEMBER_ID = ?")) {
            pstmt.setString(1, id);
            pstmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
    
    // update, delete 메서드 생략 (기존과 동일)
}