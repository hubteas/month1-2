-- 1. 서브쿼리

SELECT *
FROM EMPLOYEES e ;

--[복습] 핸드폰 번호가 515로 시작하는 사원들의 job_id별 salary 평균을 구한다
-- 조회컬럼은 담당업무, 평균급여로 별칭을 붙여 결과확인 할 수 있도록 한다 
-- 평균 급여가 높은 순으로 정렬한다

-- job_id별 salary 평균 조회
SELECT job_id, salary
FROM EMPLOYEES e ;


SELECT job_id
FROM EMPLOYEES e;

SELECT avg(salary)
FROM EMPLOYEES e;

-- 행이 다르기 때문에 그룹으로 묶는다(group by 컬럼명 : job_id)
SELECT job_id, avg(salary)
FROM EMPLOYEES e 
GROUP BY job_id;

-- 핸드폰 번호가 515로 시작하는 직원의 job_id와 급여 조회
SELECT job_id, salary
FROM EMPLOYEES e 
WHERE PHONE_NUMBER LIKE '515%';

SELECT * FROM EMPLOYEES e;


SELECT job_id, avg(salary)
FROM EMPLOYEES e 
WHERE PHONE_NUMBER LIKE '515%'
GROUP BY job_id;

--1) SELECT 절에서의 서브쿼리
-- 직원의 부서이름을 조회 (직원의 이름, 성, 부서명)
SELECT * FROM EMPLOYEES e ;
SELECT * FROM DEPARTMENTS d ;

SELECT FIRST_NAME 
	, LAST_NAME 
	, (SELECT DEPARTMENT_NAME FROM DEPARTMENTS d WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID) 부서명
FROM EMPLOYEES e

-- 2) from 절에서의 서브쿼리
-- 부서별 평균 급여를 계산한 결과를 조회(부서번호, 부서별 평균급여)

SELECT DEPARTMENT_ID , avg(SALARY)
FROM EMPLOYEES e 
GROUP BY DEPARTMENT_ID ;


SELECT d.DEPARTMENT_NAME 
	, e.avg_salary
FROM DEPARTMENTS d 
	, (SELECT DEPARTMENT_ID , avg(SALARY) AS avg_salary
		FROM EMPLOYEES  
		GROUP BY DEPARTMENT_ID) e
WHERE d.DEPARTMENT_ID = e.department_id;

-- 3) where절에서의 서브쿼리
-- 전체 평균 급여 이상을 받는 직원들 조회

--전체평균급여 조회
SELECT avg(salary)
FROM EMPLOYEES e ;

SELECT FIRST_NAME , LAST_NAME , SALARY 
FROM EMPLOYEES e 

-- 집계함수를 이용한 조건 where절 서브쿼리 생각!
SELECT FIRST_NAME , LAST_NAME , SALARY
FROM EMPLOYEES e 
WHERE SALARY >= (SELECT avg(salary) avg_salary FROM EMPLOYEES)
ORDER BY salary;


--[실습]
--1. 최고 급여를 받는 직원들의 이름, 성, 급여 조회하기
SELECT FIRST_NAME , LAST_NAME , SALARY 
FROM EMPLOYEES e 
WHERE SALARY = (SELECT max(salary) FROM EMPLOYEES);

--2. 부서별 직원의 최고 급여와 최저급여를 조회하기

SELECT DEPARTMENT_ID, max(salary), min(salary)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;


SELECT d.DEPARTMENT_NAME, e.max_salary, e.min_salary
FROM DEPARTMENTS d 
	, (SELECT DEPARTMENT_ID , max(SALARY) max_salary, min(salary) min_salary
		FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID) e
WHERE d.DEPARTMENT_ID = e.department_id;

-- 2. 조인
-- 1) 내부조인
--DROP TABLE WEB_BOOK ;
CREATE TABLE web_books(
	books_id NUMBER PRIMARY KEY,
	books_title varchar2(255),
	books_author varchar2(255)
);


--DROP TABLE WEB_BOOKSPRICE;
CREATE TABLE web_booksprice(
   bp_id NUMBER PRIMARY KEY,
   bp_price number
);
SELECT * FROM WEB_BOOKS ;
SELECT * FROM web_booksprice;

-- 도서테이블 값 추가

--INSERT INTO WEB_BOOKS
--values(1, '위대한 개츠비','f.스콧피츠제럴드');
--INSERT INTO WEB_BOOKS 
--values(2, '해리포터와마법사의돌','j.k.롤링');
--INSERT INTO WEB_BOOKS 
--values(3, '오만과편견','제인오스틴');
--INSERT INTO WEB_BOOKS 
--values(4, '1984','조지오웰');
--INSERT INTO WEB_BOOKS 
--values(5, '데미안','헤르만헤세');

