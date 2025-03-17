UPDATE TBL_STUDENT
   SET PRICE = 1020
 WHERE "NO" = 1000;
 
DELETE FROM 테이블
 WHERE 1=1 
  AND NAME = "세탁기";

-- PRODUCT 테이블에서 다음과 같이 데이터를 조회하세요.

SELECT NAME
     , PRICE	
  FROM PRODUCT;

-- 사원테이블에서 급여를 많이 받는 순으로 사번, 이름, 급여, 입사일을 조회하세요.
SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME
     , e.SALARY
     , e.HIRE_DATE 
  FROM EMPLOYEES e 
 ORDER BY e.SALARY DESC
        , e.HIRE_DATE ASC;

-- 사원테이블에서 부서번호가 빠른 순, 부서번호가 같다면 직종이 빠른순
-- 직종까지 같다면 급여를 많이 받는 순으로 사원의 사번, 이름, 부서번호, 직종, 급여순으로 출력
	SELECT e.EMPLOYEE_ID
	     , e.FIRST_NAME
	     , e.DEPARTMENT_ID 
	     , e.JOB_ID
	     , e.SALARY
	  FROM EMPLOYEES e 
  ORDER BY DEPARTMENT_ID, DEPARTMENT_ID, e.SALARY DESC;

-- 급여가 15000이상인 사원들의 사번, 이름, 급여, 입사일을 입사일이 빠른 순으로 조회
	SELECT e.EMPLOYEE_ID
	     , e.FIRST_NAME
	     , e.SALARY
	     , E.HIRE_DATE
	  FROM EMPLOYEES e 
   	 WHERE e.SALARY >= 15000
  ORDER BY HIRE_DATE;

-- ASCII : 지정된 문자의 ASCII값을 반환한다.
SELECT ASCII('A') FROM DUAL;

-- CHR : 지정된 수치와 일치하는 ASCII코드를 반환한다.
SELECT CHR(65) FROM DUAL;

-- RPAD (데이터, 고정길이, 문자) : 왼쪽 정렬 후 오른쪽에 생긴 빈공백에 특정 문자를 채워 반환한다.
SELECT RPAD(d.DEPARTMENT_NAME, 10, '*') FROM DEPARTMENTS d;

-- LPAD (데이터, 고정길이, 문자) : 오른쪽 정렬 후 오른쪽에 생긴 빈공백에 특정 문자를 채워 반환한다.
SELECT LPAD(d.DEPARTMENT_NAME, 10, '*') FROM DEPARTMENTS d;

-- TRIM() : 앞 뒤 문자열 공백을 제거
SELECT TRIM('     HELLO     ') FROM DUAL;

SELECT TRIM('z' FROM 'zzzHELLOWzzz') FROM dual; -- HELLOW

-- RTRIM : 문자열 오른쪽(뒤)의 공백 문자들을 삭제한다.
SELECT RTRIM('HELLO    ') FROM dual;

-- LTRIM : 문자열 왼쪽(뒤)의 공백 문자들을 삭제한다.
SELECT LTRIM('    hello') FROM dual;

-- INSTR : 특정 문자의 위치를 반환한다.
SELECT INSTR ('HELLO', 'L') FROM DUAL;

SELECT INSTR ('HELLOW', 'L', 1, 2) FROM DUAL; -- 4
SELECT INSTR ('HELLOW', 'L', -1, 2) FROM DUAL; -- 3 / -1 일때는 오른쪽에서 왼쪽

SELECT INSTR ('HELLOW', 'Z') FROM DUAL; -- 없으면 0 반환

-- INITCAP(데이터)
-- 첫 문자를 대문자로 변환하는 함수
-- 공백, /를 구분자로 인식
SELECT INITCAP('good morning') FROM dual;
SELECT initcap('good morning') FROM dual;

-- length() - 문자열의 길이를 반환
SELECT LENGTH('john') FROM dual;

-- concat() - 문자열을 연결
SELECT CONCAT('Republic of', ' korea') FROM dual;

-- SUBSTR(데이터, 길이) - 문자열의 시작 위치부터 길이만큼 자른 후 반환
SELECT substr('hello Oracle', 2) case1,
       substr('hello Oracle', 7, 5) case2
       FROM dual;

-- LOWER : 지정된 문자를 소문자로 반환한다.
-- UPPER : 지정된 문자를 대문자로 반환한다.

SELECT lower('HELLO ORACLE') FROM dual;
SELECT upper('hello oracle') FROM dual;

