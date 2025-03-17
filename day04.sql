-- 자동으로 만들어진 INDEX던, 우리가 수동으로 만든 INDEX건 조회할 때 
-- 사용이 되는거라면 잘 사용이 되고 있는지 확인을 해야할 필요가 있다.
-- EXPLAIN PLAN FOR
-- ORACLE 데이터베이스에서 SQL 쿼리가 실행될 때
-- 어떤 경로로 수행되는지를 미리 확인할 수 있는 명령어
-- 주요 개념
-- 실행 계획(explain plan)
-- SQL 쿼리를 처리하기 위한 단계별 작업 순서를 나타낸다.
-- 테이블 스캔, 인덱스 스캔, 조인 방식이 포함된다.
-- 실제로 쿼리를 실행하지는 않고, 쿼리의 실행 결로를 분석
-- 실행 계획을 통해 쿼리 성능 개선, 인덱스 활용 여부 병목 현상 등을 진달할 수 있다.
-- PLAN_TABLE
-- 실행 계획 정보는 기본적으로 PLAN_TABLE이라는 테이블에 저장된다.
-- 이후 DBMS_XPLAN.DISPLAY 함수를 이용하여 보기 쉽게 출력할 수 있다.

EXPLAIN PLAN FOR
SELECT * FROM EMPLOYEES WHERE LAST_NAME='smith';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- 사번이 150번인 사원의 급여와 같은 급여를 받는 사원들의 정보를 사번, 이름, 급여 순으로 출력

SELECT e.EMPLOYEE_ID
	 , e.FIRST_NAME
	 , e.SALARY
  FROM EMPLOYEES e 
 WHERE (SELECT SALARY 
          FROM EMPLOYEES 
         WHERE EMPLOYEE_ID = '150') = E.SALARY;

-- 급여가 회사의 평균급여 이상인 사람들의 이름과 급여를 조회
SELECT e.FIRST_NAME
     , e.SALARY
FROM EMPLOYEES e 
WHERE e.SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES);

-- 사번이 111번인 사원과 직종이 같고,
-- 사번이 159번인 사원의 급여보다 많이 받는 사원의 사번, 이름, 직종, 급여를 조회하세요

SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME 
     , e.JOB_ID
     , e.SALARY
  FROM EMPLOYEES e
 WHERE e.JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = '111')
   AND e.SALARY > (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = '159');

-- 직종별 평균급여가 Burce의 급여보다 큰 직종만 직종, 평균급여를 조회하세요.

SELECT e.JOB_ID
     , avg(e.SALARY)
  FROM EMPLOYEES e
 GROUP BY e.JOB_ID
 HAVING avg(e.SALARY) > (SELECT salary 
                           FROM EMPLOYEES 
                          WHERE FIRST_NAME = 'Bruce');


-- PLAYER 테이블에서 TEAM_ID 가 'K01' 인 선수중 POSITION 이 'GK' 인 선수 찾기
SELECT * FROM (SELECT * FROM PLAYER WHERE TEAM_ID = 'K01') p 
WHERE p."POSITION" = 'GK';

-- FROM(IN LINE VIEW) : 쿼리문으로 출력되는 결과를 테이블처럼 사용하겠다.
-- SELECT(SCALAR) : 하나의 쿼리처럼 사용되는 서브쿼리
-- WHERE(SUB QUERY) : 하나의 변수처럼 사용한다.
   -- 단일행 서브쿼리 : 쿼리 결과가 단일행만 반환하는 서브쿼리
   -- 다중행 서브쿼리 : 쿼리 결과가 다중행을 리턴하는 서브쿼리
   -- 다중 컬럼 서브쿼리 : 컬럼 결과가 다중컬럼을 반환하는 서브쿼리

-- PLAYER 테이블에서 전체 평균키와, 포지션별 평균키 구하기

SELECT e."POSITION"
     , round(avg(e.HEIGHT),1) AS "포지션별 평균 키"
     , round((SELECT avg(e.HEIGHT)
                FROM PLAYER e),1) AS "전체 평균 키"
                ,e. 
  FROM PLAYER e 
 GROUP BY e."POSITION";

SELECT * FROM PLAYER p ;

-- PLAYER 테이블에서 NICEKNAME이 NULL 인 선수들은 정대민선수의 닉네임으로 바꾸기
UPDATE PLAYER
   SET NICKNAME = '정대민'
 WHERE NICKNAME IS NULL;

-- EMPLOYEES 테이블에서 평균 급여보다 급여가 낮은 사원들의 급여를 10% 인상하기
UPDATE EMPLOYEES
   SET salary = salary + (salary * (1/10))
 WHERE salary < (SELECT avg(salary) FROM EMPLOYEES);

SELECT * FROM EMPLOYEES;

SELECT * FROM PLAYER;
-- PLAYER 테이블에서 평균키보다 큰 선수들을 삭제
DELETE 
  FROM PLAYER
 WHERE HEIGHT > (SELECT AVG(HEIGHT) 
                   FROM PLAYER);

-- CONCATENATION (연결) : ||

SELECT e.FIRST_NAME || ' ' || e.LAST_NAME  AS "이름"
  FROM EMPLOYEES e;

SELECT e.FIRST_NAME || '의 급여는 ' || e.SALARY || '이다.'  AS "이름"
  FROM EMPLOYEES e;

-- 별칭 (alias)
-- select절 
   -- 컬럼명 as 별칭
   -- 컬럼명  별칭
-- from절
   -- 테이블명 뒤에 한칸 띄우고 작성
-- 별칭의 특징
-- 테이블에 별칭을 줘서 컬럼을 단순, 명확히 할 수 있다.
-- 현재의 select 문장에서만 유효하다.
-- 테이블 별칭은 길이가 30자까지 가능하나 짧을수록 좋다
-- from절에 테이블 별칭 설정 시 해당 테이블 별칭은
-- select문장에서 테이블 이름 대신 사용할 수 있다.

SELECT count(SALARY) AS 개수
     , MAX(SALARY) AS 최대값 
     , MIN(SALARY) AS 최소값
     , SUM(SALARY) AS 합계
     , AVG(SALARY) AS 평균
 FROM EMPLOYEES;

SELECT e.DEPARTMENT_ID
     , d.DEPARTMENT_ID
  FROM EMPLOYEES e
     , DEPARTMENTS d;

-- 사원테이블에 부서명이 없음
-- 부서테이블과 DEPARTMENT_ID로 연결되어 있음
SELECT e.FIRST_NAME
     , e.DEPARTMENT_ID
     , d.DEPARTMENT_NAME
  FROM EMPLOYEES e JOIN DEPARTMENTS d
    ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- 부서테이블과 지역(locations) 로부터 부서명과 city 조회하기
SELECT department_name
     , city
  FROM DEPARTMENTS d JOIN LOCATIONS l
    ON d.LOCATION_ID = l.LOCATION_ID;

-- 지역 LOCATIONS, 나라 COUNTRIES 를 조회하여
-- 도시명과 국가명을 조회하시오.
SELECT * FROM LOCATIONS;
SELECT * FROM COUNTRIES;

SELECT CITY
     , COUNTRY_NAME
 FROM LOCATIONS l JOIN COUNTRIES c
   ON l.COUNTRY_ID = c.COUNTRY_ID;

-- 사원테이블과 jobs 테이블을 이용하여
-- 이름, 성, 직종번호, 직종 이름을 조회하세요.

SELECT e.FIRST_NAME
     , e.LAST_NAME
     , e.JOB_ID
     , j.JOB_TITLE
  FROM EMPLOYEES e JOIN JOBS j
    ON e.JOB_ID = j.JOB_ID;

-- 사원, 부서, 지역 테이블 로부터 e.이름, e.이메일, d.부서번호, d.부서명, l.지역번호, l.도시명
-- 을 조회하되 도시가 'Seattle' 인 경우만 조회하기

SELECT e.FIRST_NAME 
     , e.EMAIL 
     , e.DEPARTMENT_ID
     , d.DEPARTMENT_NAME
     , l.LOCATION_ID
     , l.CITY
  FROM EMPLOYEES e JOIN DEPARTMENTS d
    ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
  JOIN LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID
   AND l.CITY = 'Seattle';

SELECT e.FIRST_NAME 
     , e.EMAIL 
     , e.DEPARTMENT_ID
     , d.DEPARTMENT_NAME
     , l.LOCATION_ID
     , l.CITY
  FROM EMPLOYEES e, DEPARTMENTS d, LOCATIONS l
 WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
   AND d.LOCATION_ID = l.LOCATION_ID
   AND l.CITY = 'Seattle';

-- 1-1 sel inner join
-- 하나의 테이블 내에서 다른 컬럼을 참조하기 위해 사용하는
-- '자기 자신과의 조인' 방법이다.
-- 데이터를 통해 데이터베이스에서 한 테이블 내의 값을 다른 값과 연결할 수 있다.

/*
 * select a.컬럼1, b.컬럼1
 * from 테이블A a
 * join 테이블A b
 *  on A.열 = b.열;
 * */
SELECT e2.FIRST_NAME 
     , e2.EMPLOYEE_ID
  FROM EMPLOYEES e1 JOIN EMPLOYEES e2
    ON e1.EMPLOYEE_ID = e2.MANAGER_ID;
            