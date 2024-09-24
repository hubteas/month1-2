-- 사용자 정보를 저장하는 유저 테이블
-- test계정으로 로그인 한 상태에서 진행

-- 테이블명 : TBL_USER
-- 시퀀스명 : SEQ_USER

-- 사용자 번호 : USER_NUMBER NUMBER -> PK   PK_USER
-- 아이디 : USER_ID VARCHAR2(100)
-- 비밀번호 : USER_PASSWORD VARCHAR2(100)
-- 이름 : USER_NAME VARCHAR2(100)
-- 나이 : USER_AGE NUMBER
-- 성별 : USER_GENDER CHAR(1) DEFAULT 'M'
-- 생일 : USER_BIRTH DATE
CREATE SEQUENCE SEQ_USER;

CREATE TABLE TBL_USER(
	USER_NUMBER NUMBER,
	USER_ID VARCHAR2(100),
	USER_PASSWORD VARCHAR2(100),
	USER_NAME VARCHAR2(100),
	USER_AGE NUMBER,
	USER_GENDER CHAR(1) DEFAULT 'M',
	USER_BIRTH DATE,
	CONSTRAINT PK_USER PRIMARY KEY(USER_NUMBER)
);

SELECT * FROM TBL_USER;

INSERT INTO TBL_USER 
VALUES(SEQ_USER.NEXTVAL, 'KYS', 'ABC123', '김영선', 10, 'W', '2019-01-01');


INSERT INTO tbl_user(user_number, user_id, user_password, user_name, user_age, user_birth)
values(seq_user.nextval, 'sss', '1234', '신', 10, '2019-01-01');

SELECT user_number
FROM TBL_USER
WHERE USER_id = 'sss';


INSERT INTO tbl_user(user_number, user_id, USER_PASSWORD, USER_NAME, USER_AGE,USER_GENDER, USER_BIRTH)
VALUES(seq_user.nextval, 'aaaa', '1234', '짱구',5,'M','2020-01-01');


SELECT user_number
FROM TBL_USER
WHERE USER_ID = 'abc123' AND USER_PASSWORD = '1234';

--   // 이름과 생일로 아이디 찾기(20분)


SELECT USER_NUMBER , USER_ID , USER_PASSWORD , USER_NAME , USER_AGE, USER_GENDER ,USER_BIRTH 
FROM TBL_USER
WHERE USER_NUMBER = 1;


SELECT user_id
FROM TBL_USER
WHERE USER_NAME ='짱구' AND USER_BIRTH = '2020-01-01';

SELECT * FROM TBL_USER tu ;

UPDATE TBL_USER 
SET USER_ID = 'xyz', USER_PASSWORD = '123', user_name = '철수', user_age = 6, user_gender = 'm', USER_BIRTH = '20240722'
WHERE USER_NUMBER 23;

--//   생일로 회원 조회하기
--//   user_number, user_id, user_password, user_name, user_age, user_gender, user_birth


SELECT user_number, user_id, user_password, user_name, user_age, user_gender, user_birth
FROM TBL_USER
WHERE USER_BIRTH = '20200101';