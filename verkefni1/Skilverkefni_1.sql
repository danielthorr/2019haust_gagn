-- 1:
-- Birtið lista af öllum áföngum sem geymdir eru í gagnagrunninum.
-- Áfangarnir eru birtir í stafrófsröð
delimiter $$
drop procedure if exists CourseList $$

create procedure CourseList()
begin
	select 
		courseNumber, courseName, courseCredits
	from
		Courses
	order by courseNumber asc;
end $$
call CourseList$$
delimiter ;


-- 2:
-- Birtið upplýsingar um einn ákveðin áfanga.
delimiter $$
drop procedure if exists SingleCourse $$

create procedure SingleCourse( in course char(10))
begin
	select
		courseNumber, courseName, courseCredits
	from 
		Courses
	where courseNumber = course;
end $$
call SingleCourse("CNA403")$$
delimiter ;


-- 3:
-- Nýskráið áfanga í gagnagrunninn.
-- Það þarf að skrá áfanganúmerið, áfangaheitið og einingafjöldann
delimiter $$
drop procedure if exists NewCourse $$

create procedure NewCourse(
	in cNum char(10), 
	in cName varchar(75), 
	in cCred tinyint(4)
	)
begin
	insert into 
		Courses (courseNumber, courseName, courseCredits)
	values
		(cNum, cName, cCred);
end $$
call NewCourse("TST203", "Test f. procedure", 5)$$
delimiter ;


-- 4:
-- Uppfærið réttan kúrs.
-- row_count() fallið er hér notað til að birta fjölda raða sem voru uppfærðar.
/*delimiter $$
drop procedure if exists UpdateCourse $$

create procedure UpdateCourse(
	in cNumUpdate char(10),
	in cNum char(10), 
	in cName varchar(75), 
	in cCred tinyint(4)
	)
begin
	update 
		Courses
	set
		courseNumber = cNum,
		courseName = cName,
		courseCredits = cCred
	where
		courseNumber = cNumUpdate;
	row_count();
end $$
call UpdateCourse("EÐL103", "EÐL102", "Eðlisfræði 1A", 5)$$
delimiter ;*/


-- 5:
-- ATH: Ef verið er að nota áfangann einhversstaðar(sé hann skráður á TrackCourses töfluna) þá má EKKI eyða honum.
-- Sé hins vegar hvergi verið að nota hann má eyða honum úr bæði Courses og Restrictor töflunum.
delimiter $$
drop procedure if exists DeleteCourse $$

create procedure DeleteCourse()
begin
	-- kóði hér...
end $$
delimiter ;


-- 6:
-- fallið skilar heildarfjölda allra áfanga í grunninum
delimiter $$
drop function if exists NumberOfCourses $$
    
create function NumberOfCourses()
returns int
begin
	-- kóði hér...
end $$
delimiter ;


-- 7:
-- Fallið skilar heildar einingafjölda ákveðinnar námsleiðar(Track)
-- Senda þarf brautarNumer inn sem færibreytu
delimiter $$
drop function if exists TotalTrackCredits $$
    
create function TotalTrackCredits()
returns int
begin
	-- kóði hér...
end $$
delimiter ;


-- 8: 
-- Fallið skilar heildarfjölda áfanga sem eru í boði á ákveðinni námsleið
delimiter $$
drop function if exists TotalNumberOfTrackCourses $$
    
create function TotalNumberOfTrackCourses()
returns int
begin
	-- kóði hér...
end $$
delimiter ;


-- 9:
-- Fallið skilar true ef áfanginn finnst í töflunni TrackCourses
delimiter $$
drop function if exists CourseInUse $$
    
create function CourseInUse()
returns int
begin
	-- kóði hér...
end $$
delimiter ;


-- 10:
-- Fallið skilar true ef +arið er hlaupár annars false
delimiter $$
drop function if exists IsLeapyear $$

create function IsLeapYear()
returns boolean
begin
	-- kóði hér...
end $$
delimiter ;


-- 11:
-- Fallið reiknar út og skilar aldri ákveðins nemanda
delimiter $$
drop function if exists StudentAge $$
    
create function StudentAge()
returns int
begin
	-- kóði hér...
end $$
delimiter ;

-- 12:
-- Fallið skilar fjölda þeirra eininga sem nemandinn hefur tekið(lokið)
delimiter $$
drop function if exists StudentCredits $$
    
create function StudentCredits()
returns int
begin
	-- kóði hér...
end $$
delimiter ;

-- 13:
-- Hér þarf að skila Brautarheiti, heiti námsleiðar(Track) og fjölda áfanga
-- Aðeins á að birta upplýsingar yfir brautir sem hafa námsleiðir sem innihalda áfanga.
delimiter $$
drop procedure if exists TrackTotalCredits $$

create procedure TrackTotalCredits()
begin
	-- kóði hér...
end $$
delimiter ;


-- 14:
-- Hér þarf skila lista af öllum áföngum ásamt restrictorum og tegund þeirra.
-- Hafi áfangi enga undanfara eða samfara þá birtast þeir samt í listanum.
delimiter $$
drop procedure if exists CourseRestrictorList $$

create procedure CourseRestrictorList()
begin
	-- kóði hér...
end $$
delimiter ;


-- 15:
-- RestrictorList birtir upplýsingar um alla restrictora ásamt áföngum.
-- Með öðrum orðum: Gemmér alla restrictora(undanfara, samfara) og þá áfanga sem þeir hafa áhrif á.
delimiter $$
drop procedure if exists RestrictorList $$

create procedure RestrictorList()
begin
	-- kóði hér...
end $$
delimiter ;