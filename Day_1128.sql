--[문제1]
select 
    d.department_name, i.city
From
     d.departments_name, locations i
 where
    d.location_id = l.location_id;

--[문제2]
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
    SUBSTR(sysdate, 1,2) - SUBSTR(hire_date, 1,2) as "근속연수"
FROM
 employess e, departments d
 WHERE
 e.department_name */
--[문제3]
SELECT
    e.first_name, e.hire_date, d.department_name
FROM
    employees e, departments d
WHERE
    e.department_id = d.department_id
AND UPPER(e.first_name)LIKE '%A%';

--[문제4] 'Seattle'에 근무하는 모든 직원의 부서번호, 이름, 업무명(job_title), 부서명을 조회하시오.
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

--Outer join : 정보가 부족한 쪽에 (+)기호를 붙인다. -> 부모쪽에 (+)기를 붙인다.
SELECT 
    e.first_name, e.salary, d.department_name
 FROM
    employees e, departments d
 WHERE 
    e.department_id = d.department_id(+);

-- 부서명과 매니저명을 조회하시오.
SELECT
    d.department_name, m.manger_id
From
    employees , d.departments_name, m.manger_id
ORDER BY department_name;

-- self join : 하나의 테이블에 PK와 FK가 모두 존재하는 경우 사용
-- 직원명과 매니저명을 조회하시오.
-- 예)XXX의 매니저는 XXX입니다.
SELECT
    e1.first_name as "매니저명", e2.first_name as "직원명"
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
- 쿠리 안에 다른 쿼리가 포함되어 있는 명령문

- 메인쿼리
  조회에 대한 결과를 가지고 있는 바깥쪽 쿼리
  서브쿼리의 실행 결과에 의해 메인 쿼리가 실행됨

- 서브쿼리(Sub Query)
  안쪽에 포함된 쿼리
  서브쿼리가 먼저 실행, 그 결과를 메인쿼리 조건절이나 FROM 절등에서 사용됨
  서브쿼리가 메인의 어느 부분에서 사용되는가?
  where, from selectt, having, insert into, update set절
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

--[연습문제] where절에 포함된 서브쿼리 162번 직원이 받는 급영의 동일한
SELECT*
FROM
    employees
WHERE
 salary = (SELECT salary
            FROM
            employees
            WHERE
            employee_id = 162);

--[문제7] from절에 포함된 서브쿼리
--80번 번호의 사원번호 이름 급여 부서번호 조회

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

--[문제] 'bruce'라는 직원과 동일한 부서에 근무하는 직원을 조회하시오.
--         (직원명 : first_name, 부서명department_name)
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

--문제 30번 부서에 근무하는 직책과 동일한 직책으로 그누하는 직원이 다른 부서에도 있는지 확이하여 직원을 검색하시오.
SELECT*
FROM
    employees
    WHERE job_id IN(
                    SELECT DISTINCT job_id
                    FROM employees
                    WHERE
                    department_id= 30);
                    
-- 회사 전체 급여 평균 6461_XX보다 적게 받는 직원의 명단을 조회하시오.
SELECT*
FROM employees
WHERE
salary<(SELECT AVG(salary)
FROM employees);