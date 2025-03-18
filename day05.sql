-- CROSS INNER JOIN
-- 두 개 이상의 테이블에서 '모든 가능한 조합'을 만들어 결과를 반환하는 조인방법
-- 이를 통해 두 개 이상의 테이블을 조합하여 새로운 테이블을 만들 수 있다.

CREATE TABLE 테이블A(
   A_id NUMBER,
   A_name varchar2(10)
);

CREATE TABLE 테이블B(
   B_id NUMBER,
   B_name varchar2(20)
);


INSERT INTO 테이블A values(1, 'John');
INSERT INTO 테이블A values(2, 'Jane');
INSERT INTO 테이블A values(3, 'Bob');

INSERT INTO 테이블B values(101, 'Apple');
INSERT INTO 테이블B values(102, 'Banana');

SELECT * 
  FROM 테이블A CROSS JOIN 테이블B;

SELECT * 
  FROM 테이블A, 테이블B;

-- OUTER JOIN
-- 두 테이블에서 '공통된 값을 가지지 않는 행들'도 반환한다.

-- LEFT OUTER JOIN
-- '왼쪽 테이블의 모든 행'과 '오른쪽 테이블과 왼쪽 테이블이 공통적으로 가지는 값'을 반환한다.

-- 교집합과 차집합의 연산 결과를 합친것과 같다.
-- 만약 오른쪽 테이블에서 공통된 값을 가지고 있는 행이 없다면 NULL을 반환한다.

-- 사원테이블과 부서테이블의 LEFT OUTER JOIN을 이용하여
-- 사원이 어느 부서에 있는지 조회하기

SELECT e.FIRST_NAME, D.DEPARTMENT_NAME 
  FROM EMPLOYEES e 
  LEFT OUTER JOIN DEPARTMENTS d
    ON e.department_id = d.department_id; 

SELECT * FROM EMPLOYEES e
WHERE e.FIRST_NAME = 'Kimberely';

SELECT e.FIRST_NAME
     , d.DEPARTMENT_NAME
  FROM EMPLOYEES e, DEPARTMENTS d
 WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID(+); --107rows

-- RIGHT OUTER JOIN
-- LEFT OUTER JOIN의 반대
-- 공통데이터와 오른쪽 테이블에 있는 데이터를 조회

SELECT e.FIRST_NAME, d.department_id, D.DEPARTMENT_NAME 
  FROM EMPLOYEES e 
 RIGHT OUTER JOIN DEPARTMENTS d
    ON e.department_id = d.department_id; -- 122rows
 
SELECT e.FIRST_NAME
     , d.DEPARTMENT_NAME
  FROM EMPLOYEES e, DEPARTMENTS d
 WHERE e.DEPARTMENT_ID(+) = d.DEPARTMENT_ID; --122rows

SELECT * FROM EMPLOYEES; -- 107rows
SELECT * FROM DEPARTMENTS; -- 27rows

SELECT e.FIRST_NAME, D.DEPARTMENT_NAME 
  FROM EMPLOYEES e 
 RIGHT OUTER JOIN DEPARTMENTS d
    ON e.department_id = d.department_id;

-- FULL OUTER JHOIN
-- 두 테이블에서 '모든값'을 반환한다.
-- 서로 공통되지 않은 부분은 NULL로 채운다.
-- 합집합의 연산과 같다.
SELECT e.FIRST_NAME
     , d.DEPARTMENT_NAME 
  FROM EMPLOYEES e 
  FULL OUTER JOIN DEPARTMENTS d
 ON e.DEPARTMENT_ID  = d.DEPARTMENT_ID;

SELECT e.FIRST_NAME
     , d.DEPARTMENT_NAME 
  FROM EMPLOYEES e, DEPARTMENTS d 
 WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID(+)
 UNION
SELECT e.FIRST_NAME
     , d.DEPARTMENT_NAME
  FROM EMPLOYEES e, DEPARTMENTS d 
 WHERE e.DEPARTMENT_ID(+) = d.DEPARTMENT_ID;

-- 부서번호, 사원명, 직업, 위치를 EMP와 DEPT 테이블을 통해
-- INNER JOIN하여 조회하기

