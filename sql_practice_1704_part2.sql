-- window Function
show databases;
drop database if exists window1;
drop database if exists window123;

create database if not exists window1;

select database();
use window1;
select database();
create table if not exists employee(
ID int,
ename varchar(50),
dname varchar(50),
salary int
);

drop table employee;


describe employee;

select * from employee;

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

select * from employee;

select dname,max(salary) from employee group by dname;

select e.*,
max(salary) over(partition by dname) as max_salary
from employee e;

-- row number, rank, dense rank
select e.*,
row_number() over(partition by dname) as rn
from employee e;

select x.* from 
(select e.*,
row_number() over(partition by dname order by id) as rn
from employee e) as x
where rn<3;

select * 
from (select e.*,
rank() over(partition by dname order by salary desc) as rnk
from employee e) as x
where x.rnk<3;

select * 
from (select e.*,
rank() over(partition by dname order by salary desc) as rnk
from employee e) as x
where x.rnk<4;


select * from 
(select e.*,
dense_rank() over(partition by dname order by salary desc) as drnk
from employee e) as x
where x.drnk < 4;

-- row, rank, dense 

select e.*,
row_number() over(partition by dname order by salary desc) as rn,
rank() over(partition by dname order by salary desc) as rnk,
dense_rank() over(partition by dname order by salary desc) as drnk
from employee e;

-- lag, lead as a window function

select e.*,
lag(salary) over(partition by dname order by ID) as previou_salary,
case
	when salary > lag(salary) over(partition by dname order by ID) then "Higher"
    when salary < lag(salary) over(partition by dname order by ID) then "lower"
else "same" end as comparison
from employee e;

select e.*,
lag(salary) over(partition by dname order by ID) as previous_emp_sal,
lead(salary) over(partition by dname order by ID) as next_emp_sal
from employee e;

show tables;

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

select p.*,
first_value(product_name) over(partition by product_category order by price desc) as most_expensive_product
from product p;

select p.*,
first_value(product_name) over(partition by product_category order by price)
from product p;

-- last value

select p.*,
last_value(product_name) over(partition by product_category order by price desc
range between unbounded preceding and unbounded following) as least_expensive
from product p;


select p.*,
first_value(product_name) over(partition by product_category order by price desc) as most_expensive,
last_value(product_name) over(partition by product_category order by price desc
range between unbounded preceding and unbounded following) as least_expensive
from product p
where product_category = "Phone";

select p.*,
first_value(product_name) over w as most_expensive_product,
last_value(product_name) over w as least_expensive_product
from product p
where product_category = "Phone"
window w as(partition by product_category order by price desc
range between unbounded preceding and unbounded following);

-- nth value

select p.*,
nth_value(product_name, 3) over(partition by product_category order by price desc) as 2nd_most_expensive
from product p;


select p.*,
first_value(product_name) over w as most_expensive,
last_value(product_name) over w as least_expensive,
nth_value(product_name, 2) over w as 2nd_most_expensive
from product p
where product_category = "Phone"
window w as (partition by product_category order by price desc
range between unbounded preceding and unbounded following);

-- ntile 
 select x.*,
 case 
	when x.bucket = 1 then "most Expensive"
    when x.bucket = 2 then "mid range"
else "cheaper" end as price_range
from (select p.*,
ntile(3) over(order by price desc) as bucket
from product p
where product_category = "Phone") as x;

-- cume_dist

select x.*
from  
(select p.*,
cume_dist() over(order by price desc) as cumvalue,
concat(round(cume_dist() over(order by price desc)*100, 2), "%") as cumpercent
from product p) as x
where x.cumvalue <=0.3;


-- percent_rank

select x.*
from 
(select p.*,
percent_rank() over(order by price) as percentvalue,
concat(round(percent_rank() over(order by price desc)*100,2), "%") as percentage_value
from product p) as x
where x.product_name = "Galaxy Z Fold 3";

