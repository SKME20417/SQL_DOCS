use flip17;
select database();
create table if not exists players 
(
player_id int,
player_name varchar(25),
country varchar(25),
goals int
);

show tables;
INSERT INTO players values (901, 'Sunil', 'India', 5);
INSERT INTO players values (902, 'Daniel', 'England', 12);
INSERT INTO players values (903, 'Christiano', 'Portugal', 15);
INSERT INTO players values (904, 'Zlatan', 'Sweden', 12);
INSERT INTO players values (905, 'Rodriguez', 'Columbia', 11);
INSERT INTO players values (906, 'Henry', 'England', 10);
INSERT INTO players values (907, 'Nani', 'Portugal', 2);
INSERT INTO players values (908, 'Neymar', 'Brazil', 14);
INSERT INTO players values (909, 'Jindal', 'Iran', 5);
INSERT INTO players values (910, 'Martial', 'France', 9);

select * from players;

select * from players where goals >6;

-- stored Procedure
delimiter &&
create procedure top_players()
begin
select * from players where goals > 6;
end &&
delimiter ;

call top_players();
call top_players();
select * from players;

-- Using IN 

select player_name, country, goals from players order by goals desc limit 3;

delimiter &&
create procedure top_players_sort_byGoals(IN var int)
begin
select player_name, country, goals from players order by goals desc limit var;
end &&
delimiter ;

call top_players_sort_byGoals(6);

-- 

select * from players;
update players set goals = 17 where player_name = "Sunil";

delimiter //
create procedure updateGoals(IN var1 int, IN var2 varchar(255))
begin
update players set goals = var1 where player_name = var2;
end //
delimiter ;

select * from players;

call updateGoals(27, "Christiano");

call updateGoals(29, "Daniel");

-- stored Procedure Out
select count(*) total_players  from players;

delimiter //
create procedure player_count(out var1 int)
begin
select count(*) from players into var1;
end //
delimiter ;

call player_count(@totalnumber);

select @totalnumber as TotalplayersCount;

-- count the number of players where country is given

select count(*) from players where country = "England";

delimiter &&
create procedure playerCountEngland(out var1 int)
begin
select count(*) from players where country = "England" into var1;
end &&
delimiter ;


call playerCountEngland(@myenglandtotal);

select @myenglandtotal as TotalEnglandCount;

delimiter //
create procedure playerCount_ByCountry(IN var1 varchar(255), OUT var2 int)
begin
select count(*) from players where country = var1 into var2;
end //
delimiter ;

call playerCount_ByCountry("Portugal", @pcount);

select @pcount;

call playerCount_ByCountry("India", @icount);
select @icount;


-- regex
drop database if exists caloriedb;

show databases;

use classicmodels;
show tables;

select * from customers;
select * from customers where customerName like "A%" or
customerName like "E%" or
customerName like "I%" or
customerName like "O%" or
customerName like "U%" or
customerName like "a%" or
customerName like "e%" or
customerName like "i%" or
customerName like "o%" or
customerName like "u%"; 

select * from customers where customerName like "A%";

select * from customers where customerName regexp "^A";

select * from customers where customerName regexp "^[AEIOUaeiou]";

-- temporaray tables
select * from customers where country = "USA";

create table custUSAdetails as select * from customers where country = "USA";

select * from custUSAdetails;

create view custUSAdetailsview as select * from customers where country = "USA";

select * from custUSAdetailsview;

show tables;

select * from products limit 4;
select * from productlines limit 4;

select pd.productName, pd.quantityInStock, pd.MSRP, pl.textDescription
from products pd
join productlines pl
on pd.productLine = pl.productLine;

create view productDescription as
(select pd.productName, pd.quantityInStock, pd.MSRP, pl.textDescription
from products pd
join productlines pl
on pd.productLine = pl.productLine)
;

select * from productDescription;

show full tables where table_type = "VIEW";

drop view productDescription;
drop view custUSAdetailsview;

 


