CREATE TABLE titles (
	title_id varchar NOT NULL,
	title varchar NOT NULL,
	PRIMARY KEY (title_id)
);

CREATE TABLE departments (
	dept_no varchar  NOT NULL,
	dept_name varchar  NOT NULL,
	PRIMARY KEY (dept_no)
);

CREATE TABLE employees (
	emp_no int NOT NULL,
	emp_title_id varchar NOT NULL,
	birth_date varchar NOT NULL,
	first_name varchar NOT NULL,
	last_name varchar NOT NULL,
	sex varchar NOT NULL,
	hire_date varchar NOT NULL,
	PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

CREATE TABLE dept_emp (
	emp_no int NOT NULL,
	dept_no varchar NOT NULL,
    FOREIGN KEY(emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE dept_manager (
	dept_no varchar NOT NULL,
	emp_no int NOT NULL,
    FOREIGN KEY(emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE salaries (
	emp_no int NOT NULL,
	salary int NOT NULL,
    FOREIGN KEY(emp_no) REFERENCES employees (emp_no)
);

---1.List the employee number, last name, first name, sex, and salary of each employee.
Select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
From employees e
Join salaries s
On (e.emp_no = s.emp_no)
order by e.emp_no

---2. List first name, last name, and hire date for employees who were hired in 1986.
Select first_name, last_name, hire_date
From employees
Where EXTRACT(YEAR FROM hire_date) = 1986;

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
Select dm.dept_no, d.dept_name, dm.emp_no as manager_emp_no, e.first_name, e.last_name
From dept_manager dm
INNER JOIN departments d ON dm.dept_no = d.dept_no
INNER JOIN employees e ON dm.emp_no = e.emp_no;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
Select e.emp_no, e.last_name, e.first_name, d.dept_name
From employees e
LEFT JOIN dept_emp ON e.emp_no = dept_emp.emp_no
LEFT JOIN departments d ON dept_emp.dept_no = d.dept_no
order by e.emp_no;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
Select first_name, last_name
From employees
Where first_name = 'Hercules'
	and last_name like 'B%';
	
--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
Select e.emp_no, e.last_name, e.first_name, d.dept_name
From employees e
LEFT JOIN dept_emp ON e.emp_no = dept_emp.emp_no
LEFT JOIN departments d ON dept_emp.dept_no = d.dept_no
Where d.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
Select e.emp_no, e.last_name, e.first_name, d.dept_name
From employees e
LEFT JOIN dept_emp ON e.emp_no = dept_emp.emp_no
LEFT JOIN departments d ON dept_emp.dept_no = d.dept_no
Where d.dept_name = 'Sales'
	or d.dept_name = 'Development'
	
--8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.'
Select last_name, count(last_name) as the_frequency_count_last_names
From employees
Group By last_name
Order By the_frequency_count_last_names DESC;
	

