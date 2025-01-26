-- Creating and Deleting Databases 

SHOW DATABASES;
CREATE DATABASE abc;
SELECT DATABASE();
USE abc;
DROP DATABASE abc;

-- Creating and Deleting Tables

CREATE TABLE students(
	name varchar(50),
	roll_no int
);
DROP TABLE students;

-- Alter(Modify) Tables

ALTER TABLE students ADD class int;
ALTER TABLE students ADD age varchar(10);
ALTER TABLE students DROP COLUMN class;
ALTER TABLE students ALTER COLUMN age int;


-- Table Constraints

CREATE TABLE students(
	id int NOT NULL UNIQUE PRIMARY KEY,
	name varchar(50) NOT NULL DEFAULT 'Unnamed',
	age int NOT NULL,
	class int NOT NULL
);

-- Insert Records

INSERT INTO students
(id, name, age, class)
VALUES
(1, 'mohit', 18, 12),
(2, 'rohit', 17, 11),
(3, 'jatin', 14, 8),
(4, 'shweta', 19,12),
(5, 'prateek', 14, 8),
(6, 'vishnu', 12, 7),
(7, 'mahesh', 17, 10),
(8, 'aparna', 16, 11),
(9, 'jatin', 17, 11),
(10, 'rohit', 13, 8);


-- SELECT Statement

SELECT * FROM students;
SELECT name FROM students;
SELECT id,name FROM students;
SELECT class, age, id, name FROM students;

SELECT DISTINCT name FROM students;
SELECT DISTINCT name, class FROM students;

-- Limit, Offset, OrderBy

SELECT * FROM students LIMIT 3;
SELECT * FROM students LIMIT 3 OFFSET 5;
SELECT * FROM students ORDER BY class;
SELECT * FROM students ORDER BY class, age;
SELECT * FROM students ORDER BY class DESC, age DESC;



show databases;
create database school;

drop database school;
select database();
use school;

create table students(
id int not null unique primary key,
name varchar(50) not null default "unnamed",
age int not null,
class int not null);

desc students;

insert into students 
values
(1, 'mohit', 18, 12),
(2, 'rohit', 17, 11),
(3, 'jatin', 14, 8),
(4, 'shweta', 19,12),
(5, 'prateek', 14, 8),
(6, 'vishnu', 12, 7),
(7, 'mahesh', 17, 10),
(8, 'aparna', 16, 11),
(9, 'jatin', 17, 11);

select * from students;

insert into students (id, name, age, class)
values
(10, 'rohit',13, 8);

select * from students;
select database();
use school;
show tables;

-- where clause

select * from students where class = 12;
select * from students where id  = 5;
select * from students where age < 16;
select * from students where name = "jatin";

-- Logical Operators

select * from students where class >=11 and age <18;
select * from students where class >=11 or age<18;

select * from students where not name = "jatin";
select * from students where age between 13 and 17;
select * from students where name = "rohit" or name = "jatin" or name = "aparna";
select * from students where name in("rohit", "jatin", "aparna");
select * from students where name like "a%";
select * from students where name like "%a";
select * from students where name like "%ti%";
select * from students where name like "%e__";

-- Update and delete commnads
select * from students;

update students set age = 25 where id  = 4;

update students set name = "punnet" , age = 20, class = 12 where id = 5;

update students set name = "mohit";

rollback;

delete from students where id = 3;
delete from students where age > 17;

rollback;
delete from students ;

rollback;
select * from students;

-- TCL - Trancation Control language
-- comit
-- rollback
-- savepoint

start transaction;
select * from students;

update students set name = "pooja", age = 10, class = 16 where id = 2;

delete from students where id = 3;
update students set name = "varun", class = 12 where id = 6;

delete from students where id = 7;
delete from students;
select * from students;
rollback;

select * from students;

begin;
select * from students;

update students set name = "sejal" , age = 19, class = 12 where id = 1;

delete from students where id = 3;

commit;

select * from students;
rollback;
select * from students;

truncate table students;

start transaction;

select * from students;
savepoint point1;

update students set name  = "bharat", age = 12, class = 9 where id = 2;

select * from students;
savepoint point2;

delete from students where id in(4,5);

select * from students;
savepoint point3;

update students set name = "sam";

select * from students;
savepoint point4;

delete from students;

select * from students;
savepoint point5;

select * from students;

rollback to point4;

select * from students;
rollback to point2;
commit;
rollback;
select * from students;

-- Aggregate Functions
select count(distinct name) as 'Unique students' from students;
select min(age) as 'minimum age' from students;
select max(age) maximum_age from students;
select avg(age) from students;
select sum(age) total_sum from students;

-- Group by
select class from students group by class;
select class, count(class) from students group by class;

select class, count(name) total_students from students group by class having total_students>=2;

-- creating marks table

create table marks(
id int not null auto_increment,
subject varchar(255) not null,
marks int not null,
primary key(id, subject)
);

show tables;

describe marks;
drop table marks;

insert into marks(id, subject,marks)
values
(9, 'maths', 89),
(2, 'english', 75),
(1, 'maths', 91),
(4, 'science', 97),
(10, 'computer', 83),
(1, 'english', 55),
(3, 'maths' , 58);


select * from marks;

insert into marks(subject, marks)
values
("python", 95),
("sql", 99);

select * from marks;

-- Joins

select students.id, name, class, marks
from students, marks
where students.id = marks.id;

select s.id , name, marks, subject, m.id
from students as s
join marks m
on s.id = m.id;

select s.id , name, marks, subject, m.id
from students as s
left join marks m
on s.id = m.id;

select s.id , name, marks, subject, m.id
from students as s
right join marks m
on s.id = m.id;

select s.id , name, marks, subject, m.id
from students as s
left join marks m
on s.id = m.id
union all
select s.id , name, marks, subject, m.id
from students as s
right join marks m
on s.id = m.id;

select * from students;
select * from marks;

select s.id, name , marks, age
from students s
cross join marks m;

select * from students natural join marks;

-- TCL 
-- grant
-- Revoke

create user "mohit@123" identified by "m#456";

execute sp_who;

select user();
show grants for "mohit@123";

grant select , update, delete on school.marks to "mohit@123";

show grants for "mohit@123";

grant insert on school.* to "mohit@123";

show grants for "mohit@123";

flush privileges;

revoke update, select on school.marks from "mohit@123";

show grants for "mohit@123";

revoke insert on school.* from "mohit@123";

show grants for "mohit@123";

drop user "mohit@123";
show grants for "mohit@123";

create table employees(
employee_id int primary key,
employee_name varchar(255),
manager_id int
);

drop table employees;
insert into employees 
values
(1,"Alice", null),
(2,"Bob",1),
(3,"Charlie",1),
(4,"David",2);

select * from employees;

select e1.employee_name as Employee, e2.employee_name as Manager
from employees as e1
left join employees as e2
on e1.manager_id = e2.employee_id;


create table staff(
staff_id int,
staff_name varchar(255),
department varchar(255));

select * from staff;
insert into staff
values
(1, "Alex", "Sales"),
(2, "Brian", "HR"),
(3, "Cathy", "Sales"),
(4, "Diana", "HR");

select * from staff;

select 
	s1.staff_name as Staff1,
    s2.staff_name as Staff2,
    s1.department
from staff as s1
join staff s2
on s1.department = s2.department
where s1.staff_id < s2.staff_id;


-- Hierarchical relationship, finding duplicates, finding related data in a same table, same row data comparison

