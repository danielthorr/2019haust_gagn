drop database if exists PivotDemo;
create database PivotDemo;
use PivotDemo;

drop table if exists Sales;
drop table if exists EmployeeOfTheMonth;


create table Sales
(
	salesID int auto_increment primary key,
	salesYear int,
	salesMonth int,
	salesDivision int,
	sale decimal(10,2)
);
create table EmployeeOfTheMonth
(
	eomYear int not null,
	eomMonth int not null,
	eomName varchar(20)
);

insert into Sales(salesYear,salesMonth,salesDivision,sale)
values(2006,1,100,129038.50),
      (2006,1,200,122335.80),
      (2006,1,300,79228.30),
      (2006,1,400,334897.00),
      (2006,1,500,122335.80),
      (2006,2,100,129038.50),
      (2006,2,200,124435.80),
      (2006,2,300,74568.30),
      (2006,2,400,334897.00),
      (2006,2,500,432335.80),
      (2006,3,100,429038.50),
      (2006,3,200,92335.80),
      (2006,3,300,379228.30),
      (2006,3,400,334444.70),
      (2006,3,500,126335.80),
      (2006,4,100,99038.50),
      (2006,4,200,122335.80),
      (2006,4,300,179228.30),
      (2006,4,400,234897.00),
      (2006,4,500,222335.80),
      (2006,5,100,129038.50),
      (2006,5,200,122335.80),
      (2006,5,300,279228.30),
      (2006,5,400,334897.00),
      (2006,5,500,122335.00),
      (2006,6,100,329038.50),
      (2006,6,200,322335.80),
      (2006,6,300,479228.30),
      (2006,6,400,434897.00),
      (2006,6,500,422335.00),
      (2007,1,100,129038.50),
      (2007,1,200,122335.80),
      (2007,1,300,79228.30),
      (2007,1,400,634897.00),
      (2007,1,500,122335.80),
      (2007,2,100,729038.50),
      (2007,2,200,424435.80),
      (2007,2,300,74568.30),
      (2007,2,400,334897.00),
      (2007,2,500,432335.80),
      (2007,3,100,429038.50),
      (2007,3,200,92335.80),
      (2007,3,300,379228.30),
      (2007,3,400,334444.70),
      (2007,3,500,86335.80),
      (2007,4,100,99038.50),
      (2007,4,200,322335.80),
      (2007,4,300,179228.30),
      (2007,4,400,234897.00),
      (2007,4,500,222335.80),
      (2007,5,100,229038.50),
      (2007,5,200,122335.80),
      (2007,5,300,279228.30),
      (2007,5,400,334897.00),
      (2007,5,500,122335.00),
      (2007,6,100,329038.50),
      (2007,6,200,322335.80),
      (2007,6,300,479228.30),
      (2007,6,400,134897.00),
      (2007,6,500,122335.00),
      (2008,1,100,129038.50),
      (2008,1,200,122335.80),
      (2008,1,300,79228.30),
      (2008,1,400,334897.00),
      (2008,1,500,122335.80),
      (2008,2,100,129038.50),
      (2008,2,200,94435.80),
      (2008,2,300,9568.30),
      (2008,2,400,94897.00),
      (2008,2,500,432335.80),
      (2008,3,100,429038.50),
      (2008,3,200,92335.80),
      (2008,3,300,379228.30),
      (2008,3,400,334444.70),
      (2008,3,500,96335.80),
      (2008,4,100,99038.50),
      (2008,4,200,92335.80),
      (2008,4,300,99228.30),
      (2008,4,400,94897.00),
      (2008,4,500,222335.80),
      (2008,5,100,129038.50),
      (2008,5,200,122335.80),
      (2008,5,300,279228.30),
      (2008,5,400,334897.00),
      (2008,5,500,122335.00),
      (2008,6,100,99038.50),
      (2008,6,200,322335.80),
      (2008,6,300,179228.30),
      (2008,6,400,434897.00),
      (2008,6,500,422335.00),
      (2009,1,100,129038.50),
      (2009,1,200,122335.80),
      (2009,1,300,79228.30),
      (2009,1,400,334897.00),
      (2009,1,500,122335.80),
      (2009,2,100,129038.50),
      (2009,2,200,124435.80),
      (2009,2,300,74568.30),
      (2009,2,400,674897.00),
      (2009,2,500,232335.80),
      (2009,3,100,239038.50),
      (2009,3,200,56335.80),
      (2009,3,300,379228.30),
      (2009,3,400,564444.70),
      (2009,3,500,126335.80),
      (2009,4,100,99038.50),
      (2009,4,200,562335.80),
      (2009,4,300,179228.30),
      (2009,4,400,564897.00),
      (2009,4,500,562335.80),
      (2009,5,100,129038.50),
      (2009,5,200,122335.80),
      (2009,5,300,279228.30),
      (2009,5,400,334897.00),
      (2009,5,500,122335.00),
      (2009,6,100,329038.50),
      (2009,6,200,322335.80),
      (2009,6,300,819228.30),
      (2009,6,400,74897.00),
      (2009,6,500,72335.00),
      (2010,1,100,129038.50),
      (2010,1,200,122335.80),
      (2010,1,300,79228.30),
      (2010,1,400,334897.00),
      (2010,1,500,122335.80),
      (2010,2,100,129038.50),
      (2010,2,200,124435.80),
      (2010,2,300,74568.30),
      (2010,2,400,334897.00),
      (2010,2,500,432335.80),
      (2010,3,100,429038.50),
      (2010,3,200,92335.80),
      (2010,3,300,379228.30),
      (2010,3,400,334444.70),
      (2010,3,500,126335.80),
      (2010,4,100,99038.50),
      (2010,4,200,122335.80),
      (2010,4,300,179228.30),
      (2010,4,400,234897.00),
      (2010,4,500,222335.80),
      (2010,5,100,129038.50),
      (2010,5,200,122335.80),
      (2010,5,300,279228.30),
      (2010,5,400,334897.00),
      (2010,5,500,122335.00),
      (2010,6,100,329038.50),
      (2010,6,200,1000335.80),
      (2010,6,300,100228.30),
      (2010,6,400,100897.00),
      (2010,6,500,100335.00),
      (2011,1,100,129038.50),
      (2011,1,200,122335.80),
      (2011,1,300,79228.30),
      (2011,1,400,334897.00),
      (2011,1,500,122335.80),
      (2011,2,100,129038.50),
      (2011,2,200,124435.80),
      (2011,2,300,74568.30),
      (2011,2,400,334897.00),
      (2011,2,500,432335.80),
      (2011,3,100,429038.50),
      (2011,3,200,92335.80),
      (2011,3,300,379228.30),
      (2011,3,400,334444.70),
      (2011,3,500,126335.80),
      (2011,4,100,99038.50),
      (2011,4,200,122335.80),
      (2011,4,300,179228.30),
      (2011,4,400,234897.00),
      (2011,4,500,222335.80),
      (2011,5,100,129038.50),
      (2011,5,200,122335.80),
      (2011,5,300,279228.30),
      (2011,5,400,334897.00),
      (2011,5,500,122335.00),
      (2011,6,100,329038.50),
      (2011,6,200,322335.80),
      (2011,6,300,479228.30),
      (2011,6,400,434897.00),
      (2011,6,500,422335.00),
      (2012,1,100,129038.50),
      (2012,1,200,122335.80),
      (2012,1,300,79228.30),
      (2012,1,400,334897.00),
      (2012,1,500,122335.80),
      (2012,2,100,129038.50),
      (2012,2,200,124435.80),
      (2012,2,300,74568.30),
      (2012,2,400,334897.00),
      (2012,2,500,432335.80),
      (2012,3,100,59038.50),
      (2012,3,200,5335.80),
      (2012,3,300,59228.30),
      (2012,3,400,334444.70),
      (2012,3,500,56335.80),
      (2012,4,100,99038.50),
      (2012,4,200,122335.80),
      (2012,4,300,179228.30),
      (2012,4,400,54897.00),
      (2012,4,500,222335.80),
      (2012,5,100,129038.50),
      (2012,5,200,52335.80),
      (2012,5,300,279228.30),
      (2012,5,400,334897.00),
      (2012,5,500,122335.00),
      (2012,6,100,329038.50),
      (2012,6,200,322335.80),
      (2012,6,300,479228.30),
      (2012,6,400,434897.00),
      (2012,6,500,422335.00);

insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2006,1,'Ómar');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2006,2,'Bragi');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2006,3,'Ósk');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2006,4,'Hildur');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2006,5,'Anna');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2006,6,'Ingibjörg');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2006,7,'Ingibjörg');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2006,8,'Íris');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2006,9,'Guðrún');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2006,10,'Karen');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2006,11,'Sólveig');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2006,12,'Kristín');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2007,1,'Kristín');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2007,2,'Karen');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2007,3,'Dagur');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2007,4,'Ingibjörg');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2007,5,'Íris');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2007,6,'Ómar');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2007,7,'Guðrún');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2007,8,'Sólveig');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2007,9,'Magnús');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2007,10,'Ásdís');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2007,11,'Hildur');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2007,12,'Sigurður');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2008,1,'Þuríður');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2008,2,'Ásdís');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2008,3,'Bragi');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2008,4,'Birgir');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2008,5,'Magnús');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2008,6,'Magnús');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2008,7,'Magnús');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2008,8,'Ásdís');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2008,9,'Ósk');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2008,10,'Bragi');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2008,11,'Sólveig');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2008,12,'Sólveig');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2009,1,'Bragi');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2009,2,'Anna');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2009,3,'Kristín');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2009,4,'Margrét');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2009,5,'Halldór');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2009,6,'Júlíus');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2009,7,'Sólveig');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2009,8,'Kristín');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2009,9,'Birgir');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2009,10,'Hildur');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2009,11,'Orri');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2009,12,'Halldór');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2010,1,'Margrét');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2010,2,'Dagur');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2010,3,'Orri');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2010,4,'Dagur');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2010,5,'Páll');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2010,6,'Guðný');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2010,7,'Dagur');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2010,8,'Orri');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2010,9,'Kristín');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2010,10,'Sigurður');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2010,11,'Hildur');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2010,12,'Ingibjörg');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2011,1,'Íris');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2011,2,'Orri');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2011,3,'Guðrún');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2011,4,'Guðrún');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2011,5,'Anna');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2011,6,'Magnús');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2011,7,'Íris');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2011,8,'Íris');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2011,9,'Ásdís');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2011,10,'Ómar');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2011,11,'Dagur');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2011,12,'Kristín');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2012,1,'Ósk');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2012,2,'Ingibjörg');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2012,3,'Halldór');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2012,4,'Íris');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2012,5,'Ásdís');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2012,6,'Birgir');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2012,7,'Sólveig');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2012,8,'Magnús');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2012,9,'Birgir');
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2012,10,null);
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2012,11,null);
insert into EmployeeOfTheMonth(eomYear,eomMonth,eomName)values(2012,12,null);

