-- 1. test 계정 생성, 비밀번호 1234
-- 2. test 계정으로 로그인
-- 3. 테이블 생성 : 제약조건 PK, FK, NOT NULL
-- (학생정보를 담는 학생 테이블 web_stu)
--      학생번호 stu_id 숫자타입
--       학생이름 stu_name 문자열(100)
--      전공번호 major_id 숫자타입

-- (전공정보를 담는 테이블 web_major)
--       전공번호 major_id 숫자타입
--      전공명  major_name 문자열(100)

-- (과목정보를 담는 테이블 web_subject)
--       과목번호 subject_id 숫자타입
--      과목명   subject_name 문자열(100)

-- (학생 점수를 담는 테이블 web_score) => 단, 조합키사용할것(컬럼명은 2개만 이용)
--     학생번호 stu_id 숫자타입
--      전공번호 major_id 숫자타입
--       과목번호 subject_id 숫자타입
--       점수      score_grade 숫자타입


CREATE USER test IDENTIFIED by 1234;

GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, resource TO test;
--DROP TABLE WEB_SCORE;+
--DROP TABLE web_stu;
CREATE TABLE web_stu(
   stu_id NUMBER PRIMARY KEY,
   stu_name varchar2(100) NOT null,
   major_id NUMBER NOT NULL,
   CONSTRAINT fk_web_stu FOREIGN key(major_id)
   REFERENCES web_major(major_id)
);
--DROP TABLE WEB_MAJOR;
CREATE TABLE web_major(
   major_id NUMBER PRIMARY KEY,
   major_name varchar2(100) NOT null
);

--DROP TABLE WEB_SUBJECT;
CREATE TABLE web_subject(
   subject_id NUMBER PRIMARY KEY,
   subject_name varchar2(100) NOT null
);

--DROP TABLE web_score;
CREATE TABLE web_score(
   stu_id NUMBER NOT null,
   major_id NUMBER NOT null,
   subject_id NUMBER NOT null,
   score_grade NUMBER NOT null,
   CONSTRAINT pk_web_score PRIMARY key(stu_id, subject_id),
   CONSTRAINT fk_web_score_stu FOREIGN KEY(stu_id) REFERENCES web_stu(stu_id),
   CONSTRAINT fk_web_score_major FOREIGN KEY(major_id) REFERENCES web_major(major_id),
   CONSTRAINT fk_web_score_subject FOREIGN KEY(subject_id) REFERENCES web_subject(subject_id)
);

SELECT * FROM WEB_MAJOR;
SELECT * FROM WEB_SCORE;
SELECT * FROM WEB_STU;
SELECT * FROM WEB_SUBJECT;

-- Sequence 추가
--DROP SEQUENCE seq_stu;
CREATE SEQUENCE seq_stu
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;

--DROP SEQUENCE seq_major;
CREATE SEQUENCE seq_major
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;
--DROP SEQUENCE seq_subject;
CREATE SEQUENCE seq_subject
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;
      
-- 2. 데이터 삽입하기(각 테이블에 시퀀스를 이용해서 데이터 삽입할 것)
-- 학생데이터 : 짱구(컴공과), 철수(인지과), 훈이(보호과), 맹구(보호과), 유리(컴공과), 치타(인지과)
-- 전공데이터 : 컴퓨터 공학과, 인공지능학과, 정보보호 학과
-- 과목데이터 : 정보보호개론, 자바프로그래밍, 파이썬프로그래밍, 데이터베이스, 자료구조개론, 운영체제, 데이터 분석, 딥러닝
-- 성적데이터 :짱구-자료구조개론(90점), 자바프로그래밍(100점)
--         철수-파이썬프로그래밍(88점), 딥러닝(30점)
--         치타-파이썬프로그래밍(100점), 데이터분석(74점), 딥러닝(50점)
--         훈이 - 운영체제(62점), 정보보호 개론(77점)
--         유리 - 데이터베이스(89점), 자료구조개론(100점), 운영체제(66점)
--         맹구 - 정보보호개론(10점), 파이썬 프로그래밍(20점), 운영체제(60점)

-- 데이터추가 web_major
SELECT * FROM WEB_MAJOR;
INSERT INTO WEB_MAJOR
values(seq_major.nextval, '컴퓨터공학과');
INSERT INTO WEB_MAJOR
values(seq_major.nextval, '인공지능학과');
INSERT INTO WEB_MAJOR
values(seq_major.nextval, '정보보호학과');

