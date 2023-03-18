
use dress_data;
CREATE TABLE `Attribute_DataSet` (
	`Dress_ID` int NOT NULL, 
	`Style` VARCHAR(8) NOT NULL, 
	`Price` VARCHAR(9), 
	`Rating` DECIMAL(5, 2) NOT NULL, 
	`Size` VARCHAR(5) NOT NULL, 
	`Season` VARCHAR(6), 
	`NeckLine` VARCHAR(15), 
	`SleeveLength` VARCHAR(14), 
	waiseline VARCHAR(8), 
	`Material` VARCHAR(13), 
	`FabricType` VARCHAR(10), 
	`Decoration` VARCHAR(10), 
	`Pattern Type` VARCHAR(9), 
	`Recommendation` int NOT NULL,
    primary key(Dress_ID)
);

drop table Attribute_DataSet;

set session sql_mode = '';

load data infile 'E:\\Attribute_DataSet.csv'
into table Attribute_DataSet
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from Attribute_DataSet;

CREATE TABLE `Dress_Sales` (
	`Dress_ID` int NOT NULL, 
	`29-08-2013` INT NOT NULL, 
	`31-08-2013` INT NOT NULL, 
	`09-02-2013` INT NOT NULL, 
	`09-04-2013` INT NOT NULL, 
	`09-06-2013` INT NOT NULL, 
	`09-08-2013` INT NOT NULL, 
	`09-10-2013` INT NOT NULL, 
	`09-12-2013` INT NOT NULL, 
	`14-09-2013` INT NOT NULL, 
	`16-09-2013` INT NOT NULL, 
	`18-09-2013` INT NOT NULL, 
	`20-09-2013` INT NOT NULL, 
	`22-09-2013` INT NOT NULL, 
	`24-09-2013` INT NOT NULL, 
	`26-09-2013` INT NOT NULL, 
	`28-09-2013` INT NOT NULL, 
	`30-09-2013` INT NOT NULL, 
	`10-02-2013` INT NOT NULL, 
	`10-04-2013` INT NOT NULL, 
	`10-06-2013` INT NOT NULL, 
	`10-08-2010` INT NOT NULL, 
	`10-10-2013` INT NOT NULL, 
	`10-12-2013` INT NOT NULL,
    foreign key(Dress_ID) references Attribute_DataSet(Dress_ID)
);
drop table dress_sales;

load data infile 'E:\\Dress_Sales.csv'
into table dress_sales
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from dress_sales;

select * from Attribute_DataSet;

Delimiter &&
create procedure dress_sales()
Begin
	select a.dress_id, a.style, a.size, a.rating, d.`29-08-2013`,d.`31-08-2013`,d.`09-02-2013` from Attribute_DataSet a
    inner join dress_sales d on a.Dress_ID = d.Dress_ID limit 10;
End &&
Delimiter ;

call dress_sales();

Delimiter $$
create function rate_flag(rating decimal(5,2))
returns varchar (60)
deterministic 
begin
	Declare rate varchar(60);
    if rating <= 2.5 then 
		set rate = 'Bad product quality';
	elseif rating <= 3.5 then 
		set rate = 'Average product quality';
	elseif rating <= 5 then
		set rate = 'Good quality product';
	end if;
    return rate;
End $$
Delimiter ;

select dress_id, rating, rate_flag(rating) from Attribute_DataSet group by dress_id;

select dress_id, rating, rate_flag(rating) from Attribute_DataSet group by dress_id order by rating;


