-- Create a Retirement Titles table for employees who are born between January 1, 1952 
-- and December 31, 1955
SELECT
	e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title, 
	t.from_date, 
	t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles as t
	ON (t.emp_no = e.emp_no)
WHERE 
	(birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
	AND (t.to_date = '9999-01-01')
ORDER BY emp_no

-- Create a Unique Titles table that contains the employee number, first and last name, 
-- and most recent title
SELECT 
	DISTINCT ON (rt.emp_no) 
	rt.emp_no, 
	rt.first_name, 
	rt.last_name, 
	t.title
INTO unique_titles
FROM retirement_titles AS rt
INNER JOIN titles AS t
	ON (t.emp_no = rt.emp_no)
ORDER BY rt.emp_no, t.from_date DESC

-- Create a Retiring Titles table that contains the number of titles filled by employees 
-- who are retiring.
SELECT
	COUNT(title), 
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC

-- Create a Mentorship Eligibility table for current employees who were born between 
-- January 1, 1965 and December 31, 1965
SELECT
	DISTINCT ON (e.emp_no) 
	e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date, 
	de.from_date, 
	de.to_date, 
	t.title 
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
	ON (de.emp_no = e.emp_no)
INNER JOIN titles AS t
	ON (t.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (t.to_date = '9999-01-01')
ORDER BY e.emp_no, t.from_date DESC