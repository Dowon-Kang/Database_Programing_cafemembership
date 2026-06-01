-- MEMBER 테이블 생성 (H2 DB)
CREATE TABLE IF NOT EXISTS MEMBER (
    member_id   VARCHAR(20)  PRIMARY KEY,
    password    VARCHAR(100) NOT NULL,
    name        VARCHAR(50)  NOT NULL,
    phone       VARCHAR(20)  UNIQUE NOT NULL,
    stamp_count INT          DEFAULT 0,
    join_date   DATE         DEFAULT CURRENT_DATE
);

-- 테스트 데이터
INSERT INTO MEMBER(member_id, password, name, phone, stamp_count, join_date)
VALUES ('admin', '1234', '관리자', '010-0000-0000', 0, CURRENT_DATE);

INSERT INTO MEMBER(member_id, password, name, phone, stamp_count, join_date)
VALUES ('hong', '1234', '홍길동', '010-1234-5678', 5, CURRENT_DATE);
