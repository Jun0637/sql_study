--����1) �����ȣ, �̸�, �Ի���, �޿�, ��ȸ�ϱ�
select employee_id, first_name, hire_date, salary
from employees;

--����2) �����ȣ, �̸� �޿� ��ȸ(�޿��� ��������)
select employee_id, first_name, salary from employees order by salary desc;

--����3) �̸�, ��ȭ��ȣ, �μ���ȣ�� ��ȸ(�̸��� ��������)
select first_name, phone_number, department_id from employees order by first_name asc;

-- ���ڿ� ���� ������ ||
select first_name || '�� �ȳ��ϼ���' as hello
from employees;

-- Ȭ����ǥ : ����Ŭ�� ���ڿ�
-- �����ǥ : ���ڿ� �ƴ�, Ư�������� ó����

select first_name, salary as "����޿�", salary*1.1 as "�λ�ȱ޿�" from employees;

-- �������� ���
--select [all/distinct]�÷��� from ���̺��
--where ������
--order by �÷��� [asc/desc]

--[����] �޿��� 10000�޷� �̻��� �������� �̸�, �޿�, �μ�, ������ ��ȸ�Ͻÿ�.
select first_name, salary, department_id, job_id
from employees
where salary>=10000;

--[����] �̸�, �μ�, �Ի����� ��ȸ�Ͻÿ�.
select first_name, department_id, hire_date from employees
where hire_date >='05/01/01'
order by hire_date;

--[����] 2005�� ������ �Ի��� ������ �̸�, �μ�, �Ի����� �̸������� ��ȸ�Ͻÿ�.
select first_name, department_id, hire_date from employees
where hire_date <= '05/01/01'
order by first_name;

--[����] �޿��� 5000~10000������ ������ �̸�, �μ�, �޿� �޿������� ��ȸ�Ͻÿ�.
select first_name, department_id, salary from employees
where salary >= 5000 and salary <= 10000
order by salary;

--[����] �μ���ȣ�� 50�̰ų� 80�� ������ �̸� �μ���ȣ, �μ������������� ��ȸ
select first_name, department_id from employees
where department_id = 50 or department_id = 80
order by department_id asc;

--[����] �μ���ȣ�� 50�̰ų� 80�� ������ �̸� �μ���ȣ, �μ������������� ��ȸ �̸��� �������� ��ȸ
select first_name, department_id from employees
where department_id = 50 or department_id = 80
order by department_id asc, first_name desc;

--[����] �޿��� 5000~10000������ ������ �̸�, �μ�, �޿� �޿������������� ��ȸ�Ͻÿ�.
-- �÷��� between �� and ��
select first_name, department_id, salary from employees
where salary between 5000 and 10000
order by salary desc;

--[����] �޿��� 5000~10000������ ������ �ƴ� ������ �̸�, �μ�, �޿� �޿������������� ��ȸ�Ͻÿ�.
-- �÷��� between �� and ��
select first_name, department_id, salary from employees
where salary not between 5000 and 10000
order by salary desc;

--[����] �μ���ȣ�� 50�̰ų� 80�� ������ �̸� �μ���ȣ, �μ������������� ��ȸ �̸��� �������� ��ȸ
-- �÷��� IN(��, ��)
select first_name, department_id from employees
where department_id in(50,80)
order by department_id asc, first_name desc;

--[����] �μ���ȣ�� 50�̰ų� 80�� �ƴ����� �̸� �μ���ȣ, �μ������������� ��ȸ �̸��� �������� ��ȸ
-- �÷��� NOT IN(��, ��)
select first_name, department_id from employees
where department_id not in(50,80)
order by department_id asc, first_name desc;

--[����] �̸�, �μ���ȣ, �޿�,Ŀ�̼Ǻ����� �̸���ȸ������ ��ȸ
select first_name, department_id, salary, commission_pct
from employees
order by first_name;

-- �÷��� IS NILL, �÷��� IS NOT NULL
--[����] �̸�, �μ���ȣ, �޿�, Ŀ�̼Ǻ����� �̸� ������ ��ȸ�ϵ� Ŀ�̼��� �ִ� ����� ��ȸ
select first_name, department_id, salary, commission_pct
from employees
where commission_pct is not null
order by first_name;

--[����] �����ڰ� ���� ����� ��ȸ(�̸�, ����, �μ���ȣ)
select  first_name, job_id, department_id
from employees
where manager_id is null;