create database if not exists blinkit;
show databases;
use blinkit;
select database();
show tables;
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

-- Return the list of players that have scored greater than 6 goals in the tournament

select * from players where goals >6;

delimiter &&
create procedure top_players()
begin
select * from players where goals >6;
end &&
delimiter ;

call top_players();
call top_players();

-- STORED PROCEDURES USING IN 
-- Lets create a procedure which returns the top players based on goals:

--  Top 3 players based on goals
select * from players;
-- top(5) -->
select player_name, country, goals from players order by goals desc limit 5;

delimiter //
create procedure top_players_sort_by_goals(IN var int)
begin 
select player_name, country, goals from players order by goals desc limit var;
end //
delimiter ;

call top_players_sort_by_goals(3);

-- select * from players --> ('PlayerName', number)
-- Update players set goals = ? where player_name = ?
select * from players;

update players set goals = 10 where player_name = "Sunil";

delimiter //
create procedure update_goals(IN var1 int, IN var2 varchar(25))
begin
update players set goals = var1 where player_name = var2;
end //
delimiter ;

call update_goals(15, "Nani");

call update_goals(45, "Christiano");

-- STORED PROCEDURES USING OUT --> 
select count(*) total_players from players;

delimiter &&
create procedure player_count(OUT total_players int)
begin
select count(*) from players into total_players;
end &&
delimiter ;

drop procedure player_count;

call player_count(@totalcount);

select @totalcount as Total_count;


select * from players;

select count(*) from players where country = "England";

delimiter //
create procedure player_count_england(OUT total_players int)
begin
select count(*) from players where country = "England" into total_players;
end //
delimiter ;

call player_count_england(@totalcount);

select @totalcount as Total_count;

delimiter //
create procedure player_countby_country(IN var varchar(50), OUT totalplayers int)
begin
select count(*) from players where country = var into totalplayers;
end //
delimiter ;

call  player_countby_country("Portugal", @totalcount);

select @totalcount;

select * from players;


drop database if exists classicmodels;

use classicmodels;
show tables;

select * from customers where customerName like "A%" or
customername like "E%" or
customerName like "I%" or
customerName like "O%" or
customerName like "U%" or
customerName like "a%" or
customerName like "e%" or
customerName like "i%" or
customerName like "o%" or
customerName like "u%";

select * from customers where customerName like "A%";

select * from customers;
select * from customers where customerName regexp "^A";

select * from customers where customerName regexp "^[AEIOUaeiou]";

-- temporaray tables
select * from customers where country = "USA";

create table custdetails as select * from customers where country = "USA";

select * from custdetails;

create view custdetailsview as select * from customers where country = "USA";
select * from custdetailsview;

select * from products limit 4;

select * from productlines limit 4;


create view prod_description as
(
select prd.productName, prd.quantityinstock, prd.msrp, pl.textdescription
from products prd 
inner join productlines pl
on prd.productline = pl.productline
);

select * from prod_description;

show full tables where table_type = 'VIEW';

drop view custdetailsview;

drop view prod_description;


