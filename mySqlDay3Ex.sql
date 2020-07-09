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