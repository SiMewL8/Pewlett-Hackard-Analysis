-- Creating tables for PH-EmployeesDB
CREATE TABLE departments (  -- table name
	dept_no VARCHAR(4) not null, -- coloumn name with data type, number of characters, required fields  
	dept_name VARCHAR(40) not null,
	PRIMARY KEY (dept_no), -- assigning primary key
	UNIQUE (dept_name) -- constrains to unique data values, no duplicates when updated, else data is dirty
); 
-- preserving data integrity
-- 		capslock to preserve differentiations between value, coloumn names vs commands and parameters
-- 		running the code again results in error since we sql data is persistent and cant be overwritten
-- 			in order to run it again, specify with a delete code
-- 		to run a specific code, highlight and run it

SELECT * FROM departments;

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hired_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

SELECT * FROM employees;

CREATE TABLE dept_manager ( 
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

SELECT * FROM dept_manager;

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

SELECT * FROM salaries;
	
CREATE TABLE titles (
	emp_no INT NOT NULL,
	title INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

SELECT * FROM titles;

CREATE TABLE dept_employees (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (dept_no, emp_no)
);

SELECT * FROM dept_employees;