-- 데이터추가 web_subject
-- 과목데이터 : 정보보호개론, 자바프로그래밍, 파이썬프로그래밍, 데이터베이스, 자료구조개론, 운영체제, 데이터 분석, 딥러닝
SELECT * FROM WEB_SUBJECT;
INSERT INTO WEB_SUBJECT
values(seq_subject.nextval, '정보보호개론');
INSERT INTO WEB_SUBJECT
values(seq_subject.nextval, '자바프로그래밍');
INSERT INTO WEB_SUBJECT
values(seq_subject.nextval, '파이썬프로그래밍');
INSERT INTO WEB_SUBJECT
values(seq_subject.nextval, '데이터베이스');
INSERT INTO WEB_SUBJECT
values(seq_subject.nextval, '자료구조개론');
INSERT INTO WEB_SUBJECT
values(seq_subject.nextval, '운영체제');
INSERT INTO WEB_SUBJECT
values(seq_subject.nextval, '데이터 분석');
INSERT INTO WEB_SUBJECT
values(seq_subject.nextval, '딥러닝');

-- 데이터추가 web_stu
SELECT * FROM WEB_STU;
--DROP SEQUENCE seq_stu;
--DELETE FROM web_stu;
INSERT INTO WEB_STU
values(seq_stu.nextval, '짱구',1);
INSERT INTO WEB_STU
values(seq_stu.nextval, '철수',2);
INSERT INTO WEB_STU
values(seq_stu.nextval, '훈이',3);
INSERT INTO WEB_STU
values(seq_stu.nextval, '맹구',3);
INSERT INTO WEB_STU
values(seq_stu.nextval, '유리',1);
INSERT INTO WEB_STU
values(seq_stu.nextval, '치타',2);

SELECT * FROM WEB_SCORE;
SELECT * FROM WEB_STU;
SELECT * FROM WEB_SUBJECT;
SELECT * FROM WEB_MAJOR;

-- 데이터추가 web_score
--DELETE FROM web_score;
INSERT INTO WEB_SCORE
values(1, 1, 5,90);
INSERT INTO WEB_SCORE
values(1, 1, 2,100);
--철수
INSERT INTO WEB_SCORE
values(2, 2, 3,88);
INSERT INTO WEB_SCORE
values(2, 2, 8,30);
--치타
INSERT INTO WEB_SCORE
values(6, 2, 3,100);
INSERT INTO WEB_SCORE
values(6, 2, 7,74);
INSERT INTO WEB_SCORE
values(6, 2, 8,50);
--훈이
INSERT INTO WEB_SCORE
values(3, 3, 6,62);
INSERT INTO WEB_SCORE
values(3, 3, 1,77);
--유리
INSERT INTO WEB_SCORE
values(5,1,4,89);
INSERT INTO WEB_SCORE
values(5,1,5,100);
INSERT INTO WEB_SCORE
values(5,1,6,66);
--맹구
INSERT INTO WEB_SCORE
values(4,3,1,10);
INSERT INTO WEB_SCORE
values(4,3,3,20);
INSERT INTO WEB_SCORE
values(4,3,6,60);

SELECT * FROM WEB_SCORE;
SELECT * FROM WEB_SUBJECT;
SELECT * FROM WEB_STU;
SELECT * FROM WEB_MAJOR;
-- 3. 각 학생의 이름과 수강 과목 이름 조회하기
SELECT STU_ID, SUBJECT_ID
FROM WEB_SCORE;

SELECT STU_NAME, SUBJECT_NAME
FROM WEB_STU A, WEB_SUBJECT B, (SELECT STU_ID, SUBJECT_ID
FROM WEB_SCORE)C
WHERE A.STU_ID = C.STU_ID AND B.SUBJECT_ID = C.SUBJECT_ID;
-- 4. 평균점수가 80점 이상인 학생의 이름 조회하기
-- SCORE테이블에서 STU_ID와 평균점수조회
SELECT STU_ID, AVG(SCORE_GRADE) 
FROM WEB_SCORE
GROUP BY STU_ID;

SELECT * FROM WEB_STU;

--JOIN을 이용하여평균점수가 80점 이상인 학생 조회
SELECT STU_NAME, B.AVG_SCORE
FROM WEB_STU A JOIN (SELECT STU_ID, AVG(SCORE_GRADE) AVG_SCORE
					FROM WEB_SCORE
					GROUP BY STU_ID)B
ON A.STU_ID = B.STU_ID
WHERE B.AVG_SCORE >=80;

-- 5. 운영체제 과목을 수강한 학생의 이름 조회하기
SELECT * FROM WEB_SCORE;
SELECT * FROM WEB_SUBJECT;
SELECT * FROM WEB_STU;

--WEB_SUBJECT에서 운영체제의 SUBJECT_ID가 무엇인지 조회
SELECT SUBJECT_ID
FROM WEB_SUBJECT
WHERE SUBJECT_NAME ='운영체제';

