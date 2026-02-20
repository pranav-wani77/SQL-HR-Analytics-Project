create database hr_project;

use hr_project;
CREATE TABLE employees (
    Employee_no INT PRIMARY KEY,
    Gender varchar(10),
    Martial_Status varchar(10),
    Job_Role VARCHAR(50),
    Monthly_Income int,
    Age VARCHAR(50),
    Department varchar(20),
    Over_Time varchar(10),
    Job_Satisfaction int,
    Education varchar (30),
    Attrition varchar(10)
    );
## Load excel data set in csv format
 ## DATA VALIDATION
 select * from employees;
select count(*) from employees;
select * from employees limit 5;

## DATA CLEANING
select * from employees
where Employee_no is null;

## DUPLICATE Check
select employee_no, count(*)
from employees
group by employee_no
having count(*) > 1;

## Invalid Salary 
select * from employees
where Monthly_Income <= 0;

## Normalization
select * from employees;

create table departments (
department_id int primary key auto_increment,
department_name varchar(50)
);

insert into departments (department_name)
select distinct department from employees;

SELECT Employee_no, department, department_id
FROM employees
LIMIT 10;
 
## add department into employees
alter table employees
add department_id int;

## safe mode off
set sql_safe_updates = 0;

update employees e 
join departments d 
on e.department = d.department_name
set e.department_id = d.department_id;

## safe mode on
set sql_safe_updates = 1;

## ADD foreign key
alter table employees
add constraint fk_department
foreign key (department_id)
references departments(department_id);

## Queries performed 

# 1)Basic 
# a)Display all employee records.
select * from employees;

# b) Show employee ID, age, and salary only.
select Employee_no, Age, Monthly_Income 
from employees;

#c) List all unique departments.
select distinct department
from employees;

# d) Find employees with salary greater than 15,000.
select * from employees
where Monthly_Income > 15000;

# e) Retrieve(show) employees from the Sales department
select * from employees
where department = 'Sales';

# FILTERING & SORTING
# a) Find employees with age more than 40 years.
select * from employees
where Age > 40;

# b) Display employees sorted by salary in descending order.
select * from employees
order by Monthly_Income desc;

# c) Show top 5 highest-paid employees.
select * from employees
order by Monthly_Income desc limit 5;

# AGGREGATE FUNCTION QUESTIONS
# a) Find the total number of employees.
select count(*) from employees;

# b) Calculate the average salary of employees.
select avg(Monthly_Income) from employees;

# c) Find minimum and maximum salary.
select min(Monthly_Income) as min_salary ,
 max(Monthly_Income) as max_salary from employees;
 
 # GROUP BY & HAVING QUESTIONS
# a) Find department-wise employee count.
select department, count(*) as emp_count 
from employees
group by department;

 # b) Department-wise average salary
select department, avg(Monthly_Income) as avg_sal 
from employees
group by department;

# c) Departments with more than 100 employees
select department, count(*) as emp_count from employees
group by department
having count(*) > 100;

# JOINS
select * from employees;
select * from departments;
# a)  Employees with department name
select E.Employee_no, d.department_id from employees e 
join departments d 
on d.department_id = E.department_id;

# b) Department-wise employee count using JOIN
select d.department_name, count(*) as emp_count from employees e
join departments d 
on E.department_id = d.department_id
group by d.department_name;

# SUBQUERIES
# a) Employees earning above average salary
select * from employees
where Monthly_Income > (select avg(Monthly_Income) from employees) ;

# b) Employees from highest-paying department
select * from employees
where department_id = (select department_id from employees
group by department_id 
order by avg(Monthly_Income) desc limit 1);

# CONDITIONAL LOGIC
# a) Salary category using CASE
select Employee_no, Monthly_Income, 
case 
when Monthly_Income >= 15000 then 'High'
when Monthly_Income >= 10000 then 'Medium'
else 'Low'
end as salary_category 
from employees;

# DATA CLEANING & VALIDATION
# a) check Null values
select * from employees
where Employee_no is Null;

