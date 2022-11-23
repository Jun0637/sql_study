-- ������ : Like ������(Ư����ȣ%)
-- % :0~n���� ����
-- _ : 1���� ����

--[����] 'CLERK'�� ������ ����̸� 
select first_name, job_id
from employees
where job_id like '%CLERK'
order by job_id;

--[����] 'J'�� �����ϴ� ������ �̸��� ��ȸ�Ͻÿ�
select first_name
from employees
where first_name like 'J____';

--[����] 1���� �Ի��� ����� �̸�, �Ի���, ��ȭ��ȣ�� ��ȸ
select first_name, hire_date, phone_number
from employees
where hire_date like'__/01/__';

--[����] ��ȭ��ȣ�� 415�� �����ϴ� �������̸�, �Ի���, ��ȭ��ȣ�� ��ȸ�Ͻÿ�.
select first_name, hire_date, phone_number
from employees
where phone_number like'515%';

--DDL(Data Definiction Language) : Create, Alter, Drop
/*
create table ���̺��
(
    �÷��� ������Ÿ�� [constraint �������Ǹ�] �������ǵ�, 
    �÷��� ������Ÿ�� [constraint �������Ǹ�] �������ǵ�,
    �÷��� ������Ÿ�� [constraint �������Ǹ�] �������ǵ�
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

/** INSERT : ������ �����ϱ�
insert into ���̺��
(Ŀ����)
valuess
(������)
*/
--1
insert into customer
(usrid, age, usrname, height, weight, address)
values('aaa', 31,'ȫ�浿',171, 37.5,'����� ��������');

--2
insert into customer
(usrid, age, usrname, height, weight, address)
values('bbb', 32,'��浿',161, 47.5,'����� ���۱�');

--3
insert into customer
(usrid, usrname, age, address)
values('ccc','��浿', 33,'����� ���۱�');


select*from customer;

commit;

-- DELETE : ���ڵ� ����  0 ~ ���
delete from customer
where usrname is null;

--UPDATE : ���ڵ� ����
UPDATE customer
SET
    height = 177.7,
    weight = 77.7
WHERE usrid = 'ccc';


rollback;

--[����] members ���̺��� ������ �� inster,ipdate,delete,commit,rollback �����ϱ�
/*
seqno ���� pk
usrid �������ڿ� 30�ڸ�  unique, nn
usrname �������ڿ� 30�ڸ� nn
brith ��¥
joindate ��¥
gender �������� 1�ڸ�
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
(1,'aaa','ȫ�浿','91/11/16','22/12/23','m');

insert into members
values
(2,'bbb','��浿','92/1/12',sysdate,'f');

commit;

SELECT *FROM members;