delimiter $$
drop trigger if exists ValidateRestrictor$$
create trigger ValidateRestrictor
	before insert on Restrictors 
	for each row
begin
	if (new.courseNumber = new.restrictorID) then
		signal sqlstate '45000' set message_text = 'courseNumber og restrictorID mega ekki vera eins';
	end if;
end$$

delimiter ;