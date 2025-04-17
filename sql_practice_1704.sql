-- creating and deleting databases

show databases;
select database();
create database myjio;
create database nayaka;

select database();
use myjio;
use nayaka;
show tables;
drop database myjio;
show databases;
create database if not exists flip;
drop database if exists myjio;
drop database if exists nayaka;
drop database flip;
show databases;

-- creating and Deleting tables
create database if not exists amazon17;

use amazon17;

create table product(
pcode int,
item varchar(255),
company char(10),
DOE date,
DOM datetime,
price double,
quantity float,
bulk bigint,
expired boolean
);

show tables;
select database();
describe product;

create table customer(
cid int,
name varchar(255),
address mediumtext,
phone mediumint,
registered binary
);

show tables;
describe customer;

drop table product;

show tables;
drop table if exists customer;
drop database if exists amazon17;

show databases;
select database();

-- Alter/Modify tables
create database if not exists flip17;

select database();
use flip17;
create table student(
id int,
name varchar(255),
rollNo int
);

show tables;
describe student;

alter table student add class int;
alter table student add column age varchar(255);
alter table student modify column age int;
alter table student drop column rollNo;
alter table student drop column age;
alter table student rename column name to fullname17;
alter table student modify column fullname17 char(10);
alter table student rename to employee;
describe employee;

-- Table Constraints
show tables;

create table if not exists student(
id int not null unique primary key auto_increment,
name varchar(255) default "Unnamed",
age int not null check(age>=2),
class int not null
);

drop table if exists student;
describe student;
show tables;

create table if not exists city(
code int not null primary key unique auto_increment,
cname varchar(255) default "not given",
age int not null,
constraint ag_ame check(age >=18 and  cname = "Delhi")
);

show tables;

-- insert Records 
describe student;

-- approach 1
insert into student
(id, name, age, class)
values
(1, 'mohit', 18, 12),
(2, 'rohit', 17, 11),
(3, 'jatin', 14, 8);

select * from student;

-- approach 2

insert into student
values
(4, 'shweta', 19,12),
(5, 'prateek', 14, 8),
(6, 'vishnu', 12, 7),
(7, 'mahesh', 17, 10),
(8, 'aparna', 16, 11),
(9, 'jatin', 17, 11),
(10, 'rohit',13,8);

select * from student;

describe city;
drop table if exists city;

insert into city
(cname, age)
values
("Delhi", 26);

select * from city;

insert into city
(cname, age)
values
("Delhi", 30);

insert into city
(cname, age)
values
("Delhi",20);

select * from city;

create table teachers(
tid int not null primary key,
sid int not null,
tname varchar(255),
salary int,
python_marks int,
sdetails varchar(200),
foreign key(sid) references student(id)
on update cascade
on delete cascade
);

drop table if exists teachers;

show tables;
drop table if exists teachers;
describe teachers;

-- select Statemnets
select * from student;
select name from student;
select id, age from student;
select class, id, age, name from student;

-- distinct
select name from student;
select distinct name from student;
select name, class from student;
select distinct name, class from student;

-- limit, offset, orderby
select *  from student;
select * from student limit 3;
select * from student limit 6;
select * from student limit 2 offset 5;
select * from student limit 4 offset 2;
select * from student order by class asc;
select * from student order by class desc;
select * from student order by class, age;
select * from student order by class, age desc;

-- where Clause
select * from student where id = 5;
select * from student where name = "rohit";
select * from student where age>=14 order by name;

select * from student
where age >=14
order by class, name;

select * from student where class = 12;

-- logical operators

-- and, or, not, in, between, like

select * from student where class >=11 and age > 17;
select * from student where class>=10 or age > 12;
select * from student where not name = "rohit";
select * from student where name = "aparna" or name = "mohit" or name = "shweta";
select * from student where name in("aparna", "Mohit", "shweta");
select * from student where age between 13 and 17;

-- pattern Matching
-- like
-- wildcard
-- % - any number of characters
-- _ - ony single characters

select * from student where name = "prateek";
select * from student where name like "a%";
select * from student where name like "%a";
select * from student where name like "%ti%";
select * from student where name like "%e__";
select * from student where name like "_r%";

-- update and delete command
select * from student;

update student set age = 20 where id = 2;

delete from student where age<16;
update student set class = 10 where id = 4;

update student set name = "neha", age = 25, class = 15 where id = 7;

update student set name = "ankit";
select * from student;
set sql_safe_updates = 1;

select * from student;
delete from student;
set sql_safe_updates = 0;
delete from student;
select * from student;

-- TCL 
-- savepoint
-- rollback
-- commit

start transaction;
select * from student;

update student set name  = "pooja" where id = 3;

delete from student where id in(5,6);
update student set name = "tushar", age = 25, class =  12 where id = 8;

-- commit
rollback;

select * from student;

-- savepoint
set foreign_key_checks = 0;
truncate student;
begin;

select * from student;
savepoint point1;

update student set name = "clerk" where id = 2;
savepoint point2;

delete from student where id in (6,7);
savepoint point3;

update student set name = "manoj", age = 50, class = 20 where id = 5;
savepoint point4;

update student set age = 60;
savepoint point5;
-- rollback;
rollback to point4;
delete from student;
savepoint point6;

select * from student;
rollback to point2;


commit;

select * from student;
commit;
rollback;

-- functions
-- aggregate Functions
-- min, max, count, sum, avg

