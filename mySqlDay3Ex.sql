select COUNT(employees.emp_no) from employees


select count(emp_no)
from employees
where employees.first_name = "Marc" and employees.last_name like 'A%';

/*How many employees with the first name "Eric" and the last name beginning with "A" do we have in our company?*/
select */*Stern bringt ganze Zeile*/
from employees
where employees.first_name = "Eric" and employees.last_name like 'A%';

select employees.first_name, employees.last_name
from employees
where employees.first_name = "Eric" and employees.last_name like 'A%';

/* How many employees do we have that are working for us since 1985 and who are they?*/
select *
from employees
where employees.hire_date >= "1985-01-01";

/* How many employees got hired from 1990 until 1997 and who are they?*/
select *
from employees
where employees.hire_date >= "1990-01-01" and employees.hire_date <='1997-12-31';

select employees.first_name/*alle Vornamen im Zeitraum von bis*/
from employees
where employees.hire_date >= "1990-01-01" and employees.hire_date <='1997-12-31';

/* How many employees have salaries higher than EUR 70 000,00 and who are they? */
SELECT DISTINCT employees.emp_no, first_name, last_name from employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no WHERE salaries.salary > 70000;

/*How many employees do we have in the Research Department, who are working for us since 1992 and who are they?*/
select * from employees
inner join dept_emp on dept_emp.emp_no = employees.emp_no
inner join departments on departments.dept_no = dept_emp.dept_no
where departments.dept_name = "Research"
and employees.hire_date >= "1992-01-01";

/* How many employees do we have in the Finance Department, who are working for
 us since 1985 until now and who have salaries higher than EUR 75 000,00 - who are they?*/
SELECT * 
from salaries
inner join employees on employees.emp_no = salaries.emp_no
inner join dept_emp on dept_emp.emp_no = employees.emp_no
inner join departments on departments.dept_no = dept_emp.dept_no
where departments.dept_name = "Finance"
and employees.hire_date >= "1985-01-01"
and salaries.salary > 75000
group by employees.emp_no


/*We need a table with employees, who are working for us at this moment:
 first and last name, date of birth, gender, hire_date, title and salary.*/

select employees.*, salaries.salary, titles.title, titles.to_date as rightworking
from salaries
inner join employees on employees.emp_no = salaries.emp_no
inner join titles on titles.emp_no = employees.emp_no
where titles.to_date = "9999-01-01" 
group by employees.emp_no

/*We need a table with managers, who are working for us at this moment: first and last name, date of birth,
 gender, hire_date, title, department name and salary.*/

SELECT employees.*, salaries.salary, titles.title, titles.to_date AS rightworking
FROM salaries
INNER JOIN employees ON employees.emp_no = salaries.emp_no
INNER JOIN titles on titles.emp_no = employees.emp_no
WHERE titles.to_date = "9999-01-01"
AND titles.title = "manager"
GROUP BY employees.emp_no

/* 1. Report:
 How many rows do we have in each table in the employees database?*/
SELECT COUNT(*) FROM employees;
or
SELECT table_name, table_rows
   FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_SCHEMA = 'employees';
/*2. Report:
How many employees with the first name "Mark" do we have in our company?*/
SELECT COUNT(first_name) FROM employees WHERE employees.first_name = "Mark";
/*3. Report:
How many employees with the first name "Eric" and the last name beginning with "A" do we have in our company?*/
SELECT COUNT(first_name),(last_name) FROM employees WHERE employees.first_name = "Eric" AND employees.last_name LIKE "A%";
 /*4. Report:
 How many employees do we have that are working for us since 1985 and who are they?*/
SELECT COUNT(hire_date) FROM employees WHERE employees.hire_date > "1985-01-01";
SELECT first_name,last_name,hire_date FROM employees WHERE employees.hire_date > "1985-01-01" 
/*5. Report:
 How many employees got hired from 1990 until 1997 and who are they?*/
SELECT COUNT(hire_date) FROM employees WHERE employees.hire_date BETWEEN "1990-01-01" AND "1997-12-31"; 
SELECT first_name,last_name,hire_date FROM employees WHERE employees.hire_date BETWEEN "1990-01-01" AND "1997-12-31"; 
 /*6. Report:
 How many employees have salaries higher than EUR 70 000,00 and who are they? */
SELECT COUNT(salary) FROM salaries WHERE salaries.salary > "70000";
SELECT employees.first_name, employees.last_name, salaries.salary 
FROM employees 
INNER JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE salaries.salary>"70000";
 /*7. Report:
 How many employees do we have in the Research Department, who are working for us since 1992 and who are they?*/
SELECT employees.first_name,employees.last_name,employees.hire_date,departments.dept_name 
FROM employees
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE employees.hire_date > "1992-01-01" AND departments.dept_no="d008" AND dept_emp.to_date > CURRENT_DATE()
ORDER BY employees.hire_date ASC; 
 /*8. Report:
 How many employees do we have in the Finance Department, who are working for us since 1985 until now and who have salaries higher than EUR 75 000,00 - who are they?*/
SELECT employees.emp_no,employees.first_name,employees.last_name,employees.hire_date,departments.dept_name,salaries.salary
FROM employees
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
INNER JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE employees.hire_date > "1985-01-01" AND departments.dept_no="d002" AND salaries.salary > "75000"
group by employees.emp_no
 /*9. Report:
 We need a table with employees, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title and salary.*/
SELECT employees.emp_no,employees.first_name,employees.last_name,employees.birth_date,employees.gender,employees.hire_date,titles.title,salaries.salary
FROM employees
INNER JOIN titles ON titles.emp_no = employees.emp_no
INNER JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE salaries.to_date > CURRENT_DATE()
group by employees.emp_no
 /*10. Report:
 We need a table with managers, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title, department name and salary.*/
SELECT employees.emp_no,employees.first_name,employees.last_name,employees.birth_date,employees.gender,employees.hire_date,titles.title,departments.dept_name,salaries.salary
FROM employees
INNER JOIN titles ON titles.emp_no = employees.emp_no
INNER JOIN salaries ON salaries.emp_no = employees.emp_no
INNER JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE salaries.to_date > CURRENT_DATE()
AND dept_manager.to_date > CURRENT_DATE()
group by employees.emp_no
/*Bonus query:
  Create a query which will join all tables and show all data from all tables.
 */
SELECT *
FROM employees
INNER JOIN titles ON titles.emp_no = employees.emp_no
INNER JOIN salaries ON salaries.emp_no = employees.emp_no
INNER JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
INNER JOIN dept_manager ON dept_manager.dept_no = departments.dept_no
group by employees.emp_no

