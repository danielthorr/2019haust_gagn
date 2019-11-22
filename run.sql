delimiter $$
drop procedure if exists cursorTest$$

create procedure cursorTest(inout cNumList varchar(255))
begin
    declare finished integer default 0;
    declare cNumber char(6) default "";

    declare tmpCurs cursor for select courseNumber from Courses;
    declare continue handler
        for not found set finished = 1;
    open tmpCurs;

    getCourses: loop
        fetch tmpCurs into cNumber;
        if finished = 1 then
            leave getCourses;
        end if;
        set cNumList = concat(cNumber, ";", cNumList);
    end loop getCourses;
end$$

set @cNumList = ""$$
call cursorTest(@cNumList)$$
select @cNumList$$

delimiter ;