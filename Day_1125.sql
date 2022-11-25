/**
함수, 서브쿼리, 조인
내정함수의 종류
1) 단일행 함수
- 문자열 함수
- 숫자함수
- 날짜함수 : add_months(), month_between(),....
- 변환함수 : to_date(), to_number(), to_char()
*/

--오류: 변환함수를 통해서 날짜형태로 변환한 후 작업해야 한다.
select sysdate '9/11/25'
from dual;

select hire_date as "입사일"
from employees;

-- 입사일 이후 현재까지 총 근무일
SELECT first_name, ceil(sysdate - hire_date) as "총 근무일"
FROM employees
ORDER BY "총 근무일 " DESC;

-- ADD_MONTHS(날짜데이터, 정수)
SELECT
    sysdate, ADD_MONTHS(sysdate, 3),ADD_MONTHS(sysdate, -3)
FROM dual;

-- ADD_MONTHS(날짜데이터, 날짜데이터)
SELECT
    first_name, hire_date, FLOOR(MONTHS_BETWEEN(sysdate, hire_date))as "근무 개월"
FROM employees;

--[문제] 근속 년수 구하기
SELECT
    first_name, hire_date,
    ROUND(MONTHS_BETWEEN(sysdate, hire_date),1)as "근무 개월",
    CEIL(MONTHS_BETWEEN(sysdate, hire_date)/12)as "근무 년수"
FROM employees
ORDER BY "근무 년수";

-- 변수함수의 사용 : TO_DATE, TO_CHAR(),TO_NUMBER()
-- '91/12/25'
SELECT '91/12/25',TO_DATE('91/12/25')+1
FROM DUAL;

--[연습문제] 태ㅓ나서 오늘까지 몇일 경과했는지확인

--TO_CHAR(날짜 포맷) YYYY-MM-DD HH:MI:SS
SELECT sysdate, TO_CHAR(sysdate,'YYYY-MM-DD HH:MI:SS(DAY)')
FROM dual;

--TO_NUMBER('1234', CASF(데이터, 자료형)
SELECT TO_NUMBER('1234')+2, TO_NUMBER('1234.56')
FROM dual;

--[문제]20년 이상 근무한 직원의 명단을 조회
--      (사원번호, 이름, 입사일(YYYY-MM-DD), 근속연수(18년근무)
--      (입사일 기준으로 내림차순 정렬)
SELECT
    employee_id, first_name, hire_date,
    TO_CHAR(hire_date,'YYYY-MM-DD')as "근무 일수",
    FLOOR(MONTHS_BETWEEN(sysdate, hire_date)/12)as "근속년수"
FROM employees
WHERE FLOOR(MONTHS_BETWEEN(sysdate, hire_date)/12)>=20
ORDER BY "근속년수";

-- 그룹행함수 :
-- COUNT(컬럼명) : NULL 데이터는 카운트하지 않는다.
-- COUNT(*): 
SELECT*FROM departments;

SELECT COUNT(*),COUNT(department_name),COUNT(manager_id)
FROM departments;

-- [문제]임직원의 인원수를 세는 쿼리를 작성하시오.
SELECT COUNT(*) as "임직원"
FROM employees;

--[문제] 커미션을 수령하는 인원수를 세어보시오.
SELECT COUNT(commission_pct) as "수령자"
FROM employees;

--[문제] 커미션을 수령하는 하지 못하는 인원수를 세어보시오.
SELECT COUNT(*)-COUNT(commission_pct) as "수령하지 못하는인원"
FROM employees;

--[문제] 전체 임금의 합계, 임금의 평균, 최소 급여 수령액, 최대 급여 수령액, 최대급여 수령액과 최소 수령액의 급여차
--SUM(컬럼명) AVG, MIN, MAX 
SELECT
    SUM(salary),
    ROUND(AVG(salary),2),
    MIN(salary),
    MAX(salary),
    MAX(salary)-MIN(salary)
FROM employees;

-- 그룹화 시킨후 집계하기
-- GROUP BY, HAVING(그룹화된 데이터에 조건을 걸고자 할 때 사용)

--[문제] 7000 이하의 평균 급여를 받는 부서만 조회
SELECT
    department_id,
    SUM(salary),
    ROUND(AVG(salary),2)
FROM employees
GROUP BY department_id
HAVING ROUND(AVG(salary),2)<=7000
ORDER BY 1;

--[문제]각 부서별로 급여의 최대급여, 최소급여, 급여평균, 부서별 인원수를 조회하시오.
SELECT
    MIN(salary) as "최대급여",
    MAX(salary) as "최소급여",
    ROUND(AVG(salary),2) as "최대평균",
    COUNT(department_id)
FROM employees
GROUP BY department_id;

--[문제]80번 부서의 급여의 최대급여, 최소급여, 급여평균, 부서별 인원수를 조회하시오.
SELECT
    MIN(salary) as "최소급여",
    MAX(salary) as "최대급여",
    ROUND(AVG(salary),2) as "최대평균",
    COUNT(salary)
FROM employees
GROUP BY department_id
HAVING department_id = 80;

--[문제] 각 부서별 평균 월급, 전체월급, 최저월급을 구하여 평균 월급이 많은 순으로 조회.
-- 단 부서번호가 NULL이면 출력하지 않는다.
SELECT 
    department_id,
    ROUND(AVG(salary),2)as "부서별 임금 평균",
    SUM(salary) as "부서별 임금 합계",
    MIN(salary) as "부서별 최저임금"
FROM employees
GROUP BY department_id, salary
HAVING department_id IS NOT NULL
ORDER BY 2;

--[문제] 같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수 조회
SELECT job_id,count(*)
FROM employees
GROUP BY job_id
HAVING COUNT(job_id) >=4
ORDER BY 1;

-/* JOIN
- 둘이상의 테이블(관계를 가진 테이블) 들간의 데이터를 조회하는것
- pk, fk를 가진 컬럼이 있는 테이블들을 조회

**조인의 종류
- Cross Join ( = 카르테시안 조인) 
    m * n
- Equi Join
   PK == FK의 관계를 가진 데이터를 조인
   FK에 null이 있을 경우 전체 조회가 안될 수 있다.!!!
*/

-- JOIN
SELECT
    e.first_name, d.department_name
FROM
    employees e,departments d
WHERE
    d.department_id = e.department_id;