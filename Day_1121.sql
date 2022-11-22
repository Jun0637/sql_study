-- 2022년 11월 21일(월)
-- 1) 조회(select) : 
-- select 컬럼명 form 테이블이름 : 

select * from regions;
select * from countries;
select * from locations;
select * from departments;
select * from employees;
select * from jobs;
select * from job_history;

-- 이름을 조회
select FIRST_name, LAST_name
from employees;

-- 이름(first_name), 급여(salary)
select first_name, salary
from employees;

-- 사원번호(employee_id), 이름(first_name), 급여(salary), 부서번호(department_id)
select employee_id, first_name, salary, department_id
from employees;

-- 이름, 부서번호, 입사일을 조회하시오.
select first_name, department_id,hire_date
from employees;

-- 부서번호만 조회하시오.(distinct/all)
select distinct department_id
from employees;

-- 정렬 : ORDER BY 컬럼명(문장 마지막에 사용)(asc = 오름차순/desc = 내림차순)
select distinct department_id
from employees order by department_id desc;