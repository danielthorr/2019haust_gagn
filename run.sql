delimiter $$
drop procedure if exists SingleStudentJSon$$

create procedure SingleStudentJSon(in studID int, inout jsonString varchar(5000))
begin
    /* Going over verkefni 1 I realized I was doing this in an inefficient way
       and I didn't realize how I could utilize the cursor better. 
       This time I changed some things so it is much more efficient. */

    /* Finished is our way of ending a loop when the cursor has finished 
       I'm using different numbers to represent completion for different cursors.*/
    declare finished tinyint default 0;
    declare firstLoop tinyint default 0;

    declare storeFirstN varchar(50) default "";
    declare storeLastN varchar(50) default "";
    declare storeDob varchar(50) default "";
    declare storeCourseN char(10) default "";
    declare storeCourseC tinyint default 0;
    declare storePass varchar(5) default "";

    /* ---- Cursor with select ---- */
    declare studCurs cursor for 
        select
            s.studentID, s.firstName, s.lastName, s.dob,
            c.courseNumber, c.courseCredits,
            (
                case
                    when r.passed = 1 then "pass"
                    when r.passed = 0 then "fail"
                end
            )
        from Students s
        inner join Registration r on s.studentID = r.studentID
        inner join Courses c on r.courseNumber = c.courseNumber
        where s.studentID = 1;

    /* ---- Cursor handler ---- */
    declare continue handler
        for not found set finished = 1;
    
    /* ---- Open the cursor and loop through the data ---- */
    open studCurs;
    loopStudents: loop
        fetch studCurs into studID, storeFirstN, storeLastN, storeDob, storeCourseN, storeCourseC, storePass;

        if firstLoop = 0 then 
            set jsonString = concat(
                jsonString,
                '"first_name": ',
                concat('"', storeFirstN, '", '),
                '"last_name": ',
                concat('"', storeLastN, '", '),
                '"date_of_birth": ',
                concat('"', storeDob, '", '),
                '"courses": ['
            );
            set firstLoop = 1;
        end if;
        
        set jsonString = concat(
            jsonString,
            '{',
            '"course_number": ',
            concat('"', storeCourseN, '", '),
            '"course_credits": ',
            concat('"', storeCourseC, '", '),
            '"status": ',
            concat('"', storePass, '"'),
            '}'
        );

        if finished = 1
            then leave loopStudents;
        end if;

        /* We need to append a comma at the end of each row UNLESS it's the last row */
        set jsonString = concat(jsonString, ",");

    end loop loopStudents;

    /* Finish the "courses: []" property with a closing bracket */
    set jsonString = concat(jsonString, "]");
    
    close studCurs;

    /* Prepend and append opening and closing brackets */
    set jsonString = concat("[ {", jsonString, "} ]");
end$$

set @jsonString = ""$$
call SingleStudentJSon(1, @jsonString)$$
select @jsonString$$

delimiter ;
