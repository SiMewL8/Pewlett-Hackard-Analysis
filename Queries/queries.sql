-- practice narrowing down employees
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';


-- Retirement eligibility born in 1952-55 from hire date in 1985-88
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- counting the number of employees retiring using 'count'
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- saving a list of retiring employees using 'into'
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- making sure retirement info is added onto the list of tables
SELECT * FROM retirement_info;

-- dropping retirement table to be recreated with employees/depts with retire info
DROP TABLE retirement_info;

-- new retire table contains emp #
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

--joining departments and dept_manager tables
SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments --table 1
INNER JOIN dept_manager --joins with table 2
ON departments.dept_no = dept_manager.dept_no;

--joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- joining departments and dept_manager tables with aliases 
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

--joining retirement_info and dept_emp tables with aliases into current_emp csv
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- current_emp lists
	-- employees born 1952-55 and hired 1985-88 from retirement info
	-- current employees from dept_emp
	
SELECT * FROM current_emp;

-- counting the amount of employees in current_emp
SELECT COUNT (to_date) FROM current_emp;

-- employee numbers counted and grouped by department number using group by
SELECT COUNT(ce.emp_no), de.dept_no
INTO retiring_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
--de-randomizing the groupe by using order by
ORDER BY de.dept_no;

SELECT * FROM retiring_by_dept;

SELECT * FROM salaries
ORDER BY to_date DESC;

-- --creating emp_info
-- SELECT emp_no,
-- 	first_name,
-- 	last_name,
-- 	gender
-- INTO emp_info
-- FROM employees
-- WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- SELECT * FROM emp_info;

DROP TABLE emp_info;

-- creating emp_info with employee columns and salaries for retiring emps
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

SELECT * FROM emp_info;

-- listing managers from each dept, with name, #, man #, last/first name, from-to dates
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name, 
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager as dm
	INNER JOIN departments as d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp as ce
		ON (dm.emp_no = ce.emp_no);

SELECT * FROM manager_info;

-- updating current_emp with dept_name
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no);

SELECT * FROM dept_info;

--finding sales retirees from dept_info using where
SELECT * FROM dept_info
WHERE dept_name ='Sales';

--finding sales and developemtn retirees from dept_info using 'where' and 'or'
SELECT * FROM dept_info
WHERE dept_name ='Sales'
OR dept_name = 'Development';

--finding sales and developemtn retirees from dept_info using 'where' and 'in'
--efficient then using 'or', avoid using multiple 'or'
SELECT * FROM dept_info
WHERE dept_name IN ('Sales', 'Development');