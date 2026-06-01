package ex11;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {
	private Connection conn;
	private PreparedStatement pstmt;

	private static final String JDBC_DRIVER = "org.h2.Driver";
	private static final String JDBC_URL = "jdbc:h2:~/bookmarketdb";

	public void open() {
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL, "user1", "1234");
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

	public void insert(Member member) {
		open();
		String sql = "INSERT INTO member(member_id, password, name, phone, stamp_count, join_date, admin_yn) VALUES(?, ?, ?, ?, ?, CURRENT_DATE, ?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMemberId());
			pstmt.setString(2, hashPassword(member.getPassword()));
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getPhone());
			pstmt.setInt(5, member.getStampCount() == null ? 0 : member.getStampCount());
			pstmt.setString(6, normalizeAdminYn(member.getAdminYn()));
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public List<Member> findAll() {
		return findByKeyword(null);
	}

	public List<Member> findByKeyword(String keyword) {
		open();
		List<Member> members = new ArrayList<>();

		try {
			String normalizedKeyword = keyword == null ? "" : keyword.trim().toLowerCase();
			boolean hasKeyword = !normalizedKeyword.isEmpty();
			String sql = "SELECT member_id, password, name, phone, stamp_count, join_date, admin_yn FROM member";
			if (hasKeyword) {
				sql += " WHERE LOWER(member_id) LIKE ? OR LOWER(name) LIKE ? OR phone LIKE ?";
			}
			sql += " ORDER BY join_date DESC, member_id ASC";
			pstmt = conn.prepareStatement(sql);
			if (hasKeyword) {
				String likeKeyword = "%" + normalizedKeyword + "%";
				String phoneKeyword = "%" + normalizedKeyword.replaceAll("[^0-9-]", "") + "%";
				pstmt.setString(1, likeKeyword);
				pstmt.setString(2, likeKeyword);
				pstmt.setString(3, phoneKeyword.equals("%%") ? likeKeyword : phoneKeyword);
			}
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				members.add(mapRow(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return members;
	}

	public Member find(String id) {
		open();
		Member member = null;

		try {
			pstmt = conn.prepareStatement("SELECT member_id, password, name, phone, stamp_count, join_date, admin_yn FROM member WHERE member_id = ?");
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				member = mapRow(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return member;
	}

	public Member authenticate(String memberId, String password) {
		open();
		Member member = null;

		try {
			pstmt = conn.prepareStatement("SELECT member_id, password, name, phone, stamp_count, join_date, admin_yn FROM member WHERE member_id = ? AND password = ?");
			pstmt.setString(1, memberId);
			pstmt.setString(2, hashPassword(password));
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				member = mapRow(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return member;
	}

	public void update(Member member) {
		open();
		String sql = "UPDATE member SET password = ?, name = ?, phone = ?, stamp_count = ?, admin_yn = ? WHERE member_id = ?";

		try {
			String passwordToStore = member.getPassword();
			if (passwordToStore == null || passwordToStore.trim().isEmpty()) {
				passwordToStore = findStoredPasswordHash(member.getMemberId());
			} else {
				passwordToStore = hashPassword(passwordToStore);
			}

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, passwordToStore);
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getPhone());
			pstmt.setInt(4, member.getStampCount() == null ? 0 : member.getStampCount());
			pstmt.setString(5, normalizeAdminYn(member.getAdminYn()));
			pstmt.setString(6, member.getMemberId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void delete(String memberId) {
		open();

		try {
			pstmt = conn.prepareStatement("DELETE FROM member WHERE member_id = ?");
			pstmt.setString(1, memberId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void incrementStamp(String memberId) {
		open();

		try {
			pstmt = conn.prepareStatement("UPDATE member SET stamp_count = COALESCE(stamp_count, 0) + 1 WHERE member_id = ?");
			pstmt.setString(1, memberId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	private Member mapRow(ResultSet rs) throws SQLException {
		Member member = new Member();
		member.setMemberId(rs.getString("member_id"));
		member.setPassword(rs.getString("password"));
		member.setName(rs.getString("name"));
		member.setPhone(rs.getString("phone"));
		member.setStampCount(rs.getInt("stamp_count"));
		member.setJoinDate(rs.getString("join_date"));
		member.setAdminYn(rs.getString("admin_yn"));
		return member;
	}

	private String findStoredPasswordHash(String memberId) throws SQLException {
		try (PreparedStatement statement = conn.prepareStatement("SELECT password FROM member WHERE member_id = ?")) {
			statement.setString(1, memberId);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) {
					return rs.getString("password");
				}
			}
		}
		return null;
	}

	private String normalizeAdminYn(String adminYn) {
		return "Y".equalsIgnoreCase(adminYn) ? "Y" : "N";
	}

	private String hashPassword(String password) {
		if (password == null || password.trim().isEmpty()) {
			throw new IllegalArgumentException("비밀번호는 비어 있을 수 없습니다.");
		}

		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] encodedHash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
			StringBuilder builder = new StringBuilder();
			for (byte current : encodedHash) {
				builder.append(String.format("%02x", current));
			}
			return builder.toString();
		} catch (Exception e) {
			throw new IllegalStateException("비밀번호 해시 생성에 실패했습니다.", e);
		}
	}
}
