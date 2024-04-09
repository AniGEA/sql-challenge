# EmployeeSQL

This project analyzes Pewlett Hackard's employee data from the 1980s and 1990s. With only six CSV files, the goal is to design tables, import data into an SQL database, and conduct insightful data analysis to uncover valuable insights about Pewlett Hackard's workforce during this era.

# Entity Relationship Diagram

![ERD](https://github.com/AniGEA/sql-challenge/assets/158235055/812f10be-b2ca-498f-98c3-b67a6a0c82b1)





# Schema

CREATE TABLE "departments" (
    "dept_no" varchar(255)   NOT NULL,
    "dept_name" varchar(255)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(255)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(255)   NOT NULL,
    "emp_no" int   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(255)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(255)   NOT NULL,
    "last_name" varchar(255)   NOT NULL,
    "sex" varchar(255)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no","salary"
     )
);

CREATE TABLE "titles" (
    "title_id" varchar(255)   NOT NULL,
    "title" varchar(255)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");






# Queries 

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





## Instructions
This Challenge is divided into three parts: data modeling, data engineering, and data analysis.
Data Modeling
Inspect the CSV files, and then sketch an Entity Relationship Diagram of the tables. To create the sketch, feel free to use a tool like QuickDBD
Links to an external site.
.
## Data Engineering
1. Use the provided information to create a table schema for each of the six CSV files. Be sure to do the following:
* Remember to specify the data types, primary keys, foreign keys, and other constraints.
* For the primary keys, verify that the column is unique. Otherwise, create a composite key Links to an external site. , which takes two primary keys to uniquely identify a row.
* Be sure to create the tables in the correct order to handle the foreign keys.
2. Import each CSV file into its corresponding SQL table.

## Data Analysis
1. List the employee number, last name, first name, sex, and salary of each employee.
2. List the first name, last name, and hire date for the employees who were hired in 1986.
3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
6. List each employee in the Sales department, including their employee number, last name, and first name.
7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