--SCORE테이블에서 운영체제의 점수를 가지고 있는 학생ID 조회
SELECT STU_ID
FROM WEB_SCORE
WHERE SUBJECT_ID = (SELECT SUBJECT_ID
FROM WEB_SUBJECT
WHERE SUBJECT_NAME ='운영체제');

--STU테이블에서 해당 ID와 일치하는 학생명 조회
SELECT STU_NAME
FROM WEB_STU A, 
	(SELECT STU_ID FROM WEB_SCORE WHERE SUBJECT_ID = (SELECT SUBJECT_ID
													FROM WEB_SUBJECT
													WHERE SUBJECT_NAME ='운영체제')) B
WHERE A.STU_ID = B.STU_ID;
-- 6. 학과별 최고점과 최저점 조회하기

--SCORE테이블에서 최고점 최저점 조회후 MAJOR_ID로 그룹화
SELECT MAJOR_ID,MAX(SCORE_GRADE), MIN(SCORE_GRADE)
FROM WEB_SCORE
GROUP BY MAJOR_ID;

--JOIN을 이용하여 학과별 이름으로 조회
SELECT A.MAJOR_NAME, B.최고점, B.최저점
FROM WEB_MAJOR A JOIN (SELECT MAJOR_ID, MAX(SCORE_GRADE) 최고점, MIN(SCORE_GRADE) 최저점
						FROM WEB_SCORE
						GROUP BY MAJOR_ID) B
ON A.MAJOR_ID = B.MAJOR_ID;

-- 7. 학과별 최고점을 받은 학생의 이름 조회하기
SELECT * FROM WEB_SCORE;
SELECT * FROM WEB_STU;
--학과별 최고점 조회
SELECT MAJOR_ID, MAX(SCORE_GRADE)
FROM WEB_SCORE
GROUP BY MAJOR_ID;

--학과별 최고점을 받은 학생ID 조회
SELECT A.STU_ID, A.MAJOR_ID , B.최고점
FROM WEB_SCORE A JOIN (SELECT MAJOR_ID, MAX(SCORE_GRADE) 최고점
FROM WEB_SCORE
GROUP BY MAJOR_ID) B
ON A.MAJOR_ID = B.MAJOR_ID
WHERE A.SCORE_GRADE = B.최고점

-- 학과별 최고점을 받은 학생의 이름조회
SELECT S1.STU_NAME, S2.MAJOR_ID
FROM WEB_STU S1, 
	(SELECT A.STU_ID, A.MAJOR_ID , B.최고점 FROM WEB_SCORE A JOIN (SELECT MAJOR_ID, MAX(SCORE_GRADE) 최고점
																	FROM WEB_SCORE
																	GROUP BY MAJOR_ID) B
															ON A.MAJOR_ID = B.MAJOR_ID
															WHERE A.SCORE_GRADE = B.최고점) S2
WHERE S1.STU_ID =S2.STU_ID;
-- 8. 각 학생의 이름과 전공명 조회하기
SELECT * FROM WEB_MAJOR;
SELECT * FROM WEB_STU;

SELECT STU_NAME, MAJOR_NAME
FROM WEB_STU A , WEB_MAJOR B
WHERE A.MAJOR_ID = B.MAJOR_ID;

-- 9. 각 전공의 평균점수 조회하기

SELECT MAJOR_ID, AVG(SCORE_GRADE)
FROM WEB_SCORE
GROUP BY MAJOR_ID;

SELECT A.MAJOR_NAME, B.평균
FROM WEB_MAJOR A, (SELECT MAJOR_ID, AVG(SCORE_GRADE) 평균
FROM WEB_SCORE
GROUP BY MAJOR_ID)B
WHERE A.MAJOR_ID = B.MAJOR_ID;

-- 10. 데이터베이스를 수강한 학생의 이름과 점수 조회하기
SELECT SUBJECT_ID
FROM WEB_SUBJECT
WHERE SUBJECT_NAME = '데이터베이스';

SELECT STU_ID, SCORE_GRADE
FROM WEB_SCORE
WHERE SUBJECT_ID = (SELECT SUBJECT_ID
					FROM WEB_SUBJECT
					WHERE SUBJECT_NAME = '데이터베이스');
				
SELECT STU_NAME, SCORE_GRADE
FROM WEB_STU A, (SELECT STU_ID, SCORE_GRADE	FROM WEB_SCORE WHERE SUBJECT_ID = (SELECT SUBJECT_ID
																			FROM WEB_SUBJECT
																			WHERE SUBJECT_NAME = '데이터베이스'))B
