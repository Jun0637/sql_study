-- 연산자 : Like 연산자(특수기호%)
-- % :0~n개의 글자
-- _ : 1개의 글자

--[문제] 'CLERK'로 직급의 사원이름 
select first_name, job_id
from employees
where job_id like '%CLERK'
order by job_id;

--[문제] 'J'로 시작하는 직원의 이름을 조회하시오
select first_name
from employees
where first_name like 'J____';

--[문제] 1월에 입사한 사람의 이름, 입사일, 전화번호를 조회
select first_name, hire_date, phone_number
from employees
where hire_date like'__/01/__';

--[문제] 전화번호가 415로 시작하는 직원의이름, 입사일, 전화번호를 조회하시오.
select first_name, hire_date, phone_number
from employees
where phone_number like'515%';

--DDL(Data Definiction Language) : Create, Alter, Drop
/*
create table 테이블명
(
    컬럼명 데이터타입 [constraint 제약조건명] 제약조건들, 
    컬럼명 데이터타입 [constraint 제약조건명] 제약조건들,
    컬럼명 데이터타입 [constraint 제약조건명] 제약조건들
);
*/
create table customer
(
    usrid char(5) constraint customer_usrid_pk PRIMARY key,
    age number(3)not null,
    usrname varchar2(20),
    height number(10,2) default 0,
    weight number(10,2) default 0,
    address varchar2(100)
);

drop table customer;

select*from customer;

/** INSERT : 테이터 사입하기
insert into 테이블명
(커려명)
valuess
(데이터)
*/
--1
insert into customer
(usrid, age, usrname, height, weight, address)
values('aaa', 31,'홍길동',171, 37.5,'서울시 영동포구');

--2
insert into customer
(usrid, age, usrname, height, weight, address)
values('bbb', 32,'고길동',161, 47.5,'서울시 동작구');

--3
insert into customer
(usrid, usrname, age, address)
values('ccc','페길동', 33,'서울시 동작구');


select*from customer;

commit;

-- DELETE : 레코드 삭제  0 ~ 모두
delete from customer
where usrname is null;

--UPDATE : 레코드 수정
UPDATE customer
SET
    height = 177.7,
    weight = 77.7
WHERE usrid = 'ccc';


rollback;

--[문제] members 테이블을 생성한 후 inster,ipdate,delete,commit,rollback 연습하기
/*
seqno 정수 pk
usrid 가변문자열 30자리  unique, nn
usrname 가변문자열 30자리 nn
brith 날짜
joindate 날짜
gender 고정길이 1자리
*/
create table members
(
    seqno number constraint members_seqno_pk PRIMARY key,
    usrid char(30) constraint members_id_uqnn unique not null,
    usrname varchar2(30) constraint members_usrname_nn unique not null,
    birth date,
    joindate date default sysdate,
    gender varchar2(1) constraint members_gender_ck check(gender in('m','f'))
    );

insert into members
values
(1,'aaa','홍길동','91/11/16','22/12/23','m');

insert into members
values
(2,'bbb','고길동','92/1/12',sysdate,'f');

commit;

SELECT *FROM members;