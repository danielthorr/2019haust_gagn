-- ========================================================================== --
--         				 IN AND OUT PARAMETER DEMO 
-- ========================================================================== --

-- 3 töflur til að nota í demói 3:
create table A           
(
	aStuff int not null,
    constraint a_pk primary key(aStuff)
);
create table B           
(
	bStuff int not null,
    constraint a_pk primary key(bStuff)
);
create table C           
(
	cStuff int not null,
    constraint a_pk primary key(cStuff)
);
-- gögn í þessasr þrjár töflur:
insert into A values(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);
insert into B values(11,22,3,48,59,63,57,81,90,101,78,78,15,14,15,16,17,29,81,77,98,99,16,16,4);
insert into C values(1,22,3,48,59,6,57,1,90,101,6,78,15,1,1,16,17,29,8,44,98,99,46,1,4);

-- ==================================== 1 ====================================== --
delimiter $$
drop procedure if exists Thousand_Times_SP $$

create procedure Thousand_Times_SP
(
	in parameter_I int,		-- This guy is a normal parameter.
    out parameter_II int	-- This guy is for "returning" values only.
)
begin
	set parameter_II = parameter_I * 1000;
end $$
delimiter ;

-- Using the procedure:
call Thousand_Times_SP(5,@out_number);
select @out_number;

-- ==================================== 2 ====================================== --

delimiter $$
drop procedure if exists Twothousand_Times_SP $$

create procedure Twothousand_Times_SP
(
    inout parameter_II int	-- This guy works in both directions
)
begin
	set parameter_II = parameter_II * 2000;
end $$
delimiter ;

-- Using the procedure:
set @result_variable = 77;
call Twothousand_Times_SP(@result_variable);
select @result_variable;

-- ==================================== 3 ====================================== --
delimiter $$
drop procedure if exists Some_Data_Info $$

create procedure Some_Data_Info
(
	-- These guys are only out parameters.  There are no in parameters defined.
    out fromA int,
    out fromB int,
    out fromC int
)
begin
	select sum(aStuff) into fromA from A;
    select sum(bStuff) into fromB from B;
    select sum(cStuff) into fromC from C;
end $$
delimiter ;

-- Using the procedure:
call Some_Data_Info(@aa,@bb,@cc);
select @aa,@bb,@cc;



