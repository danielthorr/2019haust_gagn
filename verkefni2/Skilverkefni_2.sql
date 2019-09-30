/* 1:
	Smíðið trigger fyrir insert into Restrictors skipunina. 
	Triggernum er ætlað að koma í veg fyrir að einhver áfangi sé undanfari eða samfari síns sjálfs. 
	með öðrum orðum séu courseNumber og restrictorID með sama innihald þá stoppar triggerinn þetta með
	því að kasta villu og birta villuboð.
	Dæmi um insert sem triggerinn á að stoppa: insert into Restrictors values('GSF2B3U','GSF2B3U',1);
*/
delimiter $$
drop trigger if exists ValidateRestrictor$$
create trigger ValidateRestrictor
	before insert on Restrictors 
	for each row
begin
	if (new.courseNumber = new.restrictorID) then
		signal sqlstate '45000' 
		set message_text = 'courseNumber og restrictorID mega ekki vera eins';
	end if;
end$$

delimiter ;



-- 2:
-- Skrifið samskonar trigger fyrir update Restrictors skipunina.
delimiter $$
drop trigger if exists ValidateRestrictorOnUpdate$$
create trigger ValidateRestrictorOnUpdate
	before update on Restrictors 
	for each row
begin
	if (new.courseNumber = new.restrictorID
		or new.courseNumber = old.restrictorID and new.restrictorID is not null
		or old.courseNumber = new.restrictorID and new.courseNumber is not null
		) then
		signal sqlstate '45000' 
		set message_text = 'courseNumber og restrictorID mega ekki vera eins';
	elif ()
	end if;
end$$

delimiter ;

/*
	3:
	Skrifið stored procedure sem leggur saman allar einingar sem nemandinn hefur lokið.
    Birta skal fullt nafn nemanda, heiti námsbrautar og fjölda lokinna eininga(
	Aðeins skal velja staðinn áfanga. passed = true
*/
delimiter $$
drop procedure if exists GetCredits $$

create procedure GetCredits(in studID int)
begin

	select
		concat(s.firstName, " ", s.lastName) as "Name",
		sum(c.courseCredits) as "Total credits",
		c.courseName,
		t.trackName
	from Students s
	join Registration r on r.studentID = s.studentID
	join Tracks t on t.trackID = r.trackID
	join Courses c on c.courseNumber = r.courseNumber
	where s.studentID = studID and r.passed = 1;
	
end$$
call GetCredits(1)$$
delimiter ;


/*
	4:
	Skrifið 3 stored procedure-a:
    AddStudent()
    AddMandatoryCourses()
    Hugmyndin er að þegar AddStudent hefur insertað í Students töfluna þá kallar hann á AddMandatoryCourses() sem skráir alla
    skylduáfanga á nemandann.
    Að endingu skrifið þið stored procedure-inn StudentRegistration() sem nota skal við sjálfstæða skráningu áfanga nemandans.
*/

/* ---------- AddStudent ---------- */
delimiter $$

drop procedure if exists AddStudent$$

create procedure AddStudent(
	in studFirst varchar(55), 
	in studLast varchar(55), 
	in studDOB date
)
begin
	declare semID int;
	set semID = 0;

	select semesterID into semID from Semesters
	where semesterStarts > curdate() and semesterEnds < curdate();

	insert into Students(firstName, lastName, dob, startSemester)
	values (studFirst, studLast, studDOB, semID);

	select * from Students where name = "Daníel";
	delete from Students where name = "Daníel";
	select * from Students where name = "Daníel";

end$$

call AddStudent("Daníel", "Þórisson", "1993-06-08")$$

delimiter ;

/* ---------- AddMandatoryCourses ---------- */
delimiter $$

drop procedure if exists AddMandatoryCourses$$

create procedure AddMandatoryCourses()
begin

end$$

call AddMandatoryCourses()$$

delimiter ;

/* ---------- StudentRegistration ---------- */
delimiter $$

drop procedure if exists StudentRegistration$$

create procedure StudentRegistration()
begin

end$$

call StudentRegistration$$

delimiter ;