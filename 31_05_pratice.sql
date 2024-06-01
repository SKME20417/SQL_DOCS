-- Creating and Deleting databases

show databases;
create database techstack;
show databases;
select database();
use techstack;
select database();
drop database techstack;
select database();
show databases;

-- creating and deleting tables

create database keybourd;
use keybourd;

create table students(
name varchar(255),
roll_no int);

show tables;
describe students;

create table course(
id int,
name varchar(245),
age int,
gender varchar(8));

show tables;

drop table students;

show tables;

-- alter(modify) tables

describe course;

alter table course add class int;
describe course;

alter table course drop column gender;

describe course;
alter table course drop age;

describe course;
alter table course add age varchar(10);

describe course;

alter table course modify column age int;

describe course;

describe course;

alter table course rename to subject;

describe course;

describe subject;

alter table subject rename column name to fullname;

describe subject;

-- table constraints

create table student(
id int not null unique primary key,
name varchar(255) default "unknown",
age int not null,
class int not null);

show tables;
describe student;

-- insert Record

insert into student(
id, name, age, class)
values
(1, 'mohit', 18, 12),
(2, 'rohit', 17, 11),
(3, 'jatin', 14, 8);

select * from student;

insert into student 
values
(4, 'shweta', 19,12),
(5, 'prateek', 14, 8),
(6, 'vishnu', 12, 7),
(7, 'mahesh', 17, 10),
(8, 'aparna', 16, 11),
(9, 'jatin', 17, 11),
(10, 'rohit', 13, 8);

select * from student;

-- select command

select * from student;
select name from student;

select name, class from student;

select * from student;
select class, name, id, age from student;

select * from student;

select name from student;

select distinct name from student;

select * from student;

select distinct name, class from student;

-- Limit , Offsseet, orderby

select * from student;

select * from student limit 5;

select * from student limit 3 offset 4;

select * from student order by class desc;

select * from student order by class, age desc;
select * from student order by class desc , age desc;

-- where Clause

select * from student where class = 12;
select * from student where id = 5;
select * from student where age < 16;
select * from student where name = "vishnu";

-- Logical Operators

select * from student where class >=11 and age < 18;
select * from student where class >=11 or age <15;
select * from student where not name = "jatin";
select * from student where age between 13 and 17;
select * from student where name = "jatin" or name = "aparna" or name = "rohit";
select * from student where name in('jatin', 'aparna', 'rohit');
select * from student where name like "a%";
select * from student where name like "%a";
select * from student where name like "%ti%";
select * from student where name like "_p%";


-- Update and Delete commands

select * from student;

update student set class = 10 where id = 5;

update student set name = "mukesh" , age = 20, class = 12 where id = 10;

update student set name = "sanjay";

delete from student where id = 2;
delete from student where id = 5;

delete from student;

-- TCL
begin;
select * from student;
update student set name = "sachin" , age = 16, class = 9 where id = 6;
delete from student where id = 2;
update student set name  = "suman";
delete from student;
rollback;
select * from student;

start transaction;
select * from student;
savepoint point1;

delete from student where id = 4;

select * from student;
savepoint point2;

update student set name = "modi" where id = 6;
select * from student;

savepoint point3;

select * from student;

update student set age = 20;

select * from student;

savepoint point4;

delete from student where id = 8;

savepoint pont5;

delete from student;

savepoint point6;
select * from student;

rollback to  point2;

select * from student;

-- Aggregate Functions

select min(age) as minimum_age from student;
select max(age) max_age from student;
select count(*) total from student;
select sum(class) as final from student;
select avg(class) as mean_value from student;


-- Group by

select class from student group by class;
select class, count(name) from student group by class;
select class, count(name) as my_total from student group by class having my_total>2;

-- Craeting Marks Table

create table marks(
id int not null,
subject varchar(255) not null,
mark int not null,
primary key(id, subject));

show tables;

insert into marks(
id, subject, mark)
values
(9, 'maths', 89),
(2, 'english', 75),
(1, 'maths', 91),
(4, 'science', 97),
(10, 'computer', 83),
(1, 'english', 55),
(3, 'maths', 58);

select * from marks;

select student.id subject, mark, class, name
from student, marks
where student.id = marks.id;

select name, age, class, subject
from student
join marks
on student.id = marks.id;

select s.id,name, age, class, subject
from student as s
join marks m
on s.id = m.id;

select s.id,name, age, class, subject
from student as s
left join marks m
on s.id = m.id;

select s.id,name, age, class, subject
from student as s
right join marks m
on s.id = m.id;

select s.id,name, age, class, subject
from student as s
left join marks m
on s.id = m.id
union all
select s.id,name, age, class, subject
from student as s
right join marks m
on s.id = m.id;

-- Grant and revoke commands

create user "saket@123";

create user "tech@123" identified by "123";

show grants for "saket@123";
show grants for "tech@123";

grant select on keybourd.* to "saket@123";
grant select, update, delete on keybourd.student to "tech@123"; 

show grants for "tech@123";
flush privileges;

revoke select , update on keybourd.student from "tech@123";

show grants for "tech@123";
revoke select on keybourd.* from "saket@123";
show grants for "saket@123";

drop user "saket@123";
drop user "tech@123";

show tables;

drop table marks;

drop database keybourd;

select database();



