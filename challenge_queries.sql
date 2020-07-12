-- -------------------------------------------------------------------------------
-- 									CHALLENGE 
-- -------------------------------------------------------------------------------

-- 1. Number of Retiring Employees by Title
--		A. table of number of titles retiring
--		B. table of number of employees with each title
--		C. table of current employees born between Jan. 1, 1952 and Dec. 31, 1955
--		D. New tables are exported as CSVs

-- 2. Mentorship Eligibility
--		A. table containing employees who are eligible for the mentorship program
--		B. submit your table and the CSV containing the data

-- 3. Techinal README File to showcase analysis and findings
---------------------------------------------------------------------------------

-- 1A. table of number of titles retiring

SELECT * FROM emp_info;

SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	ti.title,
	ti.from_date,
	ti.to_date,
	s.salary
INTO title_retiring
FROM current_emp as ce
INNER JOIN titles as ti
ON (ce.emp_no = ti.emp_no)
INNER JOIN salaries as s
ON (ce.emp_no = s.emp_no);

SELECT * FROM title_retiring;

-- table contains duplicates for employees since some of them were promoted in their career

SELECT 
	emp_no,
	first_name,
	last_name,
	to_date,
	title
INTO parititioned_titles
FROM (
	SELECT 
		emp_no, 
		first_name,
		last_name,
		to_date,
		title, ROW_NUMBER() OVER
 			(PARTITION BY (emp_no)
			ORDER BY to_date DESC) rn
 			FROM title_retiring
		) 
	tmp WHERE rn = 1
ORDER BY emp_no;

SELECT * FROM parititioned_titles;

-- 1B. table of number of employees with each title

SELECT COUNT(title), title
INTO total_titles
FROM parititioned_titles
GROUP BY title;

SELECT * FROM total_titles;

-- 1C. table of current employees born between Jan. 1, 1952 and Dec. 31, 1955

SELECT * FROM current_emp;

-- 2A. table containing employees who are eligible for the mentorship program

SELECT * FROM dept_emp;

SELECT 
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO eligible_mentors
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31');

SELECT * FROM eligible_mentors;

SELECT 
	emp_no,
	first_name,
	last_name,
	birth_date,
	from_date,
    to_date,
    title
INTO unique_mentors_list
FROM (
	SELECT 
		emp_no,
	    first_name,
	    last_name,
	    birth_date,
	    from_date,
        to_date,
        title, ROW_NUMBER() OVER
 			(PARTITION BY (emp_no)
			ORDER BY to_date DESC) rn
 			FROM eligible_mentors
		) 
	tmp WHERE rn = 1
ORDER BY emp_no;

SELECT * FROM unique_mentors_list;

-- -------------------------------------------------------------------------------
--							CHALLENGE END 
-- -------------------------------------------------------------------------------
