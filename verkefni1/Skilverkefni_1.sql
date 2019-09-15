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
delimiter $$
drop procedure if exists UpdateCourse $$

create procedure UpdateCourse(
	in cNum char(10),
	in cNumNew char(10), 
	in cName varchar(75), 
	in cCred tinyint(4)
	)
begin

	set foreign_key_checks = 0;
	
	if exists (select courseNumber from Courses where courseNumber = cNum) then
		update Courses 
		set
			courseNumber = cNumNew,
			courseName = cName,
			courseCredits = cCred
		where courseNumber = cNum;
	end if;
	
	if exists (select courseNumber from Restrictors where courseNumber = cNum) then
		update Restrictors set courseNumber = cNumNew
		where courseNumber = cNum;
	end if;

	if exists ( select restrictorID from Restrictors where restrictorID = cNum) then
		update Restrictors set restrictorID = cNumNew
		where restrictorID = cNum;
	end if;

	set foreign_key_checks = 1;

	select row_count();
	-- Ég náði ekki að fá row_count() til þess að virka
end $$
call UpdateCourse("EÐL103", "EÐL102", "Eðlisfræði 1A", 3)$$
delimiter ;


-- 5:
-- ATH: Ef verið er að nota áfangann einhversstaðar(sé hann skráður á TrackCourses töfluna) þá má EKKI eyða honum.
-- Sé hins vegar hvergi verið að nota hann má eyða honum úr bæði Courses og Restrictor töflunum.
delimiter $$
drop procedure if exists DeleteCourse $$

create procedure DeleteCourse(
	in cNum char(10)
	)
begin

	if not exists (select courseNumber from TrackCourses 
		where courseNumber = cNum) then
		
		if exists(select courseNumber from Courses where courseNumber = cNum) then
			delete from Courses where courseNumber = cNum;
		end if;

		if exists(select courseNumber from Restrictors where courseNumber = cNum) then
			delete from Restrictors where courseNumber = cNum;
		end if;

		if exists(select restrictorID from Restrictors where courseNumber = cNum) then
			delete from Restrictors where restrictorID = cNum;
		end if;

	end if;

end $$
call DeleteCourse("TST103")$$
delimiter ;


-- 6:
-- fallið skilar heildarfjölda allra áfanga í grunninum
delimiter $$
drop function if exists NumberOfCourses $$
    
create function NumberOfCourses()
returns int
begin

	declare total int;
	set total = 0;

	select count(courseNumber) into total
	from TrackCourses where mandatory = 1;

	return total;

end $$
select NumberOfCourses()$$
delimiter ;


-- 7:
-- Fallið skilar heildar einingafjölda ákveðinnar námsleiðar(Track)
-- Senda þarf brautarNumer inn sem færibreytu
delimiter $$
drop function if exists TotalTrackCredits $$
    
create function TotalTrackCredits(tID int)
returns int
begin
	declare total int;
	set total = 0;

	select sum(c.courseCredits) into total
	from Courses c
	inner join TrackCourses t on t.courseNumber = c.courseNumber
	where t.trackID = tID;

	return total;

end $$
select TotalTrackCredits(9)$$
delimiter ;


-- 8: 
-- Fallið skilar heildarfjölda áfanga sem eru í boði á ákveðinni námsleið
delimiter $$
drop function if exists TotalNumberOfTrackCourses $$
    
create function TotalNumberOfTrackCourses(tID int)
returns int
begin
	declare total int;
	set total = 0;

	select count(courseNumber) into total
	from TrackCourses where trackID = tID;

	return total;
end $$
select TotalNumberOfTrackCourses(9)$$
delimiter ;


-- 9:
-- Fallið skilar true ef áfanginn finnst í töflunni TrackCourses
delimiter $$
drop function if exists CourseInUse $$
    
create function CourseInUse(course char(10))
returns int
begin
	declare bool int;
	set bool = 0;

	if exists (select courseNumber from TrackCourses 
		where courseNumber = course) then
		set bool = 1;
	end if;

	return bool;

end $$
select CourseInUse("STÆ103")$$
delimiter ;


-- 10:
-- Fallið skilar true ef +arið er hlaupár annars false
delimiter $$
drop function if exists IsLeapyear $$

create function IsLeapYear()
returns boolean
begin
	declare leap int;
	set leap = 0;
	
	if ((select mod(year(curdate()), 4) = 0) and (select mod(year(curdate()), 100) != 0))
		then set leap = 1;
	elseif (select mod(year(curdate()), 400) = 0)
		then set leap = 1;
	else 
		set leap = 0;
	end if;

	return leap;
end $$
select IsLeapYear()$$
delimiter ;


-- 11:
-- Fallið reiknar út og skilar aldri ákveðins nemanda
delimiter $$
drop function if exists StudentAge $$
    
create function StudentAge(studID int)
returns int
begin
	declare age int;
	set age = 0;

	select timestampdiff(year, Students.dob, curdate()) into age
	from Students
	where studentID = studID;

	return age;
end $$
select StudentAge(1)$$
delimiter ;

-- 12:
-- Fallið skilar fjölda þeirra eininga sem nemandinn hefur tekið(lokið)
delimiter $$
drop function if exists StudentCredits $$
    
create function StudentCredits(studID int)
returns int
begin
	declare total int;
	set total = 0;

	select count(passed) into total 
	from Registration
	where passed != 0 and studentID = studID;

	return total;
end $$
select StudentCredits(1)$$
delimiter ;

-- 13:
-- Hér þarf að skila Brautarheiti, heiti námsleiðar(Track) og fjölda áfanga
-- Aðeins á að birta upplýsingar yfir brautir sem hafa námsleiðir sem innihalda áfanga.
delimiter $$
drop procedure if exists TrackTotalCredits $$

create procedure TrackTotalCredits()
begin
	select d.divisionName, t.trackName, count(c.courseNumber) as "Number of courses"
	from Divisions d
	inner join Tracks t on t.divisionID = d.divisionID
	inner join TrackCourses c on c.trackID = t.trackID;
end $$
call TrackTotalCredits()$$
delimiter ;


-- 14:
-- Hér þarf skila lista af öllum áföngum ásamt restrictorum og tegund þeirra.
-- Hafi áfangi enga undanfara eða samfara þá birtast þeir samt í listanum.
delimiter $$
drop procedure if exists CourseRestrictorList $$

create procedure CourseRestrictorList()
begin
	select 
		c.courseNumber as "Course", c.courseCredits as "Credits", 
		r.courseNumber as "Restrictor", r.restrictorType as "Type"
	from Courses c 
	left join Restrictors r on r.courseNumber = c.courseNumber;
end $$
call CourseRestrictorList()$$
delimiter ;


-- 15:
-- RestrictorList birtir upplýsingar um alla restrictora ásamt áföngum.
-- Með öðrum orðum: Gemmér alla restrictora(undanfara, samfara) og þá áfanga sem þeir hafa áhrif á.
delimiter $$
drop procedure if exists RestrictorList $$

create procedure RestrictorList()
begin
	select 
		r.courseNumber as "Restrictor", c.courseNumber as "Course"
	from Restrictors r 
	left join Courses c on c.courseNumber = r.courseNumber;
end $$
call RestrictorList()$$
delimiter ;