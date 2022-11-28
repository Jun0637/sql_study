--[����1]
select 
    d.department_name, i.city
From
     d.departments_name, locations i
 where
    d.location_id = l.location_id;

--[����2]
SELECT
    first_name, hire_date, department_id
FROM 
    employees
WHERE 
    FLOOR(MONTHS_BETWEEN(sysdate, hire_date)/12)>=15
ORDER BY 1;
/*
SELECT
    e.first_name,  e.hire_date, d.department_name,
    SUBSTR(sysdate, 1,2) - SUBSTR(hire_date, 1,2) as "�ټӿ���"
FROM
 employess e, departments d
 WHERE
 e.department_name */
--[����3]
SELECT
    e.first_name, e.hire_date, d.department_name
FROM
    employees e, departments d
WHERE
    e.department_id = d.department_id
AND UPPER(e.first_name)LIKE '%A%';

--[����4] 'Seattle'�� �ٹ��ϴ� ��� ������ �μ���ȣ, �̸�, ������(job_title), �μ����� ��ȸ�Ͻÿ�.
SELECT
    e.department_id, e.first_name, j.job_title, d.department_name
FROM
    employees e, departments d, jobs j, locations l
WHERE
    e.department_id = d.department_id
    AND
    e.job_id = j.job_id
    AND
    d.location_id = l.location_id
    AND
    l.city = 'Seattle'
ORDER BY first_name;

--Outer join : ������ ������ �ʿ� (+)��ȣ�� ���δ�. -> �θ��ʿ� (+)�⸦ ���δ�.
SELECT 
    e.first_name, e.salary, d.department_name
 FROM
    employees e, departments d
 WHERE 
    e.department_id = d.department_id(+);

-- �μ���� �Ŵ������� ��ȸ�Ͻÿ�.
SELECT
    d.department_name, m.manger_id
From
    employees , d.departments_name, m.manger_id
ORDER BY department_name;

-- self join : �ϳ��� ���̺� PK�� FK�� ��� �����ϴ� ��� ���
-- ������� �Ŵ������� ��ȸ�Ͻÿ�.
-- ��)XXX�� �Ŵ����� XXX�Դϴ�.
SELECT
    e1.first_name as "�Ŵ�����", e2.first_name as "������"
FROM
    employees e1, employees e2
WHERE
    e1.employee_id(+) = e2.manager_id
ORDER BY e1.first_name;

SELECT
    department_name, country_name, region_name
From
    employees
WHERE
    department_id = country_name
    AND
     country_name = region_name
ORDER BY 1l;

/*
SUB-QUERY
- �� �ȿ� �ٸ� ������ ���ԵǾ� �ִ� ��ɹ�

- ��������
  ��ȸ�� ���� ����� ������ �ִ� �ٱ��� ����
  ���������� ���� ����� ���� ���� ������ �����

- ��������(Sub Query)
  ���ʿ� ���Ե� ����
  ���������� ���� ����, �� ����� �������� �������̳� FROM ����� ����
  ���������� ������ ��� �κп��� ���Ǵ°�?
  where, from selectt, having, insert into, update set��
*/

SELECT first_name, salary
FROM
    employees
Where
    employee_id =162;

SELECT*
FROM
    employees
WHERE
 slalary = 100500
;

SELECT salary
FROM
    employees
WHERE
 employee_id = 162
;

--[��������] where���� ���Ե� �������� 162�� ������ �޴� �޿��� ������
SELECT*
FROM
    employees
WHERE
 salary = (SELECT salary
            FROM
            employees
            WHERE
            employee_id = 162);

--[����7] from���� ���Ե� ��������
--80�� ��ȣ�� �����ȣ �̸� �޿� �μ���ȣ ��ȸ

SELECT employee_id, first_name, salary, department_id
From employees
where
department_id=80;


SELECT employee_id, first_name, salary, department_id
From employees
where
department_id=80;

SELECT rownum, tbl.first_name,tbl.salary
FROM
    (SELECT
    employee_id ,first_name,salary, department_id
    FROM
    employees
    WHERE
    department_id=80)tbl
Where
tbl.salary>8000;

--[����] 'bruce'��� ������ ������ �μ��� �ٹ��ϴ� ������ ��ȸ�Ͻÿ�.
--         (������ : first_name, �μ���department_name)
SELECT e.first_name, d.department_name
FROM
employees e, departments d
WHERE
e.department_id = d.department_id
AND
e.department_id =
(SELECT department_id
From employees
where first_name = 'bruce');

--���� 30�� �μ��� �ٹ��ϴ� ��å�� ������ ��å���� �״��ϴ� ������ �ٸ� �μ����� �ִ��� Ȯ���Ͽ� ������ �˻��Ͻÿ�.
SELECT*
FROM
    employees
    WHERE job_id IN(
                    SELECT DISTINCT job_id
                    FROM employees
                    WHERE
                    department_id= 30);
                    
-- ȸ�� ��ü �޿� ��� 6461_XX���� ���� �޴� ������ ����� ��ȸ�Ͻÿ�.
SELECT*
FROM employees
WHERE
salary<(SELECT AVG(salary)
FROM employees);