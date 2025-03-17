-- 주석

-- 테이블 생성하기
CREATE TABLE TBL_MEMBER(
	-- 어떤 데이터를 저장하고 싶은지 명시
	  NAME VARCHAR2(20)
	, AGE NUMBER  
);

-- 테이블 삭제
DROP TABLE TBL_MEMBER;

-- 제약조건을 가지는 CAR 테이블 만들기
-- CONSTRAINT 제약조건명 제약조건종류(컬럼명)
CREATE TABLE TBL_CAR (
	  ID NUMBER
	, BRAND VARCHAR2(100)
	, COLOR VARCHAR2(100)
	, PRICE NUMBER
	, CONSTRAINT CAR_PK PRIMARY KEY(ID)
);

CREATE TABLE EX1 (
	  COL1 VARCHAR2(10) NOT NULL
	, COL2 VARCHAR2(10) NOT NULL UNIQUE
	-- 데이터를 넣지 않을 시 현재 시간이 들어간다.
	, CREATE_DATE DATE DEFAULT SYSDATE
);

-- 테이블 컬럼명 변경
ALTER TABLE EX1 RENAME COLUMN COL1 TO COL11;

-- 테이블 컬럼 타입 변경
ALTER TABLE EX1 MODIFY COL2 VARCHAR2(30);

-- 테이블 컬럼 추가
ALTER TABLE EX1 ADD COL3 NUMBER;

-- 이미 생성된 테이블에 제약조건 추가하기
-- ALERT TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건종류(컬럼명);
-- EX1 테이블에 PK EX1 이라는 이름으로 COL11에 PRIMARY KEY 제약조건 추가
ALTER TABLE EX1 ADD CONSTRAINT PK_EX1 PRIMARY KEY(COL11);

-- 제약조건 삭제하기
-- ALERT TABLE 테이블명 DROP CONSTRAINT 제약조건명;
ALTER TABLE EX1 DROP CONSTRAINT PK_EX1;

DROP TABLE EX1;

-- DB 내의 지원 문자면 "" 를 사용하여 컬럼 이름으로 사용 가능
CREATE TABLE TBL_ANIMAL (
	  ID NUMBER
	, "TYPE" VARCHAR2(10)
	, AGE NUMBER
	, FEED VARCHAR2(10)
	, CONSTRAINT ID_PK PRIMARY KEY(ID)
);

DROP TABLE TBL_ANIMAL;

-- 학생 테이블
-- DEFAULT, CHECK 제약조건을 사용
CREATE TABLE TBL_STUDENT (
	  ID NUMBER
	, NAME VARCHAR2(20)
	, MAJOR VARCHAR2(20)
	, GENDER CHAR(1) DEFAULT 'W' NOT NULL CONSTRAINT BAN_CHAR CHECK(GENDER = 'M' OR GENDER = 'W')
	, BIRTH DATE CONSTRAINT BAN_DATE CHECK(BIRTH >= TO_DATE('1980-01-01', 'YYYY-MM-DD'))
	, CONSTRAINT STD_PK PRIMARY KEY(ID)
);

DROP TABLE TBL_STUDENT;


CREATE TABLE PRODUCT (
	  "NO" NUMBER PRIMARY KEY
	, NAME VARCHAR2(100) NOT NULL
	, PRICE NUMBER
	, P_DATE DATE
);


