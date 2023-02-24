-- Drop table if exists
DROP TABLE salaries;
DROP TABLE dept_manager;
DROP TABLE dept_emp;
DROP TABLE departments;
DROP TABLE employees;
DROP TABLE titles;

-- creating tables
CREATE TABLE titles(
	title_id VARCHAR(255) PRIMARY KEY NOT NULL,
	title VARCHAR(255)
);

CREATE TABLE employees(
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title VARCHAR(255) REFERENCES titles(title_id),
	birth_date DATE,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	sex VARCHAR(1),
	hire_date DATE
);

CREATE TABLE departments(
	dept_no VARCHAR(4) PRIMARY KEY,
	dept_name VARCHAR(255)
);

CREATE TABLE dept_emp(
	emp_no INT REFERENCES employees(emp_no),
	dept_no VARCHAR(4) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT REFERENCES employees(emp_no)
);

CREATE TABLE salaries(
	emp_no INT REFERENCES employees(emp_no),
	salary FLOAT	
);

--List the employee number, last name, first name, sex, and salary of each employee.

SELECT employees.emp_no as "Employee Number", employees.last_name as "Last Name", 
	employees.first_name as "First Name", employees.sex as "Sex", salaries.salary as "Salary" 
FROM employees 
JOIN salaries
USING(emp_no);

--List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name as "First Name", last_name as "Last Name", hire_date as "Hire Date"
FROM employees
WHERE hire_date BETWEEN to_date('1986-01-01', 'YYYY-MM-DD')
					AND to_date('1986-12-31', 'YYYY-MM-DD');

--List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT dept_manager.dept_no as "Department Number", departments.dept_name as "Department Name", employees.emp_no as "Employee Number", 
		employees.first_name as "First Name", employees.last_name as "Last Name" 
FROM dept_manager
JOIN departments
USING (dept_no)
JOIN employees
USING (emp_no);

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT dept_emp.dept_no as "Department Number", employees.emp_no as "Employee Number", employees.first_name as "First Name", 
	employees.last_name as "Last Name", departments.dept_name as "Department Name"
FROM dept_emp
JOIN departments
USING (dept_no)
JOIN employees
USING (emp_no);

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name as "First Name", last_name as "Last Name", sex as "Sex"
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT employees.emp_no as "Employee Number", employees.last_name as "Last Name", employees.first_name as "First Name"
FROM employees
JOIN dept_emp
USING (emp_no)
JOIN departments
USING (dept_no)
WHERE departments.dept_name = 'Sales'

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no as "Employee Number", employees.last_name as "Last Name", employees.first_name as "First Name", departments.dept_name as "Department Name"
FROM employees
JOIN dept_emp
USING (emp_no)
JOIN departments
USING (dept_no)
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development'



--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name