CREATE TABLE "USER" (
	  ID VARCHAR2(100) PRIMARY KEY
	, PW VARCHAR2(100)
	, ADDRESS VARCHAR2(300)
	, EMAIL VARCHAR2(300)
	, BRITH DATE
);

CREATE TABLE "PRODUCT" (
	  PRODUCT_NUM NUMBER PRIMARY KEY
	, PRODUCT_NAME VARCHAR2(100)
	, PRODUCT_PRICE NUMBER
	, PRODUCT_COUNT NUMBER
);

CREATE TABLE "ORDER" (
	  ORDER_NUM NUMBER
	, ORDER_DATE DATE
	, USER_ID VARCHAR2(100)
	, PRODUCT_NUM NUMBER
	, CONSTRAINT USER_FK FOREIGN KEY (USER_ID) REFERENCES "USER" (ID)
	, CONSTRAINT PRODUCT_FK FOREIGN KEY (PRODUCT_NUM) REFERENCES TEST_PRODUCT(PRODUCT_NUM)
);

CREATE TABLE TBL_FLOWER (
	  FLO_NAME VARCHAR2(100) PRIMARY KEY
	, FLO_COLOR VARCHAR2(100)
	, FLO_PRICE NUMBER
);

CREATE TABLE TBL_FLOWERPOT (
	  POT_NO NUMBER PRIMARY KEY
	, POT_COLOR VARCHAR2(100)
	, POT_SHAPE VARCHAR2(100)
	, FLO_NAME VARCHAR2(100)
	, CONSTRAINT POT_FK FOREIGN KEY (FLO_NAME) REFERENCES TBL_FLOWER(FLO_NAME)
);

-- 사원 테이블에서 모든 내용을 조회하세요
SELECT * FROM EMPLOYEES;

-- 부서 테이블의 모든 정보를 조회하시오.
SELECT * FROM departments;

-- 사원테이블에서 이름, 직종, 급여를 조회하세요.
SELECT FIRST_NAME AS 이름
     , JOB_ID AS 직종
     , SALARY AS 급여
  FROM EMPLOYEES;

-- 사원 테이블에서 사번, 이름, 입사일, 급여를 조회하세요.
SELECT EMPLOYEE_ID AS 사번
     , FIRST_NAME || ' ' || LAST_NAME AS 이름
     , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD (DY)') AS 입사날짜
     , SALARY AS 급여
  FROM EMPLOYEES;

SELECT EMPLOYEE_ID AS 사번
     , FIRST_NAME || ' ' || LAST_NAME AS 이름
     , SALARY AS 급여
     , SALARY * COMMISSION_PCT AS 보너스
  FROM EMPLOYEES
 WHERE 1=1 
   AND COMMISSION_PCT IS NOT NULL;

-- 사원테이블에서 급여가 10000이상인 사원들의 정보를 사번, 이름, 급여 순으로 조회하기
SELECT EMPLOYEE_ID AS 사번
     , FIRST_NAME || ' ' || LAST_NAME AS 이름
     , SALARY AS 급여
FROM EMPLOYEES
WHERE SALARY > 10000;

-- 사원테이블에서 이름이 MICHAEL 인 사원의 사번, 이름, 급여를 조회
SELECT EMPLOYEE_ID
	 , FIRST_NAME || ' ' || LAST_NAME
	 , SALARY
  FROM EMPLOYEES
 WHERE 1=1
   AND FIRST_NAME = 'Michael';

-- 사원테이블에서 직종이 IT_PROG 인 사원들의 정보를
-- 사번, 이름, 직종, 급여 순으로 출력하세요.
SELECT EMPLOYEE_ID
	 , FIRST_NAME || ' ' || LAST_NAME
	 , JOB_ID
	 , SALARY
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG';

-- 사원테이블에서 급여가 10000이상 13000이하인 사원의 정보를
-- 사원번호, 이름, 급여순으로 조회
SELECT EMPLOYEE_ID AS 사번
     , FIRST_NAME || ' ' || LAST_NAME AS 이름
     , SALARY AS 급여
FROM EMPLOYEES
WHERE SALARY >= 10000 AND SALARY <= 13000;

-- 사원테이블에서 입사일이 05년 9월 21일인 사원의 정보를 사번, 이름, 입사일자 순으로 출력
SELECT EMPLOYEE_ID AS 사번
     , FIRST_NAME || ' ' || LAST_NAME AS 이름
     , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD (DY)') AS 입사날짜
     , SALARY AS 급여
  FROM EMPLOYEES
 WHERE 1=1
   AND HIRE_DATE >= '2005-09-21';

-- 사원테이블에서 직종이 SA_MAN 이거나 IT_PROG인 사원들의 모든 정보를 출력하세요.
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID = 'SA_MAN' OR JOB_ID = 'IT_PROG';

-- 사원테이블에서 급여가 2200, 3200, 5000, 6800을 받는 사원의 정보
-- 사번, 이름, 직종, 급여순으로 조회하세요.
SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME
     , e.JOB_ID
     , e.SALARY
  FROM EMPLOYEES e
 WHERE e.SALARY = '2200' 
    OR e.SALARY = '3200' 
    OR e.SALARY = '5000' 
    OR e.SALARY ='6800';

-- SQL 연산자
-- 1. BETWEEN : A 와 B 사이의 값을 조회할 때 사용
-- 2. IN : OR 을 대신해서 사용하는 연산자
-- 3. LIKE : 유사검색

-- 사원테이블에서 06년도에 입사한 사원들의 정보를 사번, 이름, 직종, 입사일 순으로 조회
SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME
     , e.JOB_ID
     , e.HIRE_DATE
  FROM EMPLOYEES e
 WHERE e.HIRE_DATE BETWEEN '2006-01-01' AND '2006-12-31'
 ORDER BY e.HIRE_DATE ASC;

SELECT e.FIRST_NAME
     , e.JOB_ID
  FROM EMPLOYEES e 
 WHERE e.JOB_ID IN ('SA_MAN', 'IT_PROG');

-- IN절
SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME
     , e.JOB_ID
     , e.SALARY
  FROM EMPLOYEES e
 WHERE e.SALARY IN ('2200','3200','5000','6800');

-- LIKE절
-- 'M%' : M으로 시작하는 모든 값
-- '%M' : M으로 끝나는 모든 값
-- '%M%' : M을 포함한 모든 값
-- 'A_' : A로 시작하는 두글자 데이터
-- 'A__' : A로 시작하는 세글자 데이터
-- '_A' : A로 끝나는 두글자 데이터
-- '__A' : A로 끝나는 세글자 데이터
-- '_A_' : 두번째 글자가 A가 들어가는 세글자 데이터
SELECT EMPLOYEE_ID
	 , FIRST_NAME || ' ' || LAST_NAME
	 , SALARY
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE 'M%';

SELECT EMPLOYEE_ID
	 , FIRST_NAME || ' ' || LAST_NAME
	 , SALARY
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%m';

-- 사원테이블에서 사원들의 이름중 M으로 시작하는 사원들의 정보를 사번, 이름, 직종순으로 출력하세요.
SELECT EMPLOYEE_ID
	 , FIRST_NAME || ' ' || LAST_NAME
	 , JOB_ID
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE 'M%';

-- 사원테이블에서 이름이 d로 끝나는 사원의 사번, 이름, 직종을 조회하세요.

SELECT EMPLOYEE_ID
	 , FIRST_NAME || ' ' || LAST_NAME
	 , JOB_ID
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%d';

-- 사원테이블에서 이름이 a가 포함되어 있는 사원의 정보를 이름, 직종순으로 조회하세요.

SELECT FIRST_NAME || ' ' || LAST_NAME
	 , JOB_ID
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%a%';

-- 이름에 소문자 o 가 들어가면서 a로 끝나는 사원들의 정보를 이름, 급여순으로 조회

SELECT FIRST_NAME || ' ' || LAST_NAME
	 , SALARY
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%o%%a';

-- 이름이 H로 시작하면서 6글자 이상인 사원의 정보를 사번, 이름순으로 조회하세요.
SELECT EMPLOYEE_ID
	 , FIRST_NAME || ' ' || LAST_NAME
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE 'H______%';

-- 사원테이블에서 이름이 s 가 포함되어 있지 않은 사원들만 사번, 이름순으로 조회하세요.
SELECT EMPLOYEE_ID
	 , FIRST_NAME || ' ' || LAST_NAME
  FROM EMPLOYEES
 WHERE FIRST_NAME NOT LIKE '%s%';

-- or 연산자를 통해서 여러개의 LIKE 조건을 연결할 수 있다.
SELECT e.FIRST_NAME
  FROM EMPLOYEES e 
 WHERE e.FIRST_NAME LIKE '%el%' OR e.FIRST_NAME LIKE '%en%';

-- INSERT
-- 테이블에 데이터를 추가하는 문법
-- INSERT INTO (COLUMN 1 , COLUMN 2 ...)
-- VALUES (DATA 1, DATA2 ...);

INSERT INTO TBL_STUDENT 
            (ID, NAME, MAJOR, GENDER, BIRTH)
     VALUES (01,'홍길동','의적','M',TO_DATE('1980-01-02', 'YYYY-MM-DD'));

SELECT * FROM TBL_STUDENT ORDER BY ID ASC;

INSERT INTO TBL_STUDENT
			(ID, NAME, MAJOR, GENDER, BIRTH)
     VALUES (02, '허춘삼', '컴공', 'W', TO_DATE('1980-01-02', 'YYYY-MM-DD'));


-- CHECK(BIRTH >= TO_DATE('1980-01-01') 로 인해 '1980-01-01' 보다 나이가 많은 사람은 추가할 수 없다. 
INSERT INTO TBL_STUDENT
			(ID, NAME, MAJOR, GENDER, BIRTH)
     VALUES (03, '김마리', '컴공', 'W', TO_DATE('2000-12-30', 'YYYY-MM-DD'));

INSERT INTO TBL_STUDENT
			(ID, NAME, MAJOR, BIRTH)
     VALUES (04, '김을적', '컴공', TO_DATE('2000-12-30', 'YYYY-MM-DD'));


INSERT INTO TBL_FLOWER
(FLO_NAME, FLO_COLOR, FLO_PRICE)
VALUES('튤립', '노란색', 2000);

INSERT INTO TBL_FLOWER
(FLO_NAME, FLO_COLOR, FLO_PRICE)
VALUES('무궁화', '보라색', 3000);

INSERT INTO TBL_FLOWER 
(FLO_NAME, FLO_COLOR, FLO_PRICE)
  VALUES('장미꽃', '빨간색', 3000);

INSERT ALL
    INTO TBL_FLOWER (FLO_NAME, FLO_COLOR, FLO_PRICE) VALUES ('장미꽃', '빨간색', 3000)
    INTO TBL_FLOWER (FLO_NAME, FLO_COLOR, FLO_PRICE) VALUES ('튤립', '노란색', 2000)
    INTO TBL_FLOWER (FLO_NAME, FLO_COLOR, FLO_PRICE) VALUES ('무궁화', '보라색', 3000)
SELECT * FROM DUAL;

SELECT *FROM TBL_FLOWER;

INSERT INTO HR.TBL_FLOWERPOT
(POT_NO, POT_COLOR, POT_SHAPE, FLO_NAME)
VALUES('202503130001', '검은색', '타원형', '튤립');

INSERT INTO HR.TBL_FLOWERPOT
(POT_NO, POT_COLOR, POT_SHAPE, FLO_NAME)
VALUES('202503130002', '은색', '동그라미', '무궁화');

INSERT INTO HR.TBL_FLOWERPOT
(POT_NO, POT_COLOR, POT_SHAPE, FLO_NAME)
VALUES('202503130003', '흰색', '네모', '장미꽃');

SELECT * FROM TBL_FLOWERPOT;

-- DELETE
-- 외래키로 참조되고 있을 때 자식 테이블에서 참조되고 있는 행을 먼저 삭제해야 부모 테이블에서 삭제할 수 있다.
DELETE FROM TBL_FLOWER WHERE FLO_NAME = '튤립';
DELETE FROM TBL_FLOWERPOT WHERE FLO_NAME = '튤립';

-- DELETE 문에 조건을 쓰지 않으면 모든 의도하지 않게 모든 데이터가 날아갈 수 있다.
DELETE FROM TBL_FLOWERPOT;
SELECT * FROM TBL_FLOWERPOT;

-- UPDATE
-- UPDATE 테이블명
--    SET 컬럼명 = '변경값'
--  WHERE 조건식

-- TBL_STUDENT 테이블에서 홍길동의 전공을 경영학과로 수정하기
UPDATE TBL_STUDENT
   SET MAJOR = '경영학과'
 WHERE NAME = '홍길동'
 
SELECT * FROM TBL_STUDENT;
 
-- 테이블 사이에는 관계라는 개념이 존재하고
-- 일대일(1:1, 일대다(1:N), 다대다(N:M) 의 관계가 있다.

-- 일대일 관계
-- 두 테이블 A와 B 가 있을 때 A의 정보와 B의 정보 하나가 연결된 관계
-- EX) 한 사람은 하나의 여권만 소지할 수 있고 하나의 여권은 한 사람에게만 발급된다.

-- 일대다 관계
-- 테이블 A의 레코드(행) 하나가 B의 여러 행과 연결되는 관계
-- EX) 한 사람이 여러개의 부동산을 가질 수 있다. 하나의 집은 주인이 한명이다.

-- 다대다 관계
-- 테이블 A의 행 하나가 테이블 B의 행 여러개와,
-- 테이블 B의 행 하나가 테이블 A의 행 여러개와 연결된 관계
-- EX) 학생과 강의의 관계
-- 한 한색이 여러강의를 수강할 수 있다.
-- 하나의 강의는 여러 학생들이 들을 수 있다.

-- 다대다 관계는 두개의 테이블 사이에서 직접 구현할수 없으므로 연결 테이블을 사용하여 테이블 A와 B를 연결한다.
-- 연결테이블은 두 테이블의 기본키를 외래키로 포함하며 복합 기본키로 지정하는 경우가 많다.

CREATE TABLE CD (
	  TITLE VARCHAR2(100) PRIMARY KEY
	, PRICE NUMBER
	, GENRE VARCHAR2(100)
	, TRACKLIST VARCHAR2(100)
	, ARTISTNAME VARCHAR2(100)
	, CONSTRAINT NAME_FK FOREIGN KEY (ARTISTNAME) REFERENCES ARTIST (NAME)
);

CREATE TABLE ARTIST (
	  NAME VARCHAR2(100) PRIMARY KEY
	, COUNTRY VARCHAR2(100)
	, DEBUTYEAR DATE
);

CREATE TABLE TRACK (
	  TITLE VARCHAR2(100) PRIMARY KEY 
	, RUNTIME VARCHAR2(100)
	, CDTITLE
	, CONSTRAINT CD_FK FOREIGN KEY (CDTITLE) REFERENCES CD (TITLE)
);

-- 10번 및 30번 부서에 속하는 모든 사원 중 급여가 1500을 넘는 사원의사원번호,이름 및 급여를 조회하세요
SELECT * FROM departments dp;
SELECT * FROM EMPLOYEES e;

SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME
     , e.SALARY
  FROM EMPLOYEES e
WHERE e.DEPARTMENT_ID IN ('10', '30')
  AND e.SALARY > 1500;

-- 관리자가 없는 모든 사원의 이름 및 직종을 출력하세요
SELECT e.FIRST_NAME
     , e.JOB_ID
  FROM EMPLOYEES e
 WHERE e.MANAGER_ID IS NULL;

-- 직업이 IT_PROG 또는 SA_MAN 이면서 급여가 1000,3000,5000이 아닌 모든 사원들의 이름, 직종 및 급여를 조회하세요
SELECT e.FIRST_NAME
     , e.JOB_ID
     , e.SALARY
  FROM EMPLOYEES e
 WHERE SALARY NOT IN (1000,3000,5000)
   AND JOB_ID IN ('IT_PROG', 'SA_MAN');