WHERE A.STU_ID = B.STU_ID;

-- 11. 각 과목의 평균점수 조회하기
SELECT SUBJECT_ID, AVG(SCORE_GRADE)
FROM WEB_SCORE
GROUP BY SUBJECT_ID;

SELECT A.SUBJECT_NAME 과목명, B.평균점
FROM WEB_SUBJECT A, (SELECT SUBJECT_ID, AVG(SCORE_GRADE) 평균점
					FROM WEB_SCORE
					GROUP BY SUBJECT_ID)B
WHERE A.SUBJECT_ID = B.SUBJECT_ID;
-- 12. 최고점수를 받은 학생의 이름과 과목명 조회하기
SELECT MAX(SCORE_GRADE)
FROM WEB_SCORE;

SELECT STU_ID, SUBJECT_ID
FROM WEB_SCORE
WHERE SCORE_GRADE = (SELECT MAX(SCORE_GRADE)
FROM WEB_SCORE);

SELECT STU_NAME, SUBJECT_NAME
FROM WEB_STU A, WEB_SUBJECT B, (SELECT STU_ID, SUBJECT_ID FROM WEB_SCORE
								WHERE SCORE_GRADE = (SELECT MAX(SCORE_GRADE)
								FROM WEB_SCORE)) C
WHERE A.STU_ID =C.STU_ID AND B.SUBJECT_ID = C.SUBJECT_ID;


-- 13. 모든 학생의 이름과 전공명, 과목명, 점수를 조회하되 점수가 50점 이상인 데이터만 출력하기
SELECT STU_ID, MAJOR_ID, SUBJECT_ID, SCORE_GRADE
FROM WEB_SCORE
WHERE SCORE_GRADE >=50;

SELECT A.STU_NAME, B.MAJOR_NAME, C.SUBJECT_NAME, D.SCORE_GRADE
FROM WEB_STU A, WEB_MAJOR B, WEB_SUBJECT C, (SELECT STU_ID, MAJOR_ID, SUBJECT_ID, SCORE_GRADE
											FROM WEB_SCORE
											WHERE SCORE_GRADE >=50) D
WHERE A.STU_ID =D.STU_ID AND B.MAJOR_ID =D.MAJOR_ID AND C.SUBJECT_ID = D.SUBJECT_ID
ORDER BY STU_NAME;

-- 14. 과목별 최고점수를 받은 학생의 이름과 과목명을 조회하기
SELECT SUBJECT_ID ,MAX(SCORE_GRADE)
FROM WEB_SCORE
GROUP BY SUBJECT_ID;

--과목별 최고점수를 받은 학생ID와 SUBJECT_ID 조회
SELECT A.STU_ID, A.SUBJECT_ID
FROM WEB_SCORE A JOIN (SELECT SUBJECT_ID ,MAX(SCORE_GRADE)최고점
FROM WEB_SCORE
GROUP BY SUBJECT_ID)B
ON A.SUBJECT_ID = B.SUBJECT_ID
WHERE A.SCORE_GRADE = B.최고점;

SELECT STU_NAME, SUBJECT_NAME
FROM WEB_STU S1, WEB_SUBJECT S2, (SELECT A.STU_ID 최고학생, A.SUBJECT_ID 최고과목
									FROM WEB_SCORE A JOIN (SELECT SUBJECT_ID ,MAX(SCORE_GRADE)최고점
															FROM WEB_SCORE
															GROUP BY SUBJECT_ID)B
									ON A.SUBJECT_ID = B.SUBJECT_ID
								WHERE A.SCORE_GRADE = B.최고점) S3
WHERE S1.STU_ID = S3.최고학생 AND S2.SUBJECT_ID = S3.최고과목;
-- 15. 평균점수보다 높은 점수를 받은 학생의 이름 조회하기(? 모든과목 전체평균보다 한과목이라도 높은 점수를 받은 학생의 이름을 구하는건지)
--전체과목평균구하기
SELECT AVG(SCORE_GRADE)
FROM WEB_SCORE;

--평균보다 높은점수를 받은 학생ID조회
SELECT STU_ID
FROM WEB_SCORE
WHERE SCORE_GRADE > (SELECT AVG(SCORE_GRADE)
FROM WEB_SCORE);

--한과목이라도 전체평균보다 높게 받은 학생이름조회
SELECT DISTINCT STU_NAME
FROM WEB_STU A, (SELECT STU_ID, SCORE_GRADE FROM WEB_SCORE WHERE SCORE_GRADE > (SELECT AVG(SCORE_GRADE)
																	FROM WEB_SCORE)
				)B
WHERE A.STU_ID = B.STU_ID;