/*
FK
    부모테이블 + 자식테[이블
    
Sequence 객체 생성 및 사용
*/
 /*관계 형성하기*/
 DROP TABLE child_1;
 DROP TABLE parent_1;
 
-- 부모테이블 생성
CREATE TABLE parent_1
(
    seqno NUMBER PRIMARY KEY,
    usrname VARCHAR2(20) NOT NULL,
    phone VARCHAR2(10)
);
-- 자식이블 생성
/*CREATE TABLE child_1
(
    seqnum NUMBER PRIMARY KEY,
    jumin VARCHAR2(13) NOT NULL,
    address VARCHAR2(50),
    seqno NUMBER REFERENCES parent_1(seqno) ON DELETE CASCADE
);*/
CREATE TABLE child_1
(
    seqnum NUMBER PRIMARY KEY,
    jumin VARCHAR2(13) NOT NULL,
    address VARCHAR2(50),
    seqno NUMBER REFERENCES parent_1(seqno)
);
-- 부모테이블에 데이터 삽입
INSERT INTO parent_1 VALUES(1, '홍길동','1111');
INSERT INTO parent_1 VALUES(2, '저팔계','2222');
INSERT INTO parent_1 VALUES(3, '사오정','3333');

-- 자식테이이블에 테이터 삽입
INSERT INTO child_1 VALUES(11, '921124','서울', 1);
INSERT INTO child_1 VALUES(12, '931124','부산', 2);
INSERT INTO child_1 VALUES(13, '941124','인천', 2);
INSERT INTO child_1 VALUES(14, '951124','제주', 3);

SELECT * FROM parent_1;
SELECT * FROM child_1;
--
DELETE child_1
WHERE seqno = 2;

DELETE parent_1
WHERE seqno = 2;

-- 새로운 테이블 생성하기
CREATE TABLE parent_2
(
    seqnum NUMBER PRIMARY KEY,
    usrid VARCHAR2(20) UNIQUE NOT NULL,
    usrname VARCHAR2(20)NOT NULL,
    email VARCHAR2(30) UNIQUE NOT NULL
);

--일련버호 발생하는 객체 생성하기(SEQUENCE)
DROP SEQUENCE parent2_seq;
CREATE SEQUENCE parent2_seq; -- 1로부터 발생시키기 시작함

CREATE TABLE child_2
(
    seqnum NUMBER PRIMARY KEY,
    jumin VARCHAR2(13) NOT NULL,
    address VARCHAR2(50),
    seqno NUMBER REFERENCES parent_1(seqno)
);
/*
parent2_seq.next_val : 다음 값을 발생시킴
parent2_seq.curr_val : 마지막으로 발생시킨 일련번호의 값을 알고자 할 때
*/

SELECT parent2_seq.nextval FROM dual; -- 가상테이블(더미테이블
SELECT parent2_seq.currval FROM dual;

--parent_2 테이블에 sequence를 이용해 값 삽입하기
INSERT INTO parent_2
(seqnum, usrid, usrname, email)
VALUES
(PARENT2_SEQ.nextval, 'aaa','홍길동','aaa@naver.com');

INSERT INTO parent_2
(seqnum, usrid, usrname, email)
VALUES
(PARENT2_SEQ.nextval, 'bbb','손오공','bbb@naver.com');

SELECT * FROM parent_2;

/*[문제] score_2 테이블을 생성하시오.
seqno : 시퀀스 번호(시퀀스 객체 생성해서 사용할것 score_2_seq)
seqnum : FK
kor : 0
emg : 0
mat : 0
*/
DROP TABLE score_2;
DROP SEQUENCE score_2_seq;

CREATE TABLE score_2
(
    seqno NUMBER PRIMARY KEY,
    seqnum NUMBER REFERENCES parent_2(seqnum)ON DELETE CASCADE,
    kor NUMBER(3) DEFAULT 0,
    emg NUMBER(3) DEFAULT 0,
    amt NUMBER(3) DEFAULT 0
);
CREATE SEQUENCE score_2_seq;
--자기 자신의 컬럶을 참조하는 테이블 생성하기
DROP TABLE emp;
CREATE TABLE emp
(
    empno NUMBER PRIMARY KEY,
    ename VARCHAR2(20)NOT NULL,
    jobtitle VARCHAR2(30),
    mgrno NUMBER REFERENCES emp(empno)
);



INSERT INTO emp VALUES(1,'홍길동', '대표이사', null);
INSERT INTO emp VALUES(2,'손오공', '전무', 1);
INSERT INTO emp VALUES(3,'사오정', '상무', 1);

INSERT INTO emp VALUES(4,'이몽룡', '기획팀장',2);
INSERT INTO emp VALUES(5,'성츈향', '홍보팀장',3);

SELECT employee_id, first_name, manager_id FROM employees;

/*
/* 함수 서브쿼리, 조인
내장함수의 종류 
1) 단일행 함수 : 레코드의 수 만큼 실행되는 함수
lower(), upper(), initcap(), length(), concat(), ||
substr(문자열, n), substr(문자열, n1, n2)
replace(문자열, 찾는 문자열, 바꾸는 문자열)

- 숫자 함수
  ceil() - 올림, floor()-버림, round()-반올림
*/
-- replace()
SELECT '010-1234-4567' as "전화번호", replace('010-1234-4567','-','/')as "수정된 전화번호"
FROM dual;

--숫자관련 함수
SELECT
    1234.5678,
    round(1234.5678,2),
    round(1234.5678,0),
    round(1234.5678,-1)
FROM dual;

SELECT
    1234.5678,
    ceil(1234.5678),
    floor(1234.5678)
FROM dual;

SELECT
    -1234.5678,
    round(-1234.5678,2),
    round(-1234.5678,-1),
    ceil(-1234.5678),
    floor(-1234.5678)
FROM dual;

-- lower(), upper(), initcap()
SELECT first_name,lower(first_name), upper(first_name), initcap(first_name)
FROM employees;

-- length(), concat(),
SELECT first_name, length(first_name), concat(first_name,'님')
FROM employees;

--substr() 오라클은 인덱스가 1부터 시작
SELECT SUBSTR('무궁화 꽃이피었습니다.',7)
FROM dual;

SELECT SUBSTR('무궁화 꽃이피었습니다.',5,1)
FROM dual;

-- substr을 이용해서 월에 해당하는 정보만 추출하시오.
SELECT sysdate, substr(sysdate, 4, 2)
FROM dual;

-- employees 테이블의 hire_date 컬럼에서 연도(substr)만 추출하시오.
SELECT hire_date, substr(hire_date, 1, 2)
FROM employees;

-- employees 테이블의 hire_date 컬럼에서 연도(substr, concat)만 추출하시오.
SELECT hire_date, concat(substr(hire_date, 1, 2),'년')
FROM employees;