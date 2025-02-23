-- Functions
-- string functions

select database();

show tables;
select * from students;

select concat("Mr. " , name) from students;

select concat("Hello", " World");

select subject from marks;

select length(name)from students;
select length("Computer");

select upper("mobile");

select lower("DJANGO");

select name from students;

select upper(name) from students;

select lower(employee_name) from employees;

select substring("Mysql is very easy", 10);

select trim("      Hello       ");

select replace("Welcome to MYSQL", "MYSQL", "Databases");

-- Numeric Functions

select abs(-15);
select ceil(5.12);
select floor(7.89);
select round(45.123654789,5);
select mod(12 , 9);
select mod(17, 5);
select power(6,3);
select sqrt(729);
select sqrt(49);

-- Date/Time functions
select current_date();
select curdate();
select current_time();
select curtime();
select current_timestamp();
select now();
select current_user();
select date("2026-05-25 16:45:40");

select date(now());
select day("2026-05-25 16:45:40");
select month("2026-05-25 16:45:40");
select monthname("2026-05-25 16:45:40");

select date(now());
select datediff("2025-01-25", "2024-01-10");

select adddate("2025-01-25", 15);
select addtime("15:20:20", 15);
select str_to_date("26-01-2025", "%d-%m-%Y");

-- Aggregate Functions

select * from students;

select count(*) from students;
select sum(age) as Total_age from students;
select min(class) from students;
select max(class) from students;
select avg(age) from students;

-- Control Flow Functions
select * from students;
select if(age>14, "High", "Low") from students;

select 
	case
		when age>14 then "High"
        else "Low" 
	end
from students;

-- Json Functions
select json_extract('{"a":1, "b":2}', '&.a');

select json_array(1, "abc", True);

-- Subquaries in Mysql

select database();
use school;
show tables;
select * from employees;

-- window functions
create database wind;

use wind;
select database();
show tables;

create table employee
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);


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
insert into employee values(124, 'Dheeraj', 'IT',11000);
COMMIT;


select * from employee;

select max(salary) 
from employee;

select dept_name , max(salary)
from employee
group by dept_name;

select e.*,
max(salary) over(partition by dept_name) as max_salary
from employee e;


-- row_number, rank, dense_rank

select e.*,
row_number() over(partition by dept_name) as rn
from employee e;

select e.*,
row_number() over(partition by dept_name order by salary desc) as rn,
rank() over(partition by dept_name order by salary desc) as rnk,
dense_rank() over(partition by dept_name order by salary desc) as drnk
from employee e;


select * 
from
(select e.*,
rank() over(partition by dept_name order by salary desc) as rnk,
dense_rank() over(partition by dept_name order by salary desc) as drnk
from employee e) as x
where x.rnk<4;

select * from  (select e.*,
row_number() over(partition by dept_name order by emp_id) as rn
from employee e) as x
where x.rn < 3;

-- lead and lag

-- fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee.

select e.*,
lag(salary) over(partition by dept_name order by emp_id) as previous_salary,
case
	when e.salary > lag(salary) over(partition by dept_name order by emp_id) then "Higher"
    when e.salary < lag(salary) over(partition by dept_name order by emp_id) then "lower"
    else "same" end
    as sal_range,
lead(salary) over(partition by dept_name order by emp_id) next_salary
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
('Smartwatch', 'Samsung', 'Galaxy Watch 4', 600);

INSERT INTO product VALUES
('Smartwatch', 'OnePlus', 'OnePlus Watch', 220);
COMMIT;

select * from product;

select p.*,
first_value(product_name) over(partition by product_category order by price desc) as Most_expensive
from product p;

select p.*,
first_value(product_name) over(partition by product_category order by price asc) as Most_expensive
from product p;

select p.*,
last_value(product_name) over(partition by product_category order by price desc
range between unbounded preceding and unbounded following) as least_expensive
from product p
where product_category = "phone";

-- alternate way
select p.*,
first_value(product_name) over w as most_expensive,
last_value(product_name) over w as least_expensive
from product p
where product_category = "phone"
window w as (partition by product_category order by price desc
range between unbounded preceding and unbounded following);


select p.*,
nth_value(product_name, 3) over(partition by product_category order by price desc) as send_most
from product p;


select x.product_name,
(case 
	when x.bucket = 1 then "Expensive Phone"
    when x.bucket = 2 then "mid range"
    else "cheaper" end) as phone_range
from
(select *,
 ntile(3) over(order by price desc) as bucket
 from product
 where product_category = "phone") as x;
 
 -- CUME_DIST (cumulative distribution) ; 
/*  Formula = Current Row no (or Row No with value same as current row) / Total no of rows */

-- Query to fetch all products which are constituting the first 30% 
-- of the data in products table based on price.

select product_name , cum_dist_percent
from 
(select p.*,
cume_dist() over(order by price desc) as cum_distribution,
concat(round(cume_dist() over(order by price desc)*100,2), "%") as cum_dist_percent
from product p) as x
where x.cum_distribution<=0.3;



-- PERCENT_RANK (relative rank of the current row / Percentage Ranking)
/* Formula = Current Row No - 1 / Total no of rows - 1 */

-- Query to identify how much percentage more expensive is "Galaxy Z Fold 3" when compared to all products.

select product_name, x.percen_rnk_per
from  
(select p.*,
percent_rank() over(order by price) as percent_rnk,
concat(round(percent_rank() over(order by price)*100, 2), "%") as percen_rnk_per
from product p) as x
where x.product_name = "Galaxy Z Fold 3"; 