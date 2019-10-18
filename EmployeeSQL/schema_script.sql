

employees 
------------
emp_no PK int
birth_date date
first_name varchar(30)  
last_name varchar(30)
gender varchar(10)
hire_date date

titles
---
emp_no FK int FK >- employees.emp_no
title varchar(30)
from_date date
to_date date

salaries
---
emp_no FK int FK >- employees.emp_no
salary money
from_date date
to_date date


departments
-
dept_no  PK varchar(30) 
dept_name  varchar(50)


dept_emp
-
emp_no FK int FK >- employees.emp_no
dept_no varchar(30) FK >- departments.dept_no 
from_date date
to_date date 

dept_manager 
----
dept_no  FK varchar(30) FK >- departments.dept_no
emp_no FK int FK >- employees.emp_no 
from_date date
to_date date



