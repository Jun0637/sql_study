/**
�Լ�, ��������, ����
�����Լ��� ����
1) ������ �Լ�
- ���ڿ� �Լ�
- �����Լ�
- ��¥�Լ� : add_months(), month_between(),....
- ��ȯ�Լ� : to_date(), to_number(), to_char()
*/

--����: ��ȯ�Լ��� ���ؼ� ��¥���·� ��ȯ�� �� �۾��ؾ� �Ѵ�.
select sysdate '9/11/25'
from dual;

select hire_date as "�Ի���"
from employees;

-- �Ի��� ���� ������� �� �ٹ���
SELECT first_name, ceil(sysdate - hire_date) as "�� �ٹ���"
FROM employees
ORDER BY "�� �ٹ��� " DESC;

-- ADD_MONTHS(��¥������, ����)
SELECT
    sysdate, ADD_MONTHS(sysdate, 3),ADD_MONTHS(sysdate, -3)
FROM dual;

-- ADD_MONTHS(��¥������, ��¥������)
SELECT
    first_name, hire_date, FLOOR(MONTHS_BETWEEN(sysdate, hire_date))as "�ٹ� ����"
FROM employees;

--[����] �ټ� ��� ���ϱ�
SELECT
    first_name, hire_date,
    ROUND(MONTHS_BETWEEN(sysdate, hire_date),1)as "�ٹ� ����",
    CEIL(MONTHS_BETWEEN(sysdate, hire_date)/12)as "�ٹ� ���"
FROM employees
ORDER BY "�ٹ� ���";

-- �����Լ��� ��� : TO_DATE, TO_CHAR(),TO_NUMBER()
-- '91/12/25'
SELECT '91/12/25',TO_DATE('91/12/25')+1
FROM DUAL;

--[��������] �¤ó��� ���ñ��� ���� ����ߴ���Ȯ��

--TO_CHAR(��¥ ����) YYYY-MM-DD HH:MI:SS
SELECT sysdate, TO_CHAR(sysdate,'YYYY-MM-DD HH:MI:SS(DAY)')
FROM dual;

--TO_NUMBER('1234', CASF(������, �ڷ���)
SELECT TO_NUMBER('1234')+2, TO_NUMBER('1234.56')
FROM dual;

--[����]20�� �̻� �ٹ��� ������ ����� ��ȸ
--      (�����ȣ, �̸�, �Ի���(YYYY-MM-DD), �ټӿ���(18��ٹ�)
--      (�Ի��� �������� �������� ����)
SELECT
    employee_id, first_name, hire_date,
    TO_CHAR(hire_date,'YYYY-MM-DD')as "�ٹ� �ϼ�",
    FLOOR(MONTHS_BETWEEN(sysdate, hire_date)/12)as "�ټӳ��"
FROM employees
WHERE FLOOR(MONTHS_BETWEEN(sysdate, hire_date)/12)>=20
ORDER BY "�ټӳ��";

-- �׷����Լ� :
-- COUNT(�÷���) : NULL �����ʹ� ī��Ʈ���� �ʴ´�.
-- COUNT(*): 
SELECT*FROM departments;

SELECT COUNT(*),COUNT(department_name),COUNT(manager_id)
FROM departments;

-- [����]�������� �ο����� ���� ������ �ۼ��Ͻÿ�.
SELECT COUNT(*) as "������"
FROM employees;

--[����] Ŀ�̼��� �����ϴ� �ο����� ����ÿ�.
SELECT COUNT(commission_pct) as "������"
FROM employees;

--[����] Ŀ�̼��� �����ϴ� ���� ���ϴ� �ο����� ����ÿ�.
SELECT COUNT(*)-COUNT(commission_pct) as "�������� ���ϴ��ο�"
FROM employees;

--[����] ��ü �ӱ��� �հ�, �ӱ��� ���, �ּ� �޿� ���ɾ�, �ִ� �޿� ���ɾ�, �ִ�޿� ���ɾװ� �ּ� ���ɾ��� �޿���
--SUM(�÷���) AVG, MIN, MAX 
SELECT
    SUM(salary),
    ROUND(AVG(salary),2),
    MIN(salary),
    MAX(salary),
    MAX(salary)-MIN(salary)
FROM employees;

-- �׷�ȭ ��Ų�� �����ϱ�
-- GROUP BY, HAVING(�׷�ȭ�� �����Ϳ� ������ �ɰ��� �� �� ���)

--[����] 7000 ������ ��� �޿��� �޴� �μ��� ��ȸ
SELECT
    department_id,
    SUM(salary),
    ROUND(AVG(salary),2)
FROM employees
GROUP BY department_id
HAVING ROUND(AVG(salary),2)<=7000
ORDER BY 1;

--[����]�� �μ����� �޿��� �ִ�޿�, �ּұ޿�, �޿����, �μ��� �ο����� ��ȸ�Ͻÿ�.
SELECT
    MIN(salary) as "�ִ�޿�",
    MAX(salary) as "�ּұ޿�",
    ROUND(AVG(salary),2) as "�ִ����",
    COUNT(department_id)
FROM employees
GROUP BY department_id;

--[����]80�� �μ��� �޿��� �ִ�޿�, �ּұ޿�, �޿����, �μ��� �ο����� ��ȸ�Ͻÿ�.
SELECT
    MIN(salary) as "�ּұ޿�",
    MAX(salary) as "�ִ�޿�",
    ROUND(AVG(salary),2) as "�ִ����",
    COUNT(salary)
FROM employees
GROUP BY department_id
HAVING department_id = 80;

--[����] �� �μ��� ��� ����, ��ü����, ���������� ���Ͽ� ��� ������ ���� ������ ��ȸ.
-- �� �μ���ȣ�� NULL�̸� ������� �ʴ´�.
SELECT 
    department_id,
    ROUND(AVG(salary),2)as "�μ��� �ӱ� ���",
    SUM(salary) as "�μ��� �ӱ� �հ�",
    MIN(salary) as "�μ��� �����ӱ�"
FROM employees
GROUP BY department_id, salary
HAVING department_id IS NOT NULL
ORDER BY 2;

--[����] ���� ������ �ϴ� ����� ���� 4�� �̻��� ������ �ο��� ��ȸ
SELECT job_id,count(*)
FROM employees
GROUP BY job_id
HAVING COUNT(job_id) >=4
ORDER BY 1;

-/* JOIN
- ���̻��� ���̺�(���踦 ���� ���̺�) �鰣�� �����͸� ��ȸ�ϴ°�
- pk, fk�� ���� �÷��� �ִ� ���̺���� ��ȸ

**������ ����
- Cross Join ( = ī���׽þ� ����) 
    m * n
- Equi Join
   PK == FK�� ���踦 ���� �����͸� ����
   FK�� null�� ���� ��� ��ü ��ȸ�� �ȵ� �� �ִ�.!!!
*/

-- JOIN
SELECT
    e.first_name, d.department_name
FROM
    employees e,departments d
WHERE
    d.department_id = e.department_id;