SELECT e.ENAME, e.JOB, d.LOC 
  FROM EMP e JOIN DEPT d
    ON E.DEPTNO = D.DEPTNO;

SELECT e.ENAME
     , e.JOB
     , d.LOC
  FROM EMP e
     , DEPT d
 WHERE e.DEPTNO = d.DEPTNO;

SELECT * FROM EMP;
SELECT * FROM DEPT;

-- PLAYER 테이블에서 송종국선수가 속한 팀의 전화번호 조회하기

SELECT p.TEAM_ID 
     , p.PLAYER_NAME 
     , t.TEL
  FROM PLAYER p JOIN TEAM t 
    ON p.TEAM_ID = t.TEAM_ID
 WHERE p.PLAYER_NAME = '송종국';

SELECT * FROM PLAYER;
SELECT * FROM team;

SELECT p.TEAM_ID 
     , p.PLAYER_NAME 
     , t.TEL
  FROM PLAYER p, TEAM t 
 WHERE p.TEAM_ID = t.TEAM_ID
   AND p.PLAYER_NAME = '송종국';

-- jobs 테이블과 employees 테이블에서
-- 직종번호, 직종이름, 이메일, 이름과 성(연결) 별칭을 이름으로 하고 조회하기
SELECT e.JOB_ID
     , j.JOB_TITLE 
     , e.EMAIL
     , e.FIRST_NAME || e.LAST_NAME
  FROM jobs j 
  JOIN employees e
    ON j.JOB_ID = e.JOB_ID;

SELECT e.JOB_ID
     , j.JOB_TITLE 
     , e.EMAIL
     , e.FIRST_NAME || e.LAST_NAME
  FROM jobs j, employees e
 where j.JOB_ID = e.JOB_ID;
  
SELECT * FROM employees;
SELECT * FROM jobs;

-- 비등가조인
-- 두 테이블을 결합할 때 부등호(>,<,>=,<=), BETWEEN, LIKE등
-- 다양한 비교 연산자를 통해 조인 조건을 지정하는 방식

	SELECT e.EMPNO
	     , e.ENAME
	     , s.GRADE
	     , e.SAL
	  FROM SALGRADE s 
	  JOIN EMP E
	    ON E.SAL 
   BETWEEN S.LOSAL 
	   AND S.HISAL;

-- USING() : 중복되는 컬럼이 생길 시 맨 앞으로 출력하며 중복 컬럼을 한 개만 출력한다.
SELECT * 
  FROM EMP 
  JOIN DEPT
 USING(DEPTNO);


-- DEPT테이블의 LOC별 평균 SAL를 반올림한 값과, SAL의 총합을 조회해주세요.

SELECT d.LOC
     , round(avg(e.SAL),2)
     , sum(e.SAL)
  FROM DEPT d 
  JOIN EMP e  
    ON d.DEPTNO = e.DEPTNO
 GROUP BY d.LOC;

SELECT d.LOC 
     , round(avg(e.SAL),2)
     , sum(e.SAL)
  FROM  DEPT d, EMP e
 WHERE d.DEPTNO = e.DEPTNO
GROUP BY d.LOC;

SELECT d.LOC
     , d.DEPTNO
     , d.DNAME
  FROM DEPT d 
 GROUP BY d.loc, d.DEPTNO, d.DNAME;

SELECT * FROM EMP GROUP BY DEPTNO;

-- NATURAL

SELECT * FROM emp NATURAL JOIN dept;
-- 자동매칭
-- 두 테이블에서 이름이 동일한 컬럼을 찾아서, 해당 컬럼들의 값이 일치하는 행끼리 자동으로 결합한다.
-- 중복컬럼제거
-- 조인 결과에서 공통 컬럼은 한 번만 표시된다.
-- 명시적 조건 생략
-- ON절이나 USING절 없이 간단하게 조인할 수 있다.

-- 의도하지 않은 결과가 나올 수 있다.
-- 자동으로 공통컬럼을 기준으로 조인하기 때문에,
-- 개발자가 어떤 컬럼을 기준으로 조인하는지 명확히 알기 어려울 수 있다.