-- ============================================ Demóin sjálf -- =================================== --

-- Hérna er svo Pivot taflan búin til með því að grúppa eftir sölumánuði(salesMonth)
select salesMonth,
sum(case salesYear when 2006 then sale end) as '2006',
sum(case salesYear when 2007 then sale end) as '2007',    
sum(case salesYear when 2008 then sale end) as '2008',    
sum(case salesYear when 2009 then sale end) as '2009',
sum(case salesYear when 2010 then sale end) as '2010',
sum(case salesYear when 2011 then sale end) as '2011', 
sum(case salesYear when 2012 then sale end) as '2012'
from Sales
group by salesMonth;

-- Könnum hvort sölusumman fyrir janúarmánuð 2006 sé sú sama og við fáum í Pivot-fyrirspurninni
select SUM(sale) from Sales where salesYear = 2006 and salesMonth = 1;

-- Summan sem tekin er í Pivot útgáfunni
select salesYear,salesMonth, SUM(sale) as Summa from Sales
group by salesYear,salesMonth;

-- ============================ DÆMI 2 (Employee of the month)=================================

-- Grúppað eftir mánuði
select eomMonth,
	min(case eomYear when 2006 then eomName end) as '2006',
	min(case eomYear when 2007 then eomName end) as '2007',    
	min(case eomYear when 2008 then eomName end) as '2008',    
	min(case eomYear when 2009 then eomName end) as '2009',
	min(case eomYear when 2010 then eomName end) as '2010',
	min(case eomYear when 2011 then eomName end) as '2011', 
	min(case eomYear when 2012 then eomName end) as '2012'
from EmployeeOfTheMonth
group by eomMonth;

-- Grúppað eftir ári
select eomYear,
min(case eomMonth when 1 then eomName end) as 'Janúar',
min(case eomMonth when 2 then eomName end) as 'Febrúar',    
min(case eomMonth when 3 then eomName end) as 'Mars',    
min(case eomMonth when 4 then eomName end) as 'Apríl',
min(case eomMonth when 5 then eomName end) as 'Maí',
min(case eomMonth when 6 then eomName end) as 'Júní', 
min(case eomMonth when 7 then eomName end) as 'Júlí',
min(case eomMonth when 8 then eomName end) as 'Ágúst',
min(case eomMonth when 9 then eomName end) as 'September',
min(case eomMonth when 10 then eomName end) as 'Október',
min(case eomMonth when 11 then eomName end) as 'Nóvember',
min(case eomMonth when 12 then eomName end) as 'Desember'
from EmployeeOfTheMonth
group by eomYear;


-- Grúppum eftir ári með nöfn (nokkurra)starfsmanna sem dálkaheiti 
select eomYear,
min(case eomName when 'Anna' then eomMonth end) as 'Anna',
min(case eomName when 'Ásdís' then eomMonth end) as 'Ásdís',  
min(case eomName when 'Birgir' then eomMonth end) as 'Birgir',     
min(case eomName when 'Bragi' then eomMonth end) as 'Bragi',
min(case eomName when 'Dagur' then eomMonth end) as 'Dagur'  
from EmployeeOfTheMonth
group by eomYear;


-- Tékkum á gagnasafninu.
select distinct eomName from EmployeeOfTheMonth order by eomName;
select * from EmployeeOfTheMonth;