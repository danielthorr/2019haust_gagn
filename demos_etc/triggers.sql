-- -------------------------------------- SMÁVEGIS UM TRIGGERA Í MYSQL ----------------------------------

-- 1:  Triggerar eru functions sem gansettar eru(treggered) með SQL skipunum(insert og update)
-- 2:  Triggerar eru skilgreindir til að fara í gang við ákveðna aðgerð í ákveðinni töflu
-- 3:  Triggerar geta farið í gang á undan SQL SQL skipuninni eða efitr(before / after triggerar)
-- 4:  Triggerar hafa aðgang að þeim gögnum sem gefin eru upp í SQL skipunum(new / old)
-- 5:  Margir triggerar á sömu töfluna eru ekki leyfðir í MySQL.


-- Lesefni:  http://www.mysqltutorial.org/mysql-triggers.aspx

drop database if exists Triggerbase;
create database Triggerbase;
use Triggerbase;


-- ------------------------------------PART ONE ------------------------------------------------

-- Týpisk starfsmannatafla (employee table)
create table employees
(
    employeeNumber int(11) not null,
    lastName varchar(50) not null,
    firstName varchar(50) not null,
    extension varchar(10) not null,
    email varchar(100) not null,
    officeCode varchar(10) not null,
    reportsTo int(11) default NULL,
    jobTitle varchar(50) not null,
    primary key(employeeNumber)
);

-- Næstum því týpísk Log- tafla.  
-- Svona audit- töflur eru býsna algengar til að logga alla mögulega hluti
create table employees_audit
(
    id int(11) not null AUTO_INCREMENT,
    employeeNumber int(11) not null,
    lastname varchar(50) not null,
    changedon datetime DEFAULT NULL,
    action varchar(50) DEFAULT NULL,
    primary key (id)
); 

delimiter $$
-- Þessi trigger gerir svo sem ekki mikið en er fínt demó.
-- Hann er skilgreindur til að fara í gang þegar gerð er UPDATE skipun í töflunni employees
create trigger before_employee_update 
before update on employees
for each row 
begin
    insert into employees_audit(employeeNumber,lastname,changedon,action)
    values(old.employeeNumber,old.lastname,NOW(),'update');
end $$

delimiter ;
-- Setjum test data í töfluna employees
insert into employees values(1000,'Doe','John','Mr','doe@fakemail.ru','Headoflice',1000,'Owner');
insert into employees values(1005,'Doe','Jean','Mrs','jdoe@fakemail.edu','Headoflice',1005,'Co Owner');
insert into employees values(1010,'Pan','Peter','Mr','pphan@fakemail.is','Archives',1000,'Employee');

-- Þegar við keyrum þetta update þá fer triggerinn í gang og gerir sitt stöff.
update employees set jobTitle = 'Slave' where employeeNumber = 1005;

-- Tékkum á því hvort eitthvað hefur gerst
select * from employees_audit;
select * from employees;

-- ------------------------------------PART TWO ------------------------------------------------
create table Semester
(
    semesterID int not null auto_increment,
    semesterStart date,
    semesterFinish date,
    semesterName varchar(25),
    constraint semesterPK primary key(semesterID)
);
create table SemesterLog
(
    logID int not null auto_increment,
    logText varchar(125),
    logTime datetime default null,
    constraint semesterlogPK primary key(logID)
);

-- droppum check_semester_dates ef hann er til
drop trigger if exists check_semester_dates_and_logit;

delimiter $$ 

create trigger check_semester_dates_and_logit 
before update on Semester
for each row 
begin
    if(new.semesterFinish < new.semesterStart) then
        insert into SemesterLog(logText,logTime)values('Dagsetningar ekki í lagi',now());
    end if; 
end $$

delimiter ;

-- droppum check_semester_dates aftur ef hann er til og smíðum öðruvísi útgáfu.
drop trigger if exists check_semester_dates_and_logit;
drop trigger if exists check_semester_dates_with_prevention;

delimiter $$

create trigger check_semester_dates_with_prevention 
before insert on Semester
for each row
begin
     declare msg varchar(255);
	 -- tímagildin úr insert skipuninni skoðuð
     if (new.semesterFinish < new.semesterStart) then
			-- Villuskilaboðin undirbúin
            set msg = concat('SemesterFinish must be after SemesterStart', cast(new.semesterFinish as char));
			-- Villu er kastað og villuskilaboðin birt
            signal sqlstate '45000' set message_text = msg;
     end if;
end $$

delimiter ;

-- Setjum gögn í Semester töfluna með insert skipun sem gangsetur trigger
insert into Semester(semesterStart,semesterFinish,semesterName)values('2012-08-01','2012-12-15','Haustönn');
insert into Semester(semesterStart,semesterFinish,semesterName)values('2013-01-01','2012-12-15','Vorönn');
insert into Semester(semesterStart,semesterFinish,semesterName)values('2013-08-01','2012-07-15','Haustönn');

select * from SemesterLog;
select * from Semester;

-- ---------------------------------THE END ----------------------------------------------