-- 집합연산자
-- JOIN과는 별개로 두 개의 테이블을 합치는 방법

-- 1. UNION
-- 두 개의 테이블에서 '중복을 제거하고 합친 모든 행'을 반환
SELECT FIRST_NAME FROM EMPLOYEES e 
UNION
SELECT DEPARTMENT_NAME FROM DEPARTMENTS d;

-- VIEW
-- 하나 이상의 테이블이나 다른 뷰의 데이터를 볼수 있게 해주는 데이터베이스 객체이다.
-- 쿼리 결과를 마치 하나의 테이블처럼 사용할 수 있도록 하는 가상 테이블
-- 실제 데이터는 저장하지 않고, 뷰를 참조할 때마다 미리 정의된 쿼리문이 실행되어 결과가 생성된다.

-- 사용목적
-- 여러 테이블에서 필요한 정보를 사용할때가 많다.
-- VIEW에 저장하면 간단하게 호출할 수 있다.

-- VIEW의 특징
-- 독립성
-- 테이블 구조가 변경되어도 뷰를 사용하는 응용프로그램은 변경하지 않아도 된다.

-- 편리성
-- 복잡한 쿼리문을 뷰로 생성함으로써 관련 쿼리를 단순하게 작성할 수 있다.
-- 자주 사용하는 SQL문이면 뷰에 저장하고 편리하게 사용할 수 있다.

-- 보안성
-- 숨기고 싶은 정보가 존재한다면, VIEW를 생성할때 해당 컬럼은 빼고
-- 생성함으로써 사용자에게 정보를 감출 수 있다.

/*
CREATE OR REPLACE VIEW 뷰 이름 AS (
	쿼리문
)
*/

-- VIEW 삭제
-- DROP VIEW 뷰이름 [RESTRICT 또는 CASCADE]
-- RESTRICT : 뷰를 다른곳에서 참조하고 있다면 삭제가 취소
-- CASCADE : 뷰를 참조하는 다른 뷰나 제약 조건까지 모두 삭제된다.

SELECT p.PLAYER_NAME
     , P.BIRTH_DATE
  FROM PLAYER p;

SELECT p.PLAYER_NAME
	 , p.BIRTH_DATE
     , TRUNC(MONTHS_BETWEEN(SYSDATE, BIRTH_DATE) / 12) -
       CASE WHEN TO_CHAR(BIRTH_DATE, 'MMDD') > 
                 TO_CHAR(SYSDATE, 'MMDD') THEN 1 ELSE 0 END AS EXACT_AGE
  FROM PLAYER p
 ORDER BY p.PLAYER_NAME asc;

CREATE OR REPLACE VIEW PLAYER_AGE AS (
	SELECT ROUND ((SYSDATE - BIRTH_DATE) / 365) AS AGE 
	     , P.* 
	  FROM PLAYER P
);

SELECT * FROM PLAYER_AGE pa;

SELECT * 
  FROM PLAYER_AGE pa
 WHERE pa.AGE >= 30;

-- 사원이름과 상사 이름을 조회하기
SELECT e1.FIRST_NAME || ' ' || e1.LAST_NAME  AS ENAME
     , e2.FIRST_NAME || ' ' || e2.LAST_NAME AS MNAME
  FROM EMPLOYEES e1 FULL OUTER JOIN EMPLOYEES e2
    ON e1.MANAGER_ID = e2.EMPLOYEE_ID;

CREATE OR REPLACE VIEW EMPLOYEES_MANAGER AS (
SELECT e1.FIRST_NAME || ' ' || e1.LAST_NAME  AS ENAME
     , e2.FIRST_NAME || ' ' || e2.LAST_NAME AS MNAME
  FROM EMPLOYEES e1 FULL OUTER JOIN EMPLOYEES e2
    ON e1.MANAGER_ID = e2.EMPLOYEE_ID
);

SELECT * FROM EMPLOYEES_MANAGER;

-- KING STEVEN의 부하직원이 몇명인지 조회하세요.
SELECT count(*)
  FROM EMPLOYEES_MANAGER
WHERE MNAME = 'Steven King';

