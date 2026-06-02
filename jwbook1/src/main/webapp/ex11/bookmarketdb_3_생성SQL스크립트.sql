DROP TABLE IF EXISTS MEMBER;

CREATE TABLE MEMBER (
    member_id VARCHAR(20) NOT NULL,
    password VARCHAR(100) NOT NULL,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    image_url VARCHAR(500),
    stamp_count INT DEFAULT 0,
    join_date DATE DEFAULT CURRENT_DATE,
	admin_yn CHAR(1) DEFAULT 'N' NOT NULL,
    CONSTRAINT PK_MEMBER PRIMARY KEY (member_id),
	CONSTRAINT UQ_MEMBER_PHONE UNIQUE (phone),
	CONSTRAINT CK_MEMBER_ADMIN_YN CHECK (admin_yn IN ('Y', 'N'))
);

COMMENT ON TABLE MEMBER IS '카페 멤버십 회원 테이블';
COMMENT ON COLUMN MEMBER.member_id IS '회원 로그인 아이디 [PK]';
COMMENT ON COLUMN MEMBER.password IS '암호화된 비밀번호';
COMMENT ON COLUMN MEMBER.name IS '회원 이름';
COMMENT ON COLUMN MEMBER.phone IS '전화번호 (매장 적립 및 검색용) [UQ]';
COMMENT ON COLUMN MEMBER.image_url IS '회원 프로필 이미지 URL';
COMMENT ON COLUMN MEMBER.stamp_count IS '보유 스탬프 개수 (기본값 0)';
COMMENT ON COLUMN MEMBER.join_date IS '회원 가입일 (기본값 현재 날짜)';
COMMENT ON COLUMN MEMBER.admin_yn IS '관리자 계정 여부 (Y/N)';

INSERT INTO MEMBER (member_id, password, name, phone, stamp_count, admin_yn)
VALUES ('admin', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '관리자', '010-0000-0000', 0, 'Y');

INSERT INTO MEMBER (member_id, password, name, phone, stamp_count, admin_yn)
VALUES ('cafe01', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '김하늘', '010-1111-2222', 3, 'N');

INSERT INTO MEMBER (member_id, password, name, phone, stamp_count, admin_yn)
VALUES ('cafe02', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '이서준', '010-3333-4444', 8, 'N');

INSERT INTO MEMBER (member_id, password, name, phone, stamp_count, admin_yn)
VALUES ('cafe03', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '박민지', '010-5555-6666', 12, 'N');

SELECT * FROM MEMBER;