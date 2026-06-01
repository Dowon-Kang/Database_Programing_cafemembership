package member;

import java.util.Date;

public class MemberDTO {

    private String memberId;
    private String password;
    private String name;
    private String phone;
    private int    stampCount;
    private Date   joinDate;

    public String getMemberId()              { return memberId; }
    public void   setMemberId(String memberId) { this.memberId = memberId; }

    public String getPassword()              { return password; }
    public void   setPassword(String password) { this.password = password; }

    public String getName()                  { return name; }
    public void   setName(String name)       { this.name = name; }

    public String getPhone()                 { return phone; }
    public void   setPhone(String phone)     { this.phone = phone; }

    public int  getStampCount()              { return stampCount; }
    public void setStampCount(int stampCount) { this.stampCount = stampCount; }

    public Date getJoinDate()                { return joinDate; }
    public void setJoinDate(Date joinDate)   { this.joinDate = joinDate; }
}
