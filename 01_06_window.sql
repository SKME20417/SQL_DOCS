-- Window Functions

create database windowfunction;
use windowfunction;

create table employee
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

show tables;
describe employee;

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

commit;
select * from employee;

select dept_name,max(salary) from employee group by dept_name;

select e.*, max(salary) 
over(partition by dept_name) as maxximum_salary from employee e; 

select e.* , row_number() over(partition by dept_name) as rwn
from employee e;

-- Fetch the first 2 employees from each department to join the company.

select * from (select e.*,
row_number() over(partition by dept_name order by emp_ID) as rwn
from employee e) as x
where x.rwn<3;

-- Fetch the top 3 employees in each department earning the max salary.

select * from  (select e.* , 
rank() over(partition by dept_name order by salary desc) as rak
from employee e) as x
where x.rak<=3;

select * from (select e.*,
dense_rank() over(partition by dept_name order by salary desc) as dmnk
from employee e) x
where x.dmnk<4;

select e.*,
row_number() over(partition by dept_name order by salary desc) as rown,
rank() over(partition by dept_name order by salary desc) as nk,
dense_rank() over(partition by dept_name order by salary desc) as dnk
from employee e; 

-- lag, lead

-- fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee.

select e.*,
lag(salary) over(partition by dept_name) as Privous_salary,
case
	when lag(salary) over(partition by dept_name order by emp_ID) = e.salary then "Same Salary"
    when lag(salary) over(partition by dept_name order by emp_ID) > e.salary then "Less salary"
    else "Hiher salary" end as salary_range
from employee e;

-- Similarly using lead function to see how it is different from lag.

select e.*,
lead(salary) over(partition by dept_name order by emp_ID) as next_emp_salary,
case 
	when e.salary > lead(salary) over(partition by dept_name order by emp_ID) then "Higer salary"
    when e.salary < lead(salary) over(partition by dept_name order by emp_ID) then "lower Salary"
    when e.salary = lead(salary) over(partition by dept_name order by emp_ID) then "same salary"
    end as salary_range
from employee e;

CREATE TABLE product
( 
    product_category varchar(255),
    brand varchar(255),
    product_name varchar(255),
    price int
);

INSERT INTO product VALUES
('Phone', 'Apple', 'iPhone 12 Pro Max', 1300),
('Phone', 'Apple', 'iPhone 12 Pro', 1100),
('Phone', 'Apple', 'iPhone 12', 1000),
('Phone', 'Samsung', 'Galaxy Z Fold 3', 1800),
('Phone', 'Samsung', 'Galaxy Z Flip 3', 1000),
('Phone', 'Samsung', 'Galaxy Note 20', 1200),
('Phone', 'Samsung', 'Galaxy S21', 1000),
('Phone', 'OnePlus', 'OnePlus Nord', 300),
('Phone', 'OnePlus', 'OnePlus 9', 800),
('Phone', 'Google', 'Pixel 5', 600),
('Laptop', 'Apple', 'MacBook Pro 13', 2000),
('Laptop', 'Apple', 'MacBook Air', 1200),
('Laptop', 'Microsoft', 'Surface Laptop 4', 2100),
('Laptop', 'Dell', 'XPS 13', 2000),
('Laptop', 'Dell', 'XPS 15', 2300),
('Laptop', 'Dell', 'XPS 17', 2500),
('Earphone', 'Apple', 'AirPods Pro', 280),
('Earphone', 'Samsung', 'Galaxy Buds Pro', 220),
('Earphone', 'Samsung', 'Galaxy Buds Live', 170),
('Earphone', 'Sony', 'WF-1000XM4', 250),
('Headphone', 'Sony', 'WH-1000XM4', 400),
('Headphone', 'Apple', 'AirPods Max', 550),
('Headphone', 'Microsoft', 'Surface Headphones 2', 250),
('Smartwatch', 'Apple', 'Apple Watch Series 6', 1000),
('Smartwatch', 'Apple', 'Apple Watch SE', 400),
('Smartwatch', 'Samsung', 'Galaxy Watch 4', 600),
('Smartwatch', 'OnePlus', 'OnePlus Watch', 220);
COMMIT;

select * from product;

-- -- FIRST_VALUE 
-- Write query to display the most expensive product under each category (corresponding to each record)


select *,
first_value(product_name) over(partition by product_category order by price desc) as most_expensive
from product;




-- LAST_VALUE 
-- Write query to display the least expensive product under each category (corresponding to each record

select *,
first_value(product_name) over(partition by product_category order by price asc) as most_expensive
from product;

select *,
last_value(product_name) over(partition by product_category order by price desc
range between unbounded preceding and unbounded following) as leat_expensive
from product;

select *,
last_value(product_name) over(partition by product_category order by price desc
rows between 2 preceding and 2 following) as leat_expensive
from product;

select *,
last_value(product_name) over(partition by product_category order by price desc
rows between 2 preceding and 2 following) as leat_expensive
from product;


select *,
first_value(product_name) over(partition by product_category order by price desc) as most_expensive,
last_value(product_name) over(partition by product_category order by price desc 
range between unbounded preceding and unbounded following) as least_expensive
from product where product_category = "Phone";

-- Alternate way to write SQL query using Window functions

select *,
first_value(product_name) over w as most_expensive,
last_value(product_name) over w as least_expensive
from product
where product_category = "phone"
window w as (partition by product_category order by price desc 
range between unbounded preceding and unbounded following);


-- NTH_VALUE 
-- Write query to display the Second most expensive product under each category.

select *,
nth_value(product_name,3) over(partition by product_category order by price desc
range between unbounded preceding and unbounded following) as 2nd_most_expensive
from product;

select *,
first_value(product_name) over w as most_expensive,
last_value(product_name) over w as least_expensive,
nth_value(product_name, 3) over w as 2nd_most_expensive
from product 
window w as (partition by product_category order by price desc
range between unbounded preceding and unbounded following)
;


-- NTILE
-- Write a query to segregate all the expensive phones, mid range phones and the cheaper phones.

select x.product_name, 
case 
	when x.buckets = 1 then "Expensive Phones"
    when x.buckets = 2 then "Mid Range Phones"
    else "Cheaper_phones" end as segregated_phones
    from
(select *,
ntile(4) over(order by price desc) as buckets
from product where product_category = 'Phone') as x;

-- CUME_DIST (cumulative distribution) ; 
/*  Formula = Current Row no (or Row No with value same as current row) / Total no of rows */

-- Query to fetch all products which are constituting the first 30% 
-- of the data in products table based on price.

select * from (select *,
cume_dist() over(order by price desc) as cume_distribution,
round(cume_dist() over(order by price desc)*100,2) as cume_percentage
from product) as x
where x.cume_distribution<=0.3;







-- PERCENT_RANK (relative rank of the current row / Percentage Ranking)
/* Formula = Current Row No - 1 / Total no of rows - 1 */

-- Query to identify how much percentage more expensive is "Galaxy Z Fold 3" when compared to all products.

select * from (select *,
percent_rank() over(order by price) as percent,
round(percent_rank() over(order by price),2) as percent_rnk
from product) x
where x.product_name = 'Galaxy Z Fold 3';