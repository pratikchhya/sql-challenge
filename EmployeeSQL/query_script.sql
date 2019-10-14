CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "gender" varchar(10)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "emp_no" int   NOT NULL,
    "title" varchar(30)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" money   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "Departments" (
    "dept_no" varchar(30)   NOT NULL,
    "dept_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(30)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(30)   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- List the following details of each employee: employee number, last name, first name, gender, and salary.
 select emp.emp_no
 ,emp.last_name
 ,emp.first_name
 ,emp.gender
 ,sal.salary
 from employees emp
 inner join 
 salaries sal
 on emp.emp_no=sal.emp_no 
 ;
 
 --List employees who were hired in 1986.
select emp.emp_no
 ,emp.last_name
 ,emp.first_name
 ,emp.gender
 ,emp.hire_date
 from employees emp 
 where extract(year from hire_date)=1986
 ;
  
--List the manager of each department with the following information: department number, department name, the manager's 
--employee number, last name, first name, and start and end employment dates.
select dept.dept_no
,dept.dept_name
,mang.from_date
,mang.to_date
,emp.emp_no
,emp.last_name
,emp.first_name
 from "Departments" dept
 inner join
 dept_manager mang
 on dept.dept_no=mang.dept_no
 inner join
 employees emp
 on mang.emp_no=emp.emp_no
 ;
 
 --List the department of each employee with the following information: employee number, last name, first name, and department name.
select emp.emp_no
,emp.last_name
,emp.first_name
--,dept.dept_no
,dept.dept_name
 from employees emp 
 inner join
 dept_emp
 on dept_emp.emp_no=emp.emp_no
 inner join
 "Departments" dept 
 on dept_emp.dept_no=dept.dept_no
 ;
 
 -- List all employees whose first name is "Hercules" and last names begin with "B."
select first_name
,last_name 
from employees 
where first_name = 'Hercules' 
and last_name like 'B%'
;

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
select emp.emp_no
,emp.first_name
,emp.last_name
,dept.dept_name
from employees emp
inner join dept_emp
on emp.emp_no = dept_emp.emp_no
inner join "Departments" dept
on dept.dept_no = dept_emp.dept_no
where dept_name = 'Sales'
;

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select emp.emp_no
,emp.first_name
,emp.last_name
,dept.dept_name
from employees emp
inner join dept_emp
on emp.emp_no = dept_emp.emp_no
inner join "Departments" dept
on dept.dept_no = dept_emp.dept_no
where dept_name in('Sales', 'Development')
;

---In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select emp.last_name
,count(emp.last_name)
from employees emp
group by emp.last_name
order by "last_name" desc
;


