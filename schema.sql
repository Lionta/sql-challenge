-- Drop table if exists
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS titles;

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
