--문제1) 사원번호, 이름, 입사일, 급여, 조회하기
select employee_id, first_name, hire_date, salary
from employees;

--문제2) 사원번호, 이름 급여 조회(급여의 내림차순)
select employee_id, first_name, salary from employees order by salary desc;

--문제3) 이름, 전화번호, 부서번호를 조회(이름을 오름차순)
select first_name, phone_number, department_id from employees order by first_name asc;

-- 문자열 결합 연산자 ||
select first_name || '님 안녕하세요' as hello
from employees;

-- 홑따옴표 : 오라클의 문자열
-- 겹따옴표 : 문자열 아님, 특수데이터 처리용

select first_name, salary as "현재급여", salary*1.1 as "인상된급여" from employees;

-- 조건절의 사용
--select [all/distinct]컬럼명 from 테이블명
--where 조건절
--order by 컬럼명 [asc/desc]

--[문제] 급여가 10000달러 이상인 직원들의 이름, 급여, 부서, 직급을 조회하시오.
select first_name, salary, department_id, job_id
from employees
where salary>=10000;

--[문제] 이름, 부서, 입사일을 조회하시오.
select first_name, department_id, hire_date from employees
where hire_date >='05/01/01'
order by hire_date;

--[문제] 2005년 이전에 입사한 직원의 이름, 부서, 입사일을 이름순으로 조회하시오.
select first_name, department_id, hire_date from employees
where hire_date <= '05/01/01'
order by first_name;

--[문제] 급여가 5000~10000사이인 직원의 이름, 부서, 급여 급여순으로 조회하시오.
select first_name, department_id, salary from employees
where salary >= 5000 and salary <= 10000
order by salary;

--[문제] 부서번호가 50이거나 80인 직원의 이름 부서번호, 부서오름차순으로 조회
select first_name, department_id from employees
where department_id = 50 or department_id = 80
order by department_id asc;

--[문제] 부서번호가 50이거나 80인 직원의 이름 부서번호, 부서오름차순으로 조회 이름은 내림차순 조회
select first_name, department_id from employees
where department_id = 50 or department_id = 80
order by department_id asc, first_name desc;

--[문제] 급여가 5000~10000사이인 직원의 이름, 부서, 급여 급여내림차순으로 조회하시오.
-- 컬럼명 between 값 and 값
select first_name, department_id, salary from employees
where salary between 5000 and 10000
order by salary desc;

--[문제] 급여가 5000~10000사이의 조건이 아닌 직원의 이름, 부서, 급여 급여내림차순으로 조회하시오.
-- 컬럼명 between 값 and 값
select first_name, department_id, salary from employees
where salary not between 5000 and 10000
order by salary desc;

--[문제] 부서번호가 50이거나 80인 직원의 이름 부서번호, 부서오름차순으로 조회 이름은 내림차순 조회
-- 컬럼명 IN(값, 값)
select first_name, department_id from employees
where department_id in(50,80)
order by department_id asc, first_name desc;

--[문제] 부서번호가 50이거나 80이 아닌직원 이름 부서번호, 부서오름차순으로 조회 이름은 내림차순 조회
-- 컬럼명 NOT IN(값, 값)
select first_name, department_id from employees
where department_id not in(50,80)
order by department_id asc, first_name desc;

--[문제] 이름, 부서번호, 급여,커미션비율을 이름조회순으로 조회
select first_name, department_id, salary, commission_pct
from employees
order by first_name;

-- 컬럼명 IS NILL, 컬럼명 IS NOT NULL
--[문제] 이름, 부서번호, 급여, 커미션비율을 이름 순으로 조회하되 커미션이 있는 사람만 조회
select first_name, department_id, salary, commission_pct
from employees
where commission_pct is not null
order by first_name;

--[문제] 관리자가 없는 사람을 조회(이름, 직급, 부서번호)
select  first_name, job_id, department_id
from employees
where manager_id is null;