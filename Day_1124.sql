/*
FK
    �θ����̺� + �ڽ���[�̺�
    
Sequence ��ü ���� �� ���
*/
 /*���� �����ϱ�*/
 DROP TABLE child_1;
 DROP TABLE parent_1;
 
-- �θ����̺� ����
CREATE TABLE parent_1
(
    seqno NUMBER PRIMARY KEY,
    usrname VARCHAR2(20) NOT NULL,
    phone VARCHAR2(10)
);
-- �ڽ��̺� ����
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
-- �θ����̺� ������ ����
INSERT INTO parent_1 VALUES(1, 'ȫ�浿','1111');
INSERT INTO parent_1 VALUES(2, '���Ȱ�','2222');
INSERT INTO parent_1 VALUES(3, '�����','3333');

-- �ڽ������̺� ������ ����
INSERT INTO child_1 VALUES(11, '921124','����', 1);
INSERT INTO child_1 VALUES(12, '931124','�λ�', 2);
INSERT INTO child_1 VALUES(13, '941124','��õ', 2);
INSERT INTO child_1 VALUES(14, '951124','����', 3);

SELECT * FROM parent_1;
SELECT * FROM child_1;
--
DELETE child_1
WHERE seqno = 2;

DELETE parent_1
WHERE seqno = 2;

-- ���ο� ���̺� �����ϱ�
CREATE TABLE parent_2
(
    seqnum NUMBER PRIMARY KEY,
    usrid VARCHAR2(20) UNIQUE NOT NULL,
    usrname VARCHAR2(20)NOT NULL,
    email VARCHAR2(30) UNIQUE NOT NULL
);

--�Ϸù�ȣ �߻��ϴ� ��ü �����ϱ�(SEQUENCE)
DROP SEQUENCE parent2_seq;
CREATE SEQUENCE parent2_seq; -- 1�κ��� �߻���Ű�� ������

CREATE TABLE child_2
(
    seqnum NUMBER PRIMARY KEY,
    jumin VARCHAR2(13) NOT NULL,
    address VARCHAR2(50),
    seqno NUMBER REFERENCES parent_1(seqno)
);
/*
parent2_seq.next_val : ���� ���� �߻���Ŵ
parent2_seq.curr_val : ���������� �߻���Ų �Ϸù�ȣ�� ���� �˰��� �� ��
*/

SELECT parent2_seq.nextval FROM dual; -- �������̺�(�������̺�
SELECT parent2_seq.currval FROM dual;

--parent_2 ���̺� sequence�� �̿��� �� �����ϱ�
INSERT INTO parent_2
(seqnum, usrid, usrname, email)
VALUES
(PARENT2_SEQ.nextval, 'aaa','ȫ�浿','aaa@naver.com');

INSERT INTO parent_2
(seqnum, usrid, usrname, email)
VALUES
(PARENT2_SEQ.nextval, 'bbb','�տ���','bbb@naver.com');

SELECT * FROM parent_2;

/*[����] score_2 ���̺��� �����Ͻÿ�.
seqno : ������ ��ȣ(������ ��ü �����ؼ� ����Ұ� score_2_seq)
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
--�ڱ� �ڽ��� �Î��� �����ϴ� ���̺� �����ϱ�
DROP TABLE emp;
CREATE TABLE emp
(
    empno NUMBER PRIMARY KEY,
    ename VARCHAR2(20)NOT NULL,
    jobtitle VARCHAR2(30),
    mgrno NUMBER REFERENCES emp(empno)
);



INSERT INTO emp VALUES(1,'ȫ�浿', '��ǥ�̻�', null);
INSERT INTO emp VALUES(2,'�տ���', '����', 1);
INSERT INTO emp VALUES(3,'�����', '��', 1);

INSERT INTO emp VALUES(4,'�̸���', '��ȹ����',2);
INSERT INTO emp VALUES(5,'������', 'ȫ������',3);

SELECT employee_id, first_name, manager_id FROM employees;

/*
/* �Լ� ��������, ����
�����Լ��� ���� 
1) ������ �Լ� : ���ڵ��� �� ��ŭ ����Ǵ� �Լ�
lower(), upper(), initcap(), length(), concat(), ||
substr(���ڿ�, n), substr(���ڿ�, n1, n2)
replace(���ڿ�, ã�� ���ڿ�, �ٲٴ� ���ڿ�)

- ���� �Լ�
  ceil() - �ø�, floor()-����, round()-�ݿø�
*/
-- replace()
SELECT '010-1234-4567' as "��ȭ��ȣ", replace('010-1234-4567','-','/')as "������ ��ȭ��ȣ"
FROM dual;

--���ڰ��� �Լ�
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
SELECT first_name, length(first_name), concat(first_name,'��')
FROM employees;

--substr() ����Ŭ�� �ε����� 1���� ����
SELECT SUBSTR('����ȭ �����Ǿ����ϴ�.',7)
FROM dual;

SELECT SUBSTR('����ȭ �����Ǿ����ϴ�.',5,1)
FROM dual;

-- substr�� �̿��ؼ� ���� �ش��ϴ� ������ �����Ͻÿ�.
SELECT sysdate, substr(sysdate, 4, 2)
FROM dual;

-- employees ���̺��� hire_date �÷����� ����(substr)�� �����Ͻÿ�.
SELECT hire_date, substr(hire_date, 1, 2)
FROM employees;

-- employees ���̺��� hire_date �÷����� ����(substr, concat)�� �����Ͻÿ�.
SELECT hire_date, concat(substr(hire_date, 1, 2),'��')
FROM employees;