-- REPLACE : 첫 번째 파라미터로 지정한 문자를 두번째 파라미터로 지정한 문자로 바꿔준다.
SELECT replace('Hellow World', 'World' , 'SQL') FROM dual;

-- 부서번호가 50번인 사원들의 이름을 출력하되 이름 중 'el' 을 모두 '**'로 대체하여 조회하세요.
SELECT REPLACE(e.FIRST_NAME, 'el', '**')
     , e.*
  FROM EMPLOYEES e
 WHERE e.DEPARTMENT_ID = '50';

-- 문자열 '     oracle SQL Programming     ' 에서
-- 양쪽 공백을 제거한 후, 모든 문자를 대문자로 변환하고 최종 문자열의 길이를 반환하시오

SELECT LENGTH(UPPER(TRIM('     oracle SQL Programming     '))) FROM DUAL;

-- '  Hello, Oracle SQL!  ' 문자열에서 양쪽 공백 제거 후
-- 앞의 5글자와 마지막 5글자를 추출하여, 각각 대문자로 변환하고
-- 두 결과를 콜론(:) 으로 연결하여 반환하는 SQL문 작성하기

--WITH V_TRIM AS (
--	SELECT TRIM('  Hello, Oracle SQL!  ') AS TEST1 
--		 , INSTR((SELECT TRIM('  Hello, Oracle SQL!  ') AS TEST1 FROM DUAL), ' ', -1) AS TEST2 
--	     , INSTR((SELECT TRIM('  Hello, Oracle SQL!  ') AS TEST1 FROM DUAL), '!', 1) AS TEST3
--	     , INSTR((SELECT TRIM('  Hello, Oracle SQL!  ') AS TEST1 FROM DUAL), 'H', 1) AS TEST4
--	     , INSTR((SELECT TRIM('  Hello, Oracle SQL!  ') AS TEST1 FROM DUAL), 'o', 1) AS TEST5
--	FROM DUAL
--), V_SE_INSTR AS (
--	SELECT SUBSTR((SELECT TEST1 FROM V_TRIM)
--	            , (SELECT TEST4 FROM V_TRIM) 
--	            , (SELECT TEST5 FROM V_TRIM) 
--	             ) AS RE1
--	     , SUBSTR((SELECT TEST1 FROM V_TRIM)
--	            , (SELECT TEST2 FROM V_TRIM) 
--	            , (SELECT TEST3 FROM V_TRIM) 
--	             ) AS RE2
--	  FROM DUAL
--), V_RE_CONCAT AS (
--	SELECT CONCAT((SELECT RE1 FROM V_SE_INSTR), ':') AS RE3
--	  FROM DUAL
--), V_RESULT AS (
--    SELECT CONCAT( (SELECT RE3 FROM V_RE_CONCAT), (SELECT RE2 FROM V_SE_INSTR)) AS RES 
--      FROM DUAL
--) SELECT TEST1, TEST2, TEST3, TEST4, TEST5
--       , RE1, RE2, RE3, RES
--       , SUBSTR(TEST1, TEST4, TEST5) || ':' || SUBSTR(TEST1, TEST2, TEST3) AS RES2
--    FROM V_TRIM, V_SE_INSTR, V_RE_CONCAT, V_RESULT;


WITH V_TRIM AS (
	SELECT TRIM('  Hello, Oracle SQL!  ') AS TEST1 
		 , INSTR((SELECT TRIM('  Hello, Oracle SQL!  ') AS TEST1 FROM DUAL), ' ', -1) AS TEST2 
	     , INSTR((SELECT TRIM('  Hello, Oracle SQL!  ') AS TEST1 FROM DUAL), '!', 1) AS TEST3
	     , INSTR((SELECT TRIM('  Hello, Oracle SQL!  ') AS TEST1 FROM DUAL), 'H', 1) AS TEST4
	     , INSTR((SELECT TRIM('  Hello, Oracle SQL!  ') AS TEST1 FROM DUAL), 'o', 1) AS TEST5
	FROM DUAL
) SELECT TEST1, TEST2, TEST3, TEST4, TEST5
       , SUBSTR(TEST1, TEST4, TEST5) || ':' || SUBSTR(TEST1, TEST2, TEST3) AS RES2
    FROM V_TRIM;


