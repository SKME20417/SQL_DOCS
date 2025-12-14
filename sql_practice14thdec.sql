-- Creating and Deleting Databases

show databases;
create database exl;
select database();
use exl;
select database();
create database amazon;
drop database exl;
show databases;
drop database amazon;

-- Creating and Deleting Tables

create table Students(
name varchar(255),
roll_no int
);

create database school;
select database();
use school;
show tables;

create table teachers(
emp_id int,
emp_name varchar(50),
DOB date,
shift_timing time,
emp_status bool
);


show tables;
drop table students;
show tables;
describe teachers;

-- Alter(Modify) Tables

alter table teachers add column class int;
alter table teachers add column age varchar(255);
alter table teachers modify column age int;
alter table teachers drop DOB;
alter table teachers drop column class;

-- Table Constraints
 
show tables;

create table students(
id int not null unique primary key,
name varchar(255) default "unknown",
age int not null,
class int not null
);


show tables;

describe students;

-- Insert Records

-- Approach 1
insert into students
(id, name, age, class) 
values
(1, 'mohit', 18, 12),
(2, 'rohit', 17, 11),
(3, 'jatin', 14, 8),
(4, 'shweta', 19,12),
(5, 'prateek', 14, 8),
(6, 'vishnu', 12, 7);

-- Approach 2
insert into students
value
(7, 'mahesh', 17, 10),
(8, 'aparna', 16, 11),
(9, 'jatin', 17, 11),
(10, 'rohit', 13, 8);

-- Select Statements

select * from students;
select * from students;
select name from students;
select age, class from students;
select * from students;
select class, name, id, age from students;

-- Distinct
select name from students;
select distinct name from students;
select name, class from students;
select distinct name, class from students;

-- Limit, offset, orderby

select * from students;
select * from students limit 4;
select * from students limit 3 offset 3;
select * from students limit 2 offset 6;
select * from students;
select * from students order by class;
select * from students order by class desc;
select * from students order by class desc  , age ;

-- where clause

select * from students where class = 12;
select * from students where id = 5;
select * from students where age< 16;
select * from students where name = "jatin";
select * from students where not name = "jatin";

-- Logical Operators

select * from students where class >=11 and age < 18;
select * from students where class >= 12 or age <15;
select * from students where not name = "rohit";
select * from students where age between 13 and 17;
select * from students where name = "rohit" or name = "jatin" or name = "prateek";
select * from students;
select * from students where name in ("rohit", "jatin", "prateek");
select * from students where name like "%a";
select * from students where name like "a%";
select * from students where name like "%t__";
select * from students where name like "_p%";

-- update and delete
select * from students;
update students set class = 12 where id = 7;
update students set class = 8 , age = 15, name = "sunil" where id = 4;
update students set age = 12;
set sql_safe_updates = 0;
update students set name = "mohit" ;
rollback;
delete from students;

-- transaction 
-- commit, rollback, savepoint

select * from students;

start transaction;

select * from students;

update students set age = 10 where id = 2;
update students set class = 7 where id = 4;

update students set name = "ankit" , age = 12, class = 10 where id = 5;

update students set class = 20;

update students set name = "bharti";

delete from students where id = 3;
delete from students where id in(6,8,2);

delete from students;

-- commit;
rollback;
select * from students;

rollback;

commit;


select * from students;

-- savepoint

begin;

select * from students;
savepoint point1;
update students set name = "dhiraj", age = 40, class = 34 where id = 3;
savepoint point2;
update students set class = 12 where id = 5; 
savepoint point3;
update students set name = "sachin";
savepoint point4;
delete from students where id = 3;
savepoint point5;
update students set age = 0;
savepoint point6;
delete from students;
savepoint point7;
select * from students;

-- commit
-- rollback;

rollback to point6;
rollback to point3;
rollback;
commit;
select * from students;

-- Aggregate Functions
use school;

select * from students;
select count(*) from students;
select count(name) from students;
select min(age) as minimum_age from students;
select max(age) maximum_age from students;
select sum(class) as total from students;
select avg(age) avg_age from students;

-- group_by

select * from students group by class;
select class from students group by class;
select class, count(*) total from students group by class;
select class, count(name) as my_total from students group by class having my_total >2;


-- creating marks table

create table marks(
id int not null,
subject varchar(50) not null,
score int not null,
primary key(id, subject)
);

insert into marks
(id, subject, score)
values 
(9, 'maths', 89),
(2, 'english', 75),
(1, 'maths', 91),
(4, 'science', 97),
(10, 'computer', 83),
(1, 'english', 55),
(3, 'maths', 58);

show tables;

-- joins
select * from students;
select * from marks;


select students.id,name, class, subject, score
from students,marks
where students.id = marks.id;

select name, class, subject, score
from students
join marks
on students.id = marks.id;

select name, class, subject, score
from students
inner join marks
on students.id = marks.id;


select name, subject, class, score
from students
left join marks
on students.id = marks.id;

select name, subject, class, score
from students
right join marks
on students.id = marks.id;

select name, subject, class, score
from students
left join marks
on students.id = marks.id
union all
select name, subject, class, score
from students
right join marks
on students.id = marks.id;


select s.id,name, class, subject, score
from students s
join marks m 
on s.id = m.id;


select name, subject, s.id, score, m.id
from students s
cross join marks m;


-- Grant and revoke 

create user "ankit@123";
select user, host, plugin from mysql.user;
select user, host, authentication_string from mysql.user;
create user "pooja" identified by "tgc123";
select user, host from mysql.user;
grant select, update, delete, insert on school.* to "pooja";
flush privileges;
show grants for "pooja";
revoke select, insert, update on school.* from "pooja";
show grants for "pooja";
select user, host from mysql.user;
drop user pooja;
drop user "ankit@123";