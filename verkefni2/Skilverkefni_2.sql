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
drop procedure if exists GetEiningar $$

create procedure GetEiningar(in )
begin
	declare total int;
	set total = 0;

	select sum()
end$$
call GetEiningar()$
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