select min(age) as minimum_age from student;
select max(class) higest_class from student;
select count(*) as "total students" from student;
select sum(age) as total_age from student;
select avg(age) avegare_age from student;

-- string Functions

select length("computer");
select upper("i love sql");
select lower("I AM A PYTHON DEVELOPER");
select concat("rohit ", "Kumar");
select upper(name) from student;
select length(name) from student;
select *, concat("Mr. ", name) from student;
select substring("pythonProgramming", 7, 17);
select substr("abcdefghijklmn", 6,4);
select replace("i love powerbi", "powerbi", "AIML");
select reverse("machinelearning");
select left("2017abcd563", 4);
select right("2017abcd563", 3);
select mid("2017abcd563", 5,4);
select trim("                    Hello           world                       ") trimmed_text;


-- Numeric Functions
select abs(89);
select abs(-150);

select ceil(5.236598);

select floor(6.736598);

select round(6.736598, 3);

select round(9.23659, 4);

select mod(12,9);
select mod(19, 5);
select power(2,4);
select pow(5,4);
select power(9,3);
select sqrt(36);
select sqrt(49);
select  round(sqrt(89), 3);

-- Date and time functions

select current_date();
select current_time();
select now();
select date_add(now(), interval 3 second);
select datediff('2025-05-27', '2025-04-17');
select date("2026-05-24 12:25:27");
select day("2026-05-24 12:25:27");
select month("2026-05-24 12:25:27");
select year("2026-05-24 12:25:27");
select hour("2026-05-24 12:25:27");
select minute("2026-05-24 12:25:27");
select second("2026-05-24 12:25:27");

-- control Flow functions
-- if 
-- case when

select if(
10>50, "its true", "fasle");

select * from student;
select *,
if(age>=14, "Senior", "juionr")
from student;

select *,
if(class = 12 , "its twelve", if(class < 10, "its primary", "higher"))
from student;

select *,
(case
	when class = 12 then "higher"
    when class = 11 then "its evelen"
    when class = 10 then "its ten"
else "its lower" end) as class_range
from student;

select *,
(case
	when age = 19 then "its ninteen"
    when age = 18 then "its eighteen"
    when age = 17 then "its seventeen"
    when age <17 and age > 14 then "teen" 
    else "kid"
    end) as age_status
from 
student;

-- Json functions
select json_object("name", "rahul", "age", 30);

select json_extract('{"age": 30, "name": "rahul"}', '$.name');

select json_array(5,6,7,8,9);

-- information functions
select version();
select database();
select current_user();
select user();

-- groupby clause
select name, count(*) from student group by name;

select class,
count(class) 
from student group by class;

select class,
count(*)
from student
group by class 
having count(*)>=2;

select class,
count(class) as total
from 
student
group by class
having total>2;

-- sql joins
create table if not exists marks(
id int not null,
subject varchar(50) not null,
marks int not null,
primary key(id, subject)
);

describe marks;
select * from marks;

insert into marks
(id, subject, marks)
values
(9, 'maths', 89),
(2, 'english', 75),
(1, 'maths', 91),
(4, 'science', 97),
(10, 'computer', 83),
(1, 'english', 55),
(3,'maths',58);

select * from marks;

-- sql joins
select student.id,name, age, class, subject, marks
from student, marks
where student.id = marks.id;

select name, class, subject, marks
from student
join marks
on student.id = marks.id;

select name,marks,subject, age
from marks
inner join student
on marks.id = student.id;

select name,age,subject, marks
from student
left join marks
on student.id = marks.id;

select s.id,name, age, class, marks, subject
from student s
right join marks m
on s.id = m.id;

select name, class, subject, marks
from student s
left join marks m
on s.id = m.id
union all
select name, class, subject, marks
from student s
right join marks m
on s.id = m.id;

select name, age, class, subject, marks
from student s
cross join marks m;

select s1.id, s2.name, s1.age, s1.class, s2.id 
 from student s1
 join student s2
 on s1.id = s2.id;
 
 select s1.id, s2.name, s1.age, s1.class, s2.id 
 from student s1
 left join student s2
 on s1.id = s2.id;
 
 select s1.id, s2.name, s1.age, s1.class, s2.id 
 from student s1
 right join student s2
 on s1.id = s2.id;
 
 select s1.id, s2.name, s1.age, s1.class, s2.id 
 from student s1
 left join student s2
 on s1.id = s2.id
 union
 select s1.id, s2.name, s1.age, s1.class, s2.id 
 from student s1
 right join student s2
 on s1.id = s2.id;
 
 -- DCL 
 -- grant and revoke
 
 select user();
 
 create user "ravi17";
 
 create user "monika@17" identified by "123";
 
 show grants for "monika@17";
 grant select, update, insert, create, drop on flip17.* to "monika@17";
 
 show grants for "monika@17";
 
 flush privileges;
 show grants for "ravi17";
 grant select, update, delete on facebook.iris to "ravi17";
 
 flush privileges;
 show grants for "ravi17";
 
 revoke select, update, delete, drop on flip17.* from "monika@17";
 
 show grants for "monika@17";
 drop user "monika@17";
 
 show grants for "monika@17";
 
 show grants for "ravi17";
 revoke update, select on facebook.iris from "ravi17";
 
 flush privileges;
 show grants for "ravi17";
 drop user "ravi17";
 show grants for "ravi17";
 
 