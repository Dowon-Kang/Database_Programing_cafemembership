package ex11;

import java.sql.Timestamp;

public class Member {
    private String memberId;
    private String password;
    private String name;
    private String phone;
    private int stampCount;    // 반드시 소문자 int
    private String adminYn;
    private Timestamp joinDate; // 반드시 Timestamp

    public Member() {}

    public String getMemberId() { return memberId; }
    public void setMemberId(String memberId) { this.memberId = memberId; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getStampCount() { return stampCount; }
    public void setStampCount(int stampCount) { this.stampCount = stampCount; }

    public String getAdminYn() { return adminYn; }
    public void setAdminYn(String adminYn) { this.adminYn = adminYn; }

    public Timestamp getJoinDate() { return joinDate; }
    public void setJoinDate(Timestamp joinDate) { this.joinDate = joinDate; }

    public boolean isAdmin() {
        return "Y".equals(this.adminYn);
    }
}