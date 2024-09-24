DROP TABLE web_books CASCADE constraint;
DROP TABLE WEB_BOOKSPRICE CASCADE CONSTRAINT;

CREATE TABLE web_books(
	books_id number PRIMARY KEY,
	books_name varchar2(100),
	books_author varchar2(100)
);

SELECT * FROM web_books wb;

CREATE TABLE web_booksprice(
	bp_id NUMBER PRIMARY KEY,
	bp_price number
);

SELECT * FROM WEB_BOOKSPRICE wp ;
insert INTO WEB_BOOKS 
values(1, '위대한 개츠비', 'F. 스콧 피츠제럴드');
insert INTO WEB_BOOKS 
values(2, '해리 포터와 마법사의 돌', 'J.K. 롤링');
insert INTO WEB_BOOKS
values(3, '1984', '조지 오웰');
insert INTO WEB_BOOKS
values(4, '오만과 편견', '제인 오스틴');
insert INTO WEB_BOOKS
values(5, '데미안', '헤르만 헤세');
insert INTO WEB_BOOKS
values(6, '모모', '미하엘 엔더');


INSERT INTO WEB_BOOKSPRICE
values(1, 15000);
INSERT INTO WEB_BOOKSPRICE
values(2, 18000);
INSERT INTO WEB_BOOKSPRICE
values(3, 14000);
INSERT INTO WEB_BOOKSPRICE
values(4, 17000);
INSERT INTO WEB_BOOKSPRICE
values(5, 18000);
SELECT * FROM WEB_BOOKSPRICE;
SELECT * FROM WEB_BOOKSPRICE;

--1) 왼쪽 외부조인

SELECT * 
FROM WEB_BOOKS wb LEFT OUTER JOIN WEB_BOOKSPRICE WP
ON wb.BOOKS_ID = wp.BP_ID;

--2)오른쪽 외부조인
SELECT a.books_id, a.books_name, a.books_author, b.bp_id, b.bp_price
FROM WEB_BOOKS a RIGHT OUTER JOIN WEB_BOOKSPRICE B
ON a.BOOKS_ID = b.BP_ID ;

INSERT INTO WEB_BOOKSPRICE wb 
values(7, 19000);

--3) 완전 외부조인
SELECT a.books_id, a.books_name, a.books_author, b.bp_id, b.bp_price
FROM WEB_BOOKS a full OUTER JOIN WEB_BOOKSPRICE B
ON a.BOOKS_ID = b.BP_ID ;

CREATE TABLE web_grade(
	grade_num NUMBER,
	grade_name varchar2(100),
	CONSTRAINT pk_grade PRIMARY key(grade_num)
);


CREATE TABLE web_user(
	user_num NUMBER,
	user_id varchar2(100),
	grade_num NUMBER,
	CONSTRAINT pk_user PRIMARY key(user_num),
	CONSTRAINT fk_user FOREIGN key(grade_num)
	REFERENCES web_grade(grade_num)
);

SELECT * FROM web_grade;
SELECT * FROM web_user;

INSERT INTO web_grade
values(1,'vvip');
INSERT INTO web_grade
values(2,'vip');
INSERT INTO web_grade
values(3,'normal');

INSERT INTO web_user
values(1,'A',1);
INSERT INTO web_user
values(2,'B',2);

-- 1) INNER JOIN
SELECT *
FROM web_grade a JOIN WEB_USER B
ON a.grade_num = b.grade_num;

-- 2) LEFT OUTER JOIN
SELECT *
FROM web_grade a LEFT JOIN WEB_USER B
ON a.grade_num = b.grade_num;

-- 3) RIGHT OUTER JOIN
SELECT *
FROM web_grade a right JOIN WEB_USER B
ON a.grade_num = b.grade_num;

-- 4) FULL OUTER JOIN 
SELECT *
FROM web_grade a FULL JOIN WEB_USER B
ON a.grade_num = b.grade_num;

--[실습] 
-- 1.jobs테이블에서 job_id로 직원들의 job_title, email, 
-- 성, 이름(성과 이름은 한칸 띄어쓰기로 이름이라는 별칭으로) 조회하기
SELECT count(*) FROM jobs; --19행
SELECT count(*) FROM EMPLOYEES e ; --107행

SELECT j.JOB_TITLE , e.EMAIL , concat(concat(e.LAST_NAME,' '), e.FIRST_NAME) 이름
FROM jobs j JOIN EMPLOYEES e 
ON j.JOB_ID = e.JOB_ID;

--2. employees 테이블에서 hiredate가 2003~2004년까지인 사원의 정보와 부서명 조회하기
SELECT E.FIRST_NAME, E.HIRE_DATE, D.DEPARTMENT_ID , DEPARTMENT_NAME 
FROM EMPLOYEES e JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
WHERE HIRE_DATE BETWEEN TO_DATE('2003-01-01', 'YYYY-MM-DD') 
                   AND TO_DATE('2004-12-31', 'YYYY-MM-DD');

-- 3. EMPLOYEES 테이블에서 각 사원의 매니저 이름 조회하기
-- 이름은 성과 이름을 띄어쓰기로 하나의 컬럼으로 조회할 것
-- 사원번호, 사원이름, 매니저번호, 매니저이름
                  
-- SELF JOIN
SELECT * FROM EMPLOYEES e ;

SELECT e.employee_id 사원번호,
	e.FIRST_name||' '||e.last_name 사원이름 ,
	e2.EMPLOYEE_ID 매니저번호,
	e2.FIRST_NAME||' '||e2.LAST_NAME 매니저이름
FROM EMPLOYEES e LEFT JOIN EMPLOYEES e2 
ON e.manager_id = e2.EMPLOYEE_ID
ORDER BY e.EMPLOYEE_ID;


--3. 형 변환 함수
SELECT SYSDATE
FROM DUAL;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY.MM.DD'), TO_CHAR(SYSDATE, 'YYYY/MM/DD-HH:MI:SS'),
--	2024년 7월 15일 21시 33분
	TO_CHAR(SYSDATE,'YYYY"년" MM"월" DD"일" HH24"시" MI"분"'),
	TO_CHAR(SYSDATE,'YYYYMMDDHH24MI')
FROM DUAL;

SELECT TO_CHAR(12312312, '999,999,999'), TO_CHAR(12312312, '000,000,000')
FROM DUAL;
SELECT 12312312
FROM DUAL;

SELECT '1000', 1000, TO_NUMBER('1000')
FROM DUAL;

SELECT TO_DATE('1999-9-9 09:09:09', 'YYYY-MM-DD HH:MI:SS')
FROM DUAL;


-- 4. 집합

SELECT * FROM EMPLOYEES
WHERE DEPARTMENT_ID = 30;

SELECT * FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 10;

SELECT * FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 30
UNION 
SELECT * FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 10;

SELECT * FROM EMPLOYEES e 
WHERE DEPARTMENT_ID = 30
UNION 
SELECT * FROM EMPLOYEES e 
WHERE DEPARTMENT_ID = 30;

SELECT * FROM EMPLOYEES e 
WHERE DEPARTMENT_ID = 30
UNION ALL
SELECT * FROM EMPLOYEES e 
WHERE DEPARTMENT_ID = 30;
UNION
SELECT * FROM EMPLOYEES E
WHERE DEPARTMENT_ID =30;

SELECT * FROM EMPLOYEES E
WHERE DEPARTMENT_ID =30
UNION ALL
SELECT * FROM EMPLOYEES E
WHERE DEPARTMENT_ID =30;