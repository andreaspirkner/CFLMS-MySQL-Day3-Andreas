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

