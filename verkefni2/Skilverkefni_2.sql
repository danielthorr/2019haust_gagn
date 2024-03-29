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

	/* 	Við búum til procedure-in AddStudent og AddMandatoryCourses 
		í öfugri röð af því að það er ekki hægt að kalla 
		á procedure áður en það er skilgreint. */

/* ---------- AddMandatoryCourses ---------- */
delimiter $$

drop procedure if exists AddMandatoryCourses$$

create procedure AddMandatoryCourses(
	in studID int,
	in semID int
)
begin

	declare count int default 0;
	declare maxCount int default (
		select count(*) from TrackCourses
		where mandatory = 1
	);

	while count < maxCount do
		insert into Registration (
			studentID, 
			trackID, 
			courseNumber,
			registrationDate,
			semesterID
			)
		values (
			studID, 
			(select trackID from TrackCourses 
			where mandatory = 1 limit 1 offset count),
			(select courseNumber from TrackCourses 
			where mandatory = 1 limit 1 offset count),
			curdate(),
			semID
			);
		set count = count + 1;
	end while;

end$$

delimiter ;

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
	set semID = (select semesterID from Semesters
	where semesterStarts < curdate() and semesterEnds > curdate());

	insert into Students(firstName, lastName, dob, startSemester)
	values (studFirst, studLast, studDOB, semID);

	call AddMandatoryCourses((select last_insert_id()), semID);

end$$

call AddStudent("Daníel", "Þórisson", "1993-06-08")$$

delimiter ;

/* ---------- StudentRegistration ---------- */
delimiter $$

drop procedure if exists StudentRegistration$$

create procedure StudentRegistration(
	in studID int,
	in cNumber char(10)
	)
begin

	/* Vanalega myndi maður ekki láta notendur slá inn
		auto_increment id en þetta yrði væntanlega tengt 
		við einhverskonar innskráningu eða kennitölu */
	insert into Registration(
		studentID, 
		trackID, 
		courseNumber, 
		registrationDate,
		semesterID
		)
	values 
	(
		studID,
		(select trackID from TrackCourses 
		where courseNumber = cNumber),
		cNumber,
		curdate(),
		(select Semester from TrackCourses 
		where courseNumber = cNumber)
	);

end$$

call StudentRegistration(1, "STÆ103")$$

delimiter ;