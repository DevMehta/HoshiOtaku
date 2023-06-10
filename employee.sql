CREATE TABLE employee (
	emp_no      int  NOT NULL,
	birth_date  DATE NOT NULL,
	first_name  VARCHAR(50) NOT NULL,
	last_name   VARCHAR(50) NOT NULL,
	gender      VARCHAR(5) CHECK (gender IN('M', 'F')) NOT NULL,
	hire_date   DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE department (
	dept_no     VARCHAR(50) NOT NULL,
	dept_name   VARCHAR(50) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE      (dept_name)
);

CREATE TABLE dept_manager (
	emp_no      INT NOT NULL,
	dept_no     VARCHAR(50) NOT NULL,
	from_date   DATE NOT NULL,
	to_date     DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employee (emp_no) ON DELETE CASCADE,
	FOREIGN KEY (dept_no) REFERENCES department (dept_no) ON DELETE CASCADE,
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_emp (
	emp_no      INT NOT NULL,
	dept_no     VARCHAR(50) NOT NULL,
	from_date   DATE NOT NULL,
	to_date     DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employee (emp_no) ON DELETE CASCADE,
	FOREIGN KEY (dept_no) REFERENCES department (dept_no) ON DELETE CASCADE,
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE title (
	emp_no      INT NOT NULL,
	title       VARCHAR(50) NOT NULL,
	from_date   DATE NOT NULL,
	to_date     DATE,
	FOREIGN KEY (emp_no) REFERENCES employee (emp_no) ON DELETE CASCADE,
	PRIMARY KEY (emp_no, title, from_date)
); 

CREATE TABLE salary (
	emp_no      INT NOT NULL,
	amount      INT NOT NULL,
	from_date   DATE NOT NULL,
	to_date     DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employee (emp_no) ON DELETE CASCADE,
	PRIMARY KEY (emp_no, from_date)
);

--CREATE OR REPLACE VIEW dept_emp_latest_date AS
--SELECT
--	emp_no,
--	MAX(
--		from_date) AS from_date,
--	MAX(
--		to_date) AS to_date
--FROM
--	dept_emp
--GROUP BY
--	emp_no;

---- shows only the current department for each employee
--CREATE OR REPLACE VIEW current_dept_emp AS
--SELECT
--	l.emp_no,
--	dept_no,
--	l.from_date,
--	l.to_date
--FROM
--	dept_emp d
--	INNER JOIN dept_emp_latest_date l ON d.emp_no = l.emp_no
--		AND d.from_date = l.from_date
--		AND l.to_date = d.to_date;