SELECT ( SELECT INSTRTRIM('  Hello, Oracle SQL!  ')  )
       INSTR(
        TRIM('  Hello, Oracle SQL!  '), ' ', -1)
  FROM DUAL

  (SELECT INSTR(TRIM('  Hello, Oracle SQL!  '), '!',1) FROM DUAL

SELECT 
SELECT INSTR(TRIM('  Hello, Oracle SQL!  '), ' ', -1) FROM dual;

-- 'Data' 왼쪽에 '-' 문자를 채워 총 10자리 문자열로 만들고
-- 'Base' 를 오른쪽에 '*' 문자를 채워 총 10자리의 문자열로 만든 후
-- 이 두 결과를 연결하여 반환하는 sql문 작성하기 
-- 결과 '------DataBase******';
SELECT concat(LPAD('Data', 10, '-'), RPAD('Base', 10, '*')) FROM dual;

-- abs()
-- 절대값을 반환
SELECT -10, abs(-10) FROM dual;

-- ROUND()
-- 특정 자리수에서 반올림하여 반환
SELECT ROUND(2.55, 1)FROM DUAL;

-- FLOOR()
-- 주어진 숫자보다 작거나 같은 수 중 최대값을 반환
SELECT FLOOR(2), FLOOR(2.1) FROM DUAL;

-- TRUNC()
-- 특정 자리수를 버리고 반환
SELECT TRUNC(1234.567,1)
     , TRUNC(1234.567,-1)
     , TRUNC(1234.567)
  FROM DUAL;

-- SIGN()
-- 주어진 값의 양수, 음수, 0인지 여부를 판단
-- 음수는 -1, 양수는 1, 0은 0을 반환
-- NULL은 NULL을 반환한다.
SELECT SIGN(-10)
     , SIGN(0)
     , SIGN(10)
     , SIGN(NULL)
  FROM DUAL;

-- CEIL()
-- 주어진 숫자보다 크거나 같은 정수 중 최소값을 반환
SELECT CEIL(2)
     , CEIL(2.1)
  FROM DUAL;

-- MOD 나누기 후 나머지를 반환
SELECT MOD(1,3)
     , MOD(2,3)
     , MOD(3,3)
     , MOD(4,3)
     , MOD(0,3)
 FROM DUAL;

-- POWER 제곱
SELECT POWER(2,1)
     , POWER(2,2)
     , POWER(2,3)
     , POWER(2,0)
 FROM DUAL;

-- 이름이 6글자 이상인 사원의 사번과 이름 , 급여 조회하기
SELECT e.EMPLOYEE_ID 
     , e.FIRST_NAME 
     , e.SALARY
FROM EMPLOYEES e
WHERE LENGTH(e.FIRST_NAME) >= 6;

-- 사원테이블에서 사원번호가 홀수이면 1, 짝수이면 0을 출력하세요.
SELECT MOD(e.EMPLOYEE_ID, 2)
     , e.EMPLOYEE_ID
  FROM EMPLOYEES e

-- 사원번호가 짝수인 사람들의 사원 번호와 이름을 출력하시오.
SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME
     , MOD(e.EMPLOYEE_ID, 2)
  FROM EMPLOYEES e
 WHERE MOD(e.EMPLOYEE_ID, 2) = '0';


-- 사원테이블에서 이름, 급여, 급여의 1000당 ■개수로
-- 채워서 조회하기
SELECT FIRST_NAME, SALARY,RPAD('■',ROUND(SALARY/1000),'■')
FROM EMPLOYEES;

-- 날짜함수

-- ADD_MONTHS()
-- 특정 날짜에 개월수를 더해준다.

SELECT SYSDATE, ADD_MONTHS(SYSDATE,2) FROM DUAL;

-- MONTHS_BETWEEN()
-- 두 날짜 사이의 개월수

-- 모든 사원들이 입사일로부터 몇개월이 경과했는지
-- SYSDATE, HIRE_DATE, 개월수로 조회
SELECT sysdate, HIRE_DATE, MONTHS_BETWEEN(sysdate, HIRE_DATE)
FROM EMPLOYEES;

-- NEXT_DAY()
-- 주어진 일자가 다음에 나타나는 지정요일의 날짜를 반환
-- (1: 일요일 ~ 7:토요일)
SELECT
   sysdate "오늘",
   next_day(sysdate-7,'일요일') "저번주 일요일",
   next_day(sysdate,'일요일') "이번주 일요일"
FROM dual;

-- 형변환 함수

-- TO_CHAR(날짜, 포맷)
SELECT 
   TO_CHAR(sysdate,'yyyy-mm-dd'),
   TO_CHAR(sysdate,'yyyy-mm-dd day'),
   TO_CHAR(sysdate,'yyyy-mm-dd HH:MI:SS')
FROM dual;
   
-- 날짜 formatting 형식
-- SCC, CC : 세기
-- YYYY, YY : 연도
-- MM : 월
-- DD : 일
-- DAY : 요일
-- MON : 월명(JAN,FEB,MAR)
-- MONTH : 월명(JANUARY)
-- HH, HH24: 시간
-- MI : 분
-- SS : 초

-- TO_NUMBER는 잘 안씀
-- 숫자모양으로 되어있는 문자열은 오라클이 묵시적으로
-- 숫자 취급을 해버린다.

/*
 * 0: 숫자, 공백시 0으로 채움
 * 9: 숫자
 * ,: 쉼표 표시
 * L: 지역 화폐 단위 표시
 * */
SELECT 
   TO_CHAR(1234567, '9,999,999'),
   TO_CHAR(1234567, 'L9,999,999')
FROM DUAL;

-- TO_DATE
-- 문자열을 날짜 형식으로 표현

SELECT 
   TO_DATE('2025.03.14'),
   TO_DATE('03.14.2025','MM,DD,YYYY'),
   TO_DATE('2025.03','YYYY.MM'),--일을 입력하지 않으면 1일로 나온다.
   TO_DATE('11','DD') --년,월 입력 안하면 해당 년도, 해당월로 변환
FROM DUAL;

-- NVL : NULL이 아닐때 치환할 값, NULL 일때 치환할 값
SELECT e.FIRST_NAME 
     , nvl(e.COMMISSION_PCT, 0) 
  FROM EMPLOYEES e;

SELECT e.FIRST_NAME 
     , nvl2(e.COMMISSION_PCT, 1, 0) 
  FROM EMPLOYEES e;

-- 순위 함수
-- RANK() OVER(ORDER BY 컬럼)
-- 그룹 내 순위를 계산하여 NUMBER 타입으로 순위를 반환
-- 공동 순위
SELECT RANK() OVER(ORDER BY e.SALARY desc) "RANK"
     , e.FIRST_NAME
     , e.SALARY
  FROM EMPLOYEES e;

-- 집계함수
-- 여러 행들에 대한 연산의 결과를 하나의 행으로 반환
-- CONUT() : 행의 개수를 센다.
SELECT COUNT(*) FROM EMPLOYEES e;

SELECT (SELECT COUNT(*) FROM EMPLOYEES)
     , e.*
  FROM EMPLOYEES e;

SELECT (SELECT COUNT(*) FROM EMPLOYEES)
     , (SELECT COUNT(*) FROM DEPARTMENTS)
  FROM dual;

-- DISTINCT
-- 중복제거
SELECT COUNT(DISTINCT e.DEPARTMENT_ID) FROM EMPLOYEES e; 

-- MIN : 최소값 / MAX : 최대값
SELECT MIN(e.SALARY) FROM EMPLOYEES e;
SELECT MAX(e.SALARY) FROM EMPLOYEES e;

-- SUM() : 총합
SELECT SUM(e.SALARY) FROM EMPLOYEES e;

-- AVG() : 평균
SELECT AVG(e.SALARY) FROM EMPLOYEES e;

-- 집계함수는 일반 컬럼과 같이 사용하는것은 일반적인 방법으로는 불가능하다.
SELECT e.FIRST_NAME, max(e.SALARY) FROM EMPLOYEES e;

-- 그룹화 (GROUP BY)
-- 특정테이블에서 소그룹을 만들어 결과를 분산시켜 얻고자 할때
-- 각 부서별 급여의 평균과 총합을 출력
SELECT e.DEPARTMENT_ID
     , AVG(e.SALARY)
     , SUM(e.SALARY)
  FROM EMPLOYEES e
 GROUP BY e.DEPARTMENT_ID;

-- 부서별, 직종별로 그룹을 나눠서 인원수를 출력하되
-- 부서번호가 낮은순으로 정렬

SELECT e.DEPARTMENT_ID
     , e.JOB_ID
     , count(*)
  FROM EMPLOYEES e
 GROUP BY e.DEPARTMENT_ID, e.JOB_ID
 ORDER BY e.DEPARTMENT_ID;

-- 사원테이블에서 80번 부서에 속하는 사원들의 급여의 평균을 소수점 두자리까지 반올림하여 출력하세요.
SELECT ROUND(AVG(e.SALARY), 2)
  FROM EMPLOYEES e
 WHERE e.DEPARTMENT_ID = '80';

-- 각 직종별 인원수
SELECT count(e.JOB_ID)
     , e.JOB_ID
  FROM EMPLOYEES e
 WHERE DEPARTMENT_ID IS NOT NULL
 GROUP BY e.JOB_ID ;

-- 각 직종별 급여의 합
SELECT SUM(e.SALARY)
     , e.JOB_ID
  FROM EMPLOYEES e
 WHERE JOB_ID IS NOT NULL
 GROUP BY e.JOB_ID;

-- 부서별로 가장 높은 급여 조회
SELECT MAX(e.SALARY)
     , e.DEPARTMENT_ID
  FROM EMPLOYEES e
 WHERE DEPARTMENT_ID IS NOT NULL
 GROUP BY e.DEPARTMENT_ID;

-- HAVING 절
-- GROUP BY로 집계된 값 중 조건을 추가하는 것

-- WHERE 절과 HAVING 절의 차이
-- HAVING절은 GROUP BY 와 함게 사용해야 하며
-- 집계함수를 사용하여 조건절을 작성하거나
-- GROUP BY 컬럼만 조건절에 사용할 수 있다.

-- 각 부서 급여의 최대값, 최소값, 인원수를 조회하되 급여의 최대값이 8000이상인 결과만 조회할것
SELECT e.DEPARTMENT_ID
     , MAX(e.SALARY)
     , MIN(e.SALARY)
     , count(*)
  from EMPLOYEES e
 GROUP BY e.DEPARTMENT_ID 
 HAVING max(e.SALARY) >= 8000;

-- 각 부서별 인원수가 20명이 이상인 부서의 정보를
-- 부서번호, 급여의 합, 급여의 평균, 인원수 순으로 출력하되
-- 급여의 평균은 소수점 둘째자리까지 반올림으로 조회
SELECT e.DEPARTMENT_ID 
     , sum(e.SALARY)
     , round(avg(e.SALARY), 2)
     , count(*)
FROM EMPLOYEES e
GROUP BY e.DEPARTMENT_ID
HAVING count(e.DEPARTMENT_ID) >= 20;

-- 부서별, 직종별로 그룹화하여 부서번호, 직종, 인원수 순으로 조회하도
-- 직종이 'MAN' 으로 끝나는 경우만 조회
SELECT e.DEPARTMENT_ID
     , e.JOB_ID
     , count(*)
  FROM EMPLOYEES e
 GROUP BY e.DEPARTMENT_ID, e.JOB_ID
 HAVING e.JOB_ID LIKE '%MAN';

SELECT * FROM EMPLOYEES e

-- 각 부서별 평균 급여를 소수점 한자리까지 버리고
-- 평균 급여가 10000미만인 그룹만 조회해야하며
-- 부서번호가 50이하인 부서만 조회해주세요.
SELECT ROUND(AVG(E.SALARY),1)
     , E.DEPARTMENT_ID
  FROM EMPLOYEES e
 GROUP BY e.DEPARTMENT_ID
HAVING AVG(E.SALARY) < 10000 
   AND E.DEPARTMENT_ID <= 50;

CREATE TABLE 월별매출 (
    상품ID VARCHAR2(5),
    월 VARCHAR2(10),
    회사 VARCHAR2(10),
    매출액 INTEGER );
    
INSERT INTO  월별매출 VALUES ('P001', '2019.10', '삼성', 15000);
INSERT INTO  월별매출 VALUES ('P001', '2019.11', '삼성', 25000);
INSERT INTO  월별매출 VALUES ('P002', '2019.10', 'LG', 10000);
INSERT INTO  월별매출 VALUES ('P002', '2019.11', 'LG', 20000);
INSERT INTO  월별매출 VALUES ('P003', '2019.10', '애플', 15000);
INSERT INTO  월별매출 VALUES ('P003', '2019.11', '애플', 10000);

SELECT * FROM 월별매출;

-- ROLLUP
-- 계층적 그룹핑을 통해 점진적으로 소계와 총계를 계산
SELECT 상품ID
     , 월
     , SUM(매출액) AS "매출액"
  FROM 월별매출
 GROUP BY ROLLUP(상품ID, 월);

-- CUBE
-- 모든 조합의 그룹핑 집합을 생성하여 모든 소계와 총계를 포함
SELECT 상품ID
     , 월
     , SUM(매출액) AS "매출액"
  FROM 월별매출
 GROUP BY CUBE(상품ID, 월);

-- GROUPING SETS 
-- 사용자 정의 그룹핑 집합을 통해 원하는 조합만 선택적으로 집계할 수 있다.
SELECT 상품ID
     , 월
     , SUM(매출액) AS "매출액"
  FROM 월별매출
 GROUP BY GROUPING SETS(상품ID, 월);
