package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {

    public void insert(MemberDTO m) {
        String sql = "INSERT INTO member(member_id, password, name, phone, stamp_count, join_date) "
                   + "VALUES(?, ?, ?, ?, 0, CURRENT_DATE)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, m.getMemberId());
            pstmt.setString(2, m.getPassword());
            pstmt.setString(3, m.getName());
            pstmt.setString(4, m.getPhone());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    public MemberDTO findById(String memberId) {
        String sql = "SELECT * FROM member WHERE member_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MemberDTO m = null;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                m = toDTO(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return m;
    }

    public List<MemberDTO> findAll() {
        String sql = "SELECT * FROM member ORDER BY join_date DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<MemberDTO> list = new ArrayList<>();
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(toDTO(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    public void update(MemberDTO m) {
        String sql = "UPDATE member SET password=?, name=?, phone=?, stamp_count=? WHERE member_id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, m.getPassword());
            pstmt.setString(2, m.getName());
            pstmt.setString(3, m.getPhone());
            pstmt.setInt(4, m.getStampCount());
            pstmt.setString(5, m.getMemberId());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    public void delete(String memberId) {
        String sql = "DELETE FROM member WHERE member_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    public List<MemberDTO> search(String keyword) {
        String sql = "SELECT * FROM member WHERE name LIKE ? OR phone LIKE ? ORDER BY join_date DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<MemberDTO> list = new ArrayList<>();
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            String kw = "%" + keyword + "%";
            pstmt.setString(1, kw);
            pstmt.setString(2, kw);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(toDTO(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    public boolean existsId(String memberId) {
        String sql = "SELECT COUNT(*) FROM member WHERE member_id = ?";
        return countQuery(sql, memberId) > 0;
    }

    public boolean existsPhone(String phone) {
        String sql = "SELECT COUNT(*) FROM member WHERE phone = ?";
        return countQuery(sql, phone) > 0;
    }

    public MemberDTO login(String memberId, String password) {
        String sql = "SELECT * FROM member WHERE member_id = ? AND password = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MemberDTO m = null;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                m = toDTO(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return m;
    }

    private int countQuery(String sql, String param) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        try {
            conn  = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, param);
            rs = pstmt.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return count;
    }

    private MemberDTO toDTO(ResultSet rs) throws Exception {
        MemberDTO m = new MemberDTO();
        m.setMemberId(rs.getString("member_id"));
        m.setPassword(rs.getString("password"));
        m.setName(rs.getString("name"));
        m.setPhone(rs.getString("phone"));
        m.setStampCount(rs.getInt("stamp_count"));
        m.setJoinDate(rs.getDate("join_date"));
        return m;
    }
}