-- 도서 가격 테이블 값추가
--INSERT INTO WEB_BOOKSPRICE 
--values(1, 15000);
--INSERT INTO WEB_BOOKSPRICE 
--values(2, 20000);
--INSERT INTO WEB_BOOKSPRICE 
--values(3, 18000);
--INSERT INTO WEB_BOOKSPRICE 
--values(4, 20000);
--INSERT INTO WEB_BOOKSPRICE 
--values(5, 13000);
--INSERT INTO WEB_BOOKSPRICE 
--values(6, 23000);

SELECT * FROM WEB_BOOKS ;
SELECT * FROM WEB_BOOKSPRICE ;

--선행테이블 정하기 : web_books 행이 적은것

-- 도서테이블과 도서 가격 테이블의 내부 조인
SELECT BOOKS_ID, BOOKS_TITLE, BOOKS_AUTHOR, BP_ID, BP_PRICE
FROM WEB_BOOKS b INNER JOIN WEB_BOOKSPRICE p
ON b.BOOKS_ID = p.BP_ID;

-- 회원테이블 추가
CREATE TABLE web_members(
   mem_id NUMBER PRIMARY KEY,
   mem_name varchar2(255),
   mem_phone varchar2(255),
   mem_email varchar2(255)
);

SELECT * FROM WEB_MEMBERs;

-- 대여테이블
CREATE TABLE web_rentals(
   ren_id NUMBER PRIMARY KEY,
   mem_id NUMBER,
   books_id NUMBER,
   ren_rentalsdate DATE,
   ren_returndate DATE,
   CONSTRAINT fk_member FOREIGN key(mem_id) REFERENCES web_members(mem_id),
   CONSTRAINT fk_books FOREIGN key(books_id) REFERENCES web_books(books_id)
);

SELECT * FROM WEB_RENTALS;

-- 회원테이블 값 추가
--INSERT INTO web_members
--VALUES (1, '짱구', '010-1111-1111', 'aaa@koreait.com');
--INSERT INTO web_members
--VALUES (2, '철수', '010-2222-2222', 'bbb@koreait.com');
--INSERT INTO web_members
--VALUES (3, '유리', '010-3333-3333', 'ccc@koreait.com');
--INSERT INTO web_members
--VALUES (4, '맹구', '010-4444-4444', 'ddd@koreait.com');
--INSERT INTO web_members
--VALUES (5, '훈이', '010-5555-5555', 'eee@koreait.com');

SELECT * FROM WEB_MEMBERs;

-- 대여 테이블 값 추가
--INSERT INTO WEB_RENTALS
--values(1, 1, 3, to_date('2024-07-01', 'yyyy-mm-dd'), to_date('2024-07-08', 'yyyy-mm-dd'));
--INSERT INTO WEB_RENTALS
--values(2, 1, 2, to_date('2024-07-02', 'yyyy-mm-dd'), to_date('2024-07-09', 'yyyy-mm-dd'));
--INSERT INTO WEB_RENTALS
--values(3, 2, 4, to_date('2024-07-01', 'yyyy-mm-dd'), to_date('2024-07-08', 'yyyy-mm-dd'));
--INSERT INTO WEB_RENTALS
--values(4, 4, 1, to_date('2024-07-04', 'yyyy-mm-dd'), to_date('2024-07-11', 'yyyy-mm-dd'));

SELECT * FROM web_rentals;

--대여 테이블, 도서 테이블 회원 테이블 조회
SELECT * FROM WEB_RENTALS;
SELECT * FROM WEB_BOOKS;
SELECT * FROM WEB_MEMBERS;

/*
 * 등가조인 : 두 개 이 상의 테이블을 조인할 때 특정 컬럼들의 값이 서로 같은 행만 결과로 반환
 * ON절에 등호(=)가 있을 때
 * 두 테이블간에 고나계가 있다면(FK가 존재한다면) 부모테이블의 PK와 자식테이블의 FK를 등호로 비교가능하기 때문에 등가조인사용이 가능하다.
 */

-- 대여 정보와 책의 저자를 조회


SELECT WR.REN_RENTALSDATE, WB.BOOKS_TITLE
FROM WEB_RENTALS WR JOIN WEB_BOOKS WB
ON WR.BOOKS_ID = WB.BOOKS_ID;


--대여한 책과 반납 날짜를 가져오는 등가조인
SELECT WR.REN_RETURNDATE, WB.BOOKS_TITLE
FROM WEB_RENTALS WR JOIN WEB_BOOKS WB
ON WR.BOOKS_ID = WB.BOOKS_ID;

--회원이름과 대여한 책의 제목을 가져오는 등가조인
SELECT WM.MEM_NAME, WB.BOOKS_TITLE, WR.MEM_ID
FROM WEB_RENTALS WR JOIN WEB_BOOKS WB ON WR.BOOKS_ID = WB.BOOKS_ID
					JOIN WEB_MEMBERS WM ON WR.MEM_ID = WM.MEM_ID