-- player 테이블에 team_name 컬럼을 추가한 view 만들기
-- view 이름은 player_team_name

CREATE OR REPLACE VIEW player_team_name AS (
	SELECT t.TEAM_NAME
	     , p.*
	 FROM PLAYER p JOIN team t
	   ON p.TEAM_ID = t.TEAM_ID
);

SELECT t.TEAM_NAME
     , p.*
 FROM PLAYER p join team t
   ON p.TEAM_ID = t.TEAM_ID;

SELECT * FROM player_team_name;

-- TEAM_NAME이 '울산현대' 인 선수들을 조회

SELECT * FROM player_team_name
WHERE TEAM_NAME = '울산현대';

-- HMOETEAM_ID, STADIUM_NAME, TEAM_NAME을 조회
-- HOMETEAM이 없는 경기장 이름도 나와야함.


SELECT * FROM TEAM t;
SELECT * FROM STADIUM s;

CREATE OR REPLACE VIEW STADIUM_INFO AS (
	SELECT s.HOMETEAM_ID
	     , s.STADIUM_NAME
	     , t.TEAM_NAME
	  FROM TEAM t RIGHT OUTER JOIN STADIUM s
	    ON t.STADIUM_ID = s.STADIUM_ID
);

SELECT * FROM STADIUM_INFO st
WHERE st.hometeam_id IS null;

-- 사원 테이블에서 급여, 급여를 많이 받는순으로 순위를 조회
-- DATA_PULS라는 VIEW에 저장
SELECT e.FIRST_NAME
     , e.SALARY
     , RANK()over(ORDER BY salary desc)
  FROM EMPLOYEES e;

CREATE OR REPLACE VIEW DATA_PLUS AS (
	SELECT e.FIRST_NAME
	     , e.SALARY
	     , RANK()over(ORDER BY salary desc) AS RANK
	  FROM EMPLOYEES e
);

SELECT * 
  FROM DATA_PLUS
 WHERE RANK BETWEEN 1 AND 10;

-- TCL(Transaction Controll Language)
-- 트랜잭션 : 데이터베이스의 작업을 처리하는 논리적 연산 단위
-- select, insert, update, delete문을 하나의 작업단위라고 한다.

-- CASE문
-- 데이터의 값을 WHEN의 조건과 차례대로 비교한 후 일치하는 값을 찾아 THEN 뒤에 있는 결과값을 반환한다.

SELECT ENAME
     , DEPTNO
     , CASE 
           WHEN DEPTNO = '10' THEN 'NEW YORK'
           WHEN DEPTNO = '20' THEN 'DALLAS'
           ELSE 'UNKNOWN'
        END AS LOC_NAME
  FROM EMP e
 WHERE E.JOB = 'MANAGER';

SELECT ROUND(AVG(CASE e.JOB_ID WHEN 'IT_PROG' THEN e.SALARY END),2) 평균급여
  FROM EMPLOYEES e;

-- WHERE절 에서의 사용
SELECT ENAME
     , SAL
     , CASE 
	       WHEN SAL >= 2900 THEN '1등급'
	       WHEN SAL >= 2700 THEN '2등급'
     	   WHEN SAL >= 2000 THEN '3등급'
        END AS SAL_GRADE
  FROM EMP e
 WHERE JOB = 'MANAGER' 
   AND (CASE 
	       WHEN SAL >= 2900 THEN 1
	       WHEN SAL >= 2700 THEN 2
     	   WHEN SAL >= 2000 THEN 3
         END) = 1;

-- EMP테이블에서 SAL 이 3000이상이면 HIGH, 1000이상이면 MID,
-- 다 아니면 LOW를 ENAME, SAL, GRADE 순으로 조회

SELECT ENAME
     , SAL
     , CASE 
	       WHEN SAL >= 3000 THEN 'HIGH'
	       WHEN SAL >= 1000 THEN 'MID'
	       ELSE 'LOW'
        END AS GRADE
  FROM EMP;

-- CASE문의 특징과 활용
-- 표현식으로 사용
-- CASE문은 하나의 값이나 결과를 반환하는 표현식이기 떄문에
-- SELECTL, ORDER BY, GROUP BY 등의 구문 내에서 사용될 수 있다.

