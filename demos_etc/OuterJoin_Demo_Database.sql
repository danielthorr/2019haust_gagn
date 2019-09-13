-- -----------------------------------------------------
-- 				Database OuterJoinDemo
-- -----------------------------------------------------
drop database if exists OuterJoinDemo;
create database OuterJoinDemo;

use OuterJoinDemo;
-- -----------------------------------------------------
-- 					Table Schools
-- -----------------------------------------------------
create table Schools 
(
  schoolID int auto_increment,
  schoolName varchar(75) not null,
  constraint school_PK primary key(schoolID),
  constraint school_name_UQ unique(schoolName asc)
);
-- -----------------------------------------------------
-- 					Table Workshops
-- -----------------------------------------------------
create table Workshops 
(
  workshopID int auto_increment,
  workshopName varchar(75) not null,
  schoolID int,
  constraint workshop_PK primary key(workshopID),
  constraint workshop_school_FK foreign key(schoolID) references Schools(schoolID)
);
-- -----------------------------------------------------
-- 					Table Schedules
-- -----------------------------------------------------
create table Schedules 
(
  scheduleID int auto_increment,
  startTime datetime,
  endTime datetime,
  roomNo int default 110,
  workshopID int,
  constraint schedule_PK primary key (scheduleID),
  constraint schedule_workshop_FK foreign key(workshopID) references Workshops(workshopID)
);
-- -----------------------------------------------------
-- 							Data
-- -----------------------------------------------------
insert into Schools(schoolName)values('Tækniskólinn');
insert into Schools(schoolName)values('Menntaskólin í Reykjavík');
insert into Schools(schoolName)values('Fjölbrautarskólinn Ármúla');
insert into Schools(schoolName)values('Verkmenntaskólinn á Akureyri');
insert into Schools(schoolName)values('Verzlunarskóli Íslands');

insert into Workshops(workshopName,schoolID)values('Gítarsmíði',1);
insert into Workshops(workshopName,schoolID)values('Fatasaumur',1);
insert into Workshops(workshopName,schoolID)values('Listhönnun',1);
insert into Workshops(workshopName,schoolID)values('Vefforritun',1);
insert into Workshops(workshopName,schoolID)values('Róbótar',1);
insert into Workshops(workshopName,schoolID)values('Forníslenska',2);
insert into Workshops(workshopName,schoolID)values('Latína fyrir byrjendur',2);
insert into Workshops(workshopName,schoolID)values('Español por todos',2);
insert into Workshops(workshopName,schoolID)values('Rafmagn i heimahúsum',4);
insert into Workshops(workshopName,schoolID)values('Málmsmíði fyrir alla',4);
insert into Workshops(workshopName,schoolID)values('Kók í Bauk - Norðlenskur framburður',4);
insert into Workshops(workshopName,schoolID)values('Vefforritun',4);
insert into Workshops(workshopName,schoolID)values('Núvitund í framtíðinni',null);
insert into Workshops(workshopName,schoolID)values('Samfélagsmiðlar og FAKE NEWS!',null);
insert into Workshops(workshopName,schoolID)values('Kökubakstur sem tómstund',null);
insert into Workshops(workshopName,schoolID)values('Matur og mataræði',null);

insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-03-15 17:30:00','2019-03-15 21:30:00',215,1);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-03-16 09:00:00','2019-03-16 17:00:00',215,1);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-03-17 09:00:00','2019-03-17 17:00:00',215,1);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-03-18 17:30:00','2019-03-18 21:30:00',215,1);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-04-06 09:30:00','2019-04-06 15:30:00',12,8);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-04-07 09:30:00','2019-04-07 15:30:00',12,8);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-03-23 09:00:00','2019-03-23 14:00:00',7,11);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-05-05 18:00:00','2019-05-05 22:00:00',529,13);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-03-29 17:00:00','2019-03-29 21:00:00',95,null);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-03-30 09:30:00','2019-03-30 05:30:00',201,15);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-04-11 18:00:00','2019-04-11 22:00:00',101,12);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-04-12 18:00:00','2019-04-12 22:00:00',101,12);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-03-30 09:00:00','2019-03-30 17:00:00',116,5);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-04-06 09:00:00','2019-04-06 17:00:00',116,5);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-05-02 18:00:00','2019-05-02 22:00:00',200,9);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-05-03 18:00:00','2019-05-03 22:00:00',200,9);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-04-27 09:00:00','2019-04-27 14:00:00',15,11);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-05-04 09:00:00','2019-05-04 14:30:00',629,4);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-05-11 09:00:00','2019-05-11 14:30:00',629,4);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-05-18 09:00:00','2019-05-18 14:30:00',629,4);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-05-31 17:30:00','2019-05-31 22:30:00',33,null);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-03-19 17:00:00','2019-03-19 20:00:00',17,7);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-03-20 17:00:00','2019-03-20 20:00:00',17,7);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-03-21 17:00:00','2019-03-21 20:00:00',17,7);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-04-26 17:00:00','2019-04-26 21:00:00',30,null);
insert into Schedules(startTime,endTime,roomNo,workshopID)values('2019-05-24 17:00:00','2019-05-24 21:00:00',30,null);

