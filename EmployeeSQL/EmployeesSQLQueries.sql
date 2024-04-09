
--1. List the employee number, last name, first name, sex, and salary of each employee.
select e.emp_no, e.first_name, e.last_name, e.sex, s.salary 
	from employees AS e
	left join salaries as s 
	on (e.emp_no=s.emp_no);

--2. List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date 
	from employees
	where hire_date between '1986-01-01' and '1986-12-31';
 

--3. List the manager of each department along with their department number, department name, 
--employee number, last name, and first name.
select dm.dept_no, d.dept_name, e.emp_no, e.first_name, e.last_name
	from dept_manager as dm
	inner join departments as d
	on (d.dept_no=dm.dept_no)
	inner join employees as e
	on (dm.emp_no=e.emp_no)
	order by e.emp_no;

--4. List the department number for each employee along with that employee’s employee number, 
--last name, first name, and department name.
select d.dept_no, e.emp_no, e.first_name, e.last_name, d.dept_name
	from employees as e
	inner join dept_emp as de
	on (e.emp_no=de.emp_no)
	inner join departments as d
	on (d.dept_no=de.dept_no)
	order by e.emp_no;
	

--5. List first name, last name, and sex of each employee whose first name is
--Hercules and whose last name begins with the letter B.
select first_name, last_name, sex
	from employees
	where first_name = 'Hercules'
	and last_name like 'B%';

--6. List each employee in the Sales department, including their employee number, last name, and first name.
select e.emp_no, e.first_name, e.last_name
	from employees as e
	inner join dept_emp as de
	on (e.emp_no=de.emp_no)
	inner join departments as d
	on (d.dept_no=de.dept_no)
	where d.dept_name = 'Sales'
	order by e.emp_no;

--7. List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
select e.emp_no, e.first_name, e.last_name
	from employees as e
	inner join dept_emp as de
	on (e.emp_no=de.emp_no)
	inner join departments as d
	on (d.dept_no=de.dept_no)
	where d.dept_name = 'Sales' or d.dept_name = 'Development'
	order by e.emp_no;


--8. List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name).
select last_name, count(last_name) as "Last Name Count"
	from employees
	group by last_name
	order by "Last Name Count" desc;