-- 가독성 향상
-- 복잡한 조건에 따른 값을 한눈에 파악할 수 있게 도와주어 쿼리의 가독성과 유지보수성이 높아진다.

-- NULL 처리
-- 조건에 해당하지 않는 경우 ELSE절이 없으면 NULL이 반환

-- 중첩 사용 가능
-- CASE문 안에 CASE 문을 중첩해서 사용할 수 있다.

-- 표준 SQL지원
-- 대부분의 주요 데이터베이스등에서 표준 SQL문법의 일부로 지원된다.

-- PL (Procedural Language)/SQL문
-- 원래 SQL문은 주로 데이터의 정의, 조작, 제어를 위한 언어
-- PL/SQL은 여기에 조건, 반복문, 변수 선언, 예외처리와 같은 
-- 절차적 기능을 추가하여 복잡한 로직을 구현할 수 있게 해준다.

-- PL/SQL 문의 구조
-- 기본적으로 블록단위로 구성. 하나의 블록은 세 부분으로 이루어져있다.
-- 선언부(DECLARE) : 변수, 상수, 사용자 정의 타입을 선언
-- 실행부(DEGIN ... END) : 실제 로직이 작성되는 부분
-- 예외처리부(EXCEPTION) : 실행 도중 발생하는 오류를 처리하는 구문 작성

DECLARE
    v_message varchar2(100); -- 변수 let v_message 선언
  BEGIN
  	v_message := 'Hello, PL/SQL'; -- 변수에 대입
    DBMS_OUTPUT.PUT_LINE(v_message); -- console.log()방식
    END;
/*
1. IF 조건 THEN 실행문;
   END IF;
2. IF 조건 THEN 실행문;
   ELSE 실행문;
   END IF;
3. IF 조건 THEN 실행문;
   ELSIF 조건 THEN 실행문;
   ELSIF 조건 THEN 실행문;
   ELSIF 조건 THEN 실행문;
   END IF;
*/

DECLARE 
    salary NUMBER := 5000;
  BEGIN
  	IF salary < 3000 THEN DBMS_OUTPUT.PUT_LINE('급여가 낮습니다.');
    ELSIF salary between 3000 AND 7000 THEN DBMS_OUTPUT.PUT_LINE('급여가 중간입니다.');
    ELSE DBMS_OUTPUT.PUT_LINE('급여가 높습니다.');
    END IF;
  END;
  
-- SCORE 변수에 80을 대입하고
-- GRADE VARCHAR2(5) 에 어떤 학점인지 대입하여 출력하기
-- 90점 이상은 A, 80점 이상은 B, 70점 이상은 C
-- 60점 이상은 D, 그 이하는 F
-- EX) 당신의 점수 80점, 학점 B

DECLARE 
    SCORE NUMBER := 80;
    GRADE VARCHAR2(5)
        CASE 
	       WHEN SCORE >= 90 THEN 'A'
	       WHEN SCORE >= 80 THEN 'B'
	       WHEN SCORE >= 70 THEN 'C'
	       WHEN SCORE >= 60 THEN 'D'
	       ELSE 'F'
	     END
  BEGIN
  	IF SCORE => 90 THEN DBMS_OUTPUT.PUT_LINE('당신의 점수는 ');
    ELSIF SCORE => 80 THEN DBMS_OUTPUT.PUT_LINE('급여가 낮습니다.');
    ELSIF SCORE => 70 THEN DBMS_OUTPUT.PUT_LINE('급여가 낮습니다.');
    ELSIF SCORE => 60 THEN DBMS_OUTPUT.PUT_LINE('급여가 낮습니다.');
    ELSE DBMS_OUTPUT.PUT_LINE('급여가 높습니다.');
    END IF;
  END;

DECLARE 
    SCORE NUMBER := 80;
    GRADE VARCHAR2(5);
  BEGIN
  	IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
	END IF;
    DBMS_OUTPUT.PUT_LINE('당신의 점수 : ' || SCORE || '점' || CHR(10) || '학점 : ' || GRADE);
  END;

-- FOR문
-- FOR 변수 IN 시작값 ... END값 LOOP
-- 반복하고자 하는 명령;
-- END LOOP;
BEGIN
	FOR I IN REVERSE 1..10 LOOP
		DBMS_OUTPUT.PUT_LINE('I의 값:' || I);	
	END LOOP;
END;

-- 1부터 10까지
-- X는 짝수입니다.
-- X는 홀수입니다.
BEGIN
	FOR x IN 1..10 LOOP
		IF MOD(x, 2) = 0 THEN
			DBMS_OUTPUT.PUT_LINE(x || ' 는 짝수입니다.');			
		ELSE 
			DBMS_OUTPUT.PUT_LINE(x || ' 는 홀수입니다.');
		END if;
	END LOOP;
END;

DECLARE
    CURSOR emp_cursor IS
   		SELECT employee_id, first_name FROM employees;
	BEGIN
		FOR rec IN emp_cursor LOOP
			DBMS_OUTPUT.PUT_LINE('Employee :' || rec.first_name);
		END LOOP;
	END;
END;

-- while
-- while 조건 loop
--     반복할 문장
-- end loop;

-- 1 부터 10까지 총합을 구해보시오
-- EX) 총합 : XX
DECLARE
    i   := 1;
    total INTEGER := 0;
	BEGIN
	    WHILE i <= 10 LOOP 
	        total := total + i;
	        i := i + 1;
	    END LOOP;
	    DBMS_OUTPUT.PUT_LINE('총합: ' || total);
	END;
END;

-- PL/SQL의 종류
-- 익명블록
-- 이름 없이 한 번 실행되는 PL/SQL블록이다.
-- 데이터베이스에 저장되지 않고 즉시 실행된다.
-- 테스트, 일회성 작업, 간단한 스크립트 작성 등에 주로 사용된다.

-- 2. 프로시저(Procedures)
-- 데이터베이스에 저장되어 필요할 때마다 호출할 수 있는 이름이 있는 PL/SQL 블록이다.

-- 3. 트리거(Tigger)
-- 특정 테이블 또는 뷰에 대한 DML 또는 DDL 작업이 발생할 때 자동으로 실행되는 PL/SQL 코드이다.
-- 하나의 요청으로 여러 SQL문을 실행시킬 수 있다.
-- 네트워크 소요시간을 줄여 성능을 개선할 수 있다.
-- 기능 변경이 편하다.

/*
 CREATE OR REPLACE PROCEDURE 프로시저명 (
 	  매개변수 IN 데이터타입%TYPE
 	, 매개변수 IN 데이터타입%TYPE
 	, 매개변수 IN 데이터타입%TYPE
 )IS 
 함수 내에서 사용할 변수, 상수 선언
 BEGIN
 	실행할 문장
 END;
 */

-- JOBS 테이블에 INSERT를 해주는 프로지서 만들어보기
SELECT * FROM JOBS;

 CREATE OR REPLACE PROCEDURE MY_NEW_JOB_PROC (
 	  P_JOB_ID IN JOBS.JOB_ID%TYPE
 	, P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE
 	, P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE
 	, P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE
 )IS 
 BEGIN
 	INSERT INTO JOBS(
 	            JOB_ID
              , JOB_TITLE
              , MIN_SALARY
              , MAX_SALARY
       ) VALUES (
                P_JOB_ID
              , P_JOB_TITLE
              , P_MIN_SALARY
              , P_MAX_SALARY
       );
 END;
 
CALL MY_NEW_JOB_PROC ('IT', 'DEVELOPER', 14000, 20000);
SELECT * FROM JOBS;

-- 함수와 프로시저의 차이
-- 함수는 반드시 하나 이상의 값을 반환해야한다
-- 함수는 SQL문 내에서 사용할 수 있다.
-- 함수는 주로 계산, 데이터의 가공, 값의 반환 작업에 사용

-- 프로시저는 값을 반드시 반환할 필요는 없다.
-- 프로시저는 SQL문 내에서 사용할 수 없다.
-- 함수는 특정 작업이나 프로세스를 실행하기 위해 사용된다.