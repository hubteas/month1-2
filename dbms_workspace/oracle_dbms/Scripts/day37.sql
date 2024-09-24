--서브쿼리

-- 1) select 절의 서브쿼리

SELECT * FROM employees;
SELECT * FROM DEPARTMENTS;
-- 부서명과 해당 부서에서 일하는 직원수 조회하기
SELECT department_name AS 부서명
FROM DEPARTMENTS;
-- 27행

-- 전체 직원수 조회하기
SELECT count(*)
FROM EMPLOYEES;

-- group by 이용해서 부서명과 직원수 조회
SELECT department_id, count(department_id)
FROM EMPLOYEES e 
GROUP BY DEPARTMENT_ID;

SELECT department_name AS 부서명,
	(SELECT count(*) FROM EMPLOYEES e WHERE e.department_id = d.department_id) AS 직원수
FROM DEPARTMENTS d;

-- 2) from 절의 서브쿼리

SELECT * FROM EMPLOYEES;

--각 부서의 평균 급여와 각 직원의 급여를 함께 조회하기

-- 직원 번호, 이름, 급여 조회하기(employees테이블)

SELECT employee_id, first_name, salary
FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 오류발생
SELECT EMPLOYEE_ID , FIRST_NAME , SALARY , DEPARTMENT_ID , AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

SELECT
   EMPLOYEE_ID,
   FIRST_NAME,
   SALARY,
   dept_avg.DEPARTMENT_ID,
   dept_avg.avg_sal
FROM
   EMPLOYEES e, 
   (
   SELECT
      DEPARTMENT_ID,
      AVG(SALARY) AS avg_sal
   FROM
      EMPLOYEES
   GROUP BY
      DEPARTMENT_ID) dept_avg
WHERE
   e.department_id = dept_avg.department_id;
   

-- 전체 평균급여보다 높은 급여를 받는 직원의 번호, 이름 , 급여 조회하기
SELECT avg(salary)
FROM EMPLOYEES e;

--직원의 번호, 이름, 급여조회(employees테이블)
SELECT EMPLOYEE_ID , FIRST_NAME , SALARY 
FROM EMPLOYEES e;

SELECT e.EMPLOYEE_ID , e.FIRST_NAME , e.SALARY 
FROM EMPLOYEES e,(SELECT avg(salary) AS avg_sal
FROM EMPLOYEES) emp_avg
WHERE e.SALARY > emp_avg.avg_sal;

--3) where 절의 서브쿼리
-- 특정 부서80번에서 평균 급여보다 높은 급여를 받는 직원 번호, 이름, 급여조회하기
SELECT avg(SALARY)
FROM EMPLOYEES e ;

SELECT EMPLOYEE_ID , FIRST_NAME , SALARY , DEPARTMENT_ID 
FROM EMPLOYEES e 
WHERE DEPARTMENT_ID =80 AND (SELECT avg(SALARY) avg_sal FROM EMPLOYEES)<salary
ORDER BY SALARY DESC;

--employ 테이블에서 각 부서별 사원수를 세고 가장 높은 사원수를 가진 부서번호와 사원수 조회하기

SELECT * FROM EMPLOYEES e ;

SELECT * FROM DEPARTMENTS d;

--전체사원수조회
SELECT count(*)
FROM EMPLOYEES e ;

-- 각 부서별 사원수조회
SELECT department_id, count(department_id)
FROM EMPLOYEES e 
GROUP BY DEPARTMENT_ID;
--가장높은 사원수를 가진 부서번호와 사원수 조회
SELECT DEPARTMENT_ID , emp_count
FROM (SELECT department_id, count(*) AS emp_count
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID) dept_emp
WHERE emp_count = (SELECT max(count(*)) FROM EMPLOYEES  GROUP BY DEPARTMENT_ID);


-- 2. ROWNUM
SELECT ROWNUM, e.*
FROM EMPLOYEES e
ORDER BY SALARY DESC;

-- 원하는 결과가 나오지 않았다. select 절에 rownum을 사용했고 order by 절이 먼저 실행됐기때문이다.

-- 즉 rownum 은 order by로 정렬되기 이전에 붙었다.

SELECT rownum, E.*
FROM (SELECT * FROM EMPLOYEES e ORDER BY salary desc) E;


-- employees 테이블에서 연봉 1위부터 5위까지 조회
SELECT rownum, E.*
FROM (SELECT * FROM EMPLOYEES e ORDER BY salary desc) e
WHERE rownum BETWEEN 1 AND 5;
--상위 n개 행을 필터링할 수 있는 이유는 rownum 은 순차적으로 부여되기 때문이다.
-- 행이 선택될 때마다 rownum이 증가하고 rownum 은 1부터 5까지 순차적으로 부여된다.
SELECT rownum, e2.*
FROM (SELECT rownum AS r, e1.* FROM (SELECT salary FROM employees ORDER BY salary desc) e1) e2
WHERE r BETWEEN 6 AND 10;

-- 6~10사이의 값을 가지는 행을 직접 선택하는 것은 불가능하다. rownum이 증가하는 방식과 관련이 있기 때문이다.

--상위 7개 행 조회
SELECT rownum, e.*
FROM EMPLOYEES e 
WHERE rownum <=7;

--정렬된 결과에서 상위 7개 행을 조회(급여기준 내림차순)
SELECT rownum, e.*
FROM (SELECT * FROM EMPLOYEES ORDER BY salary desc) e
WHERE rownum <=7;

SELECT rownum, e.* FROM (SELECT * FROM EMPLOYEES ORDER BY salary desc) e
WHERE rownum <=15

SELECT e2.*
FROM (SELECT rownum AS r, e.* FROM (SELECT * FROM EMPLOYEES ORDER BY salary desc) e
WHERE rownum <=15) e2
WHERE r BETWEEN 8 AND 15;