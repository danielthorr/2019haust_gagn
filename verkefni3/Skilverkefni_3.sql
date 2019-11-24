/*
1:
	Skrifið stored procedure: StudentListJSon() sem notar cursor til að breyta vensluðum gögnum í JSon string.
	JSon-formuð gögnin eru listi af objectum.
	OBS: StudentListJSon skilar texta sem þið hafið formað.

	Niðurstöðurnar ættu að líta einhvern vegin svona út:

	[
		  {"first_name": "Guðrún", "last_name": "Ólafsdóttir", "date_of_birth": "1999-03-31"},
		  {"first_name": "Andri Freyr", "last_name": "Kjartansson", "date_of_birth": "2000-11-01"},
		  {"first_name": "Tinna Líf", "last_name": "Björnsson", "date_of_birth": "1998-08-14"},
		  {"first_name": "Magni Þór", "last_name": "Sigurðsson", "date_of_birth": "2000-05-27"},
		  {"first_name": "Rheza Már", "last_name": "Hamid-Davíðs", "date_of_birth": "2001-09-17"},
		  {"first_name": "Hadría Gná", "last_name": "Schmidt", "date_of_birth": "1999-07-29"},
		  {"first_name": "Jasmín Rós", "last_name": "Stefánsdóttir", "date_of_birth": "1996-02-29"}
	]
*/
delimiter $$
drop procedure if exists StudentListJSon$$

create procedure StudentListJSon(inout jsonString varchar(1000))
begin
    /* Finished is our way of ending a loop when the cursor has finished */
    declare finished integer default 0;
    declare storeFetch varchar(200) default "";

    /* Just to cut down on the total amount of work that I need to do
    to get the data into a json format, I try to concatenate everything together
    in this select statement */
    declare studCurs cursor for 
        select concat(
            '"first_name": ',
            '"',firstName,'", ',
            '"last_name": ', 
            '"',lastName,'", ',
            '"date_of_birth": ', 
            '"',dob,'"'
            )
            from Students;
    declare continue handler
        for not found set finished = 1;
    
    open studCurs;

    /* Start the json string off with an opening bracket [ */
    set jsonString = "[ ";
    loopRows: loop
        fetch studCurs into storeFetch;
        /* Add the fetched data to the jsonString variable and add some curly braces */
        set jsonString = concat(jsonString, "{", storeFetch, "}");
        if finished = 1
            then leave loopRows;
        end if;

        /* We need to append a comma at the end of each row UNLESS it's the last row */
        set jsonString = concat(jsonString, ",");
    end loop loopRows;

    close studCurs;

    /* End the procedure by add a closing bracket to the string */
    set jsonString = concat(jsonString, " ]");
end$$

set @jsonString = ""$$
call StudentListJSon(@jsonString)$$
select @jsonString$$

delimiter ;

/* ################################################################################
	 --------------------------------------------------------------------------------
	 ################################################################################
	2:
	Skrifið nú SingleStudentJSon()þannig að nemandinn innihaldi nú lista af þeim áföngum sem hann hefur tekið.
	Śé nemandinn enn við nám þá koma þeir áfangar líka með.
	ATH: setjið nemandann sem object.
	Líkleg niðurstaða:

	{
		"student_id": "1",
		"first_name": "Guðrún",
		"last_name": "Ólafsdóttir",
		"date_of_birth": "1999-03-31",
		"courses" :[
		  {"course_number": "STÆ103","course_credits": "5","status": "pass"},
		  {"course_number": "EÐL103","course_credits": "5","status": "pass"},
		  {"course_number": "STÆ203","course_credits": "5","status": "pass"},
		  {"course_number": "EÐL203","course_credits": "5","status": "pass"},
		  {"course_number": "STÆ303","course_credits": "5","status": "pass"},
		  {"course_number": "GSF2A3U","course_credits": "5","status": "pass"},
		  {"course_number": "FOR3G3U","course_credits": "5","status": "pass"},
		  {"course_number": "GSF2B3U","course_credits": "5","status": "pass"},
		  {"course_number": "GSF3B3U","course_credits": "5","status": "fail"},
		  {"course_number": "FOR3D3U","course_credits": "5","status": "fail"}
		]
	}
*/
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


/* ################################################################################
	 --------------------------------------------------------------------------------
	 ################################################################################
	3:
	Skrifið stored procedure: SemesterInfoJSon() sem birtir uplýsingar um ákveðið semester.
	Semestrið inniheldur lista af nemendum sem eru /hafa verið á þessu semestri.
	Og að sjálfsögðu eru gögnin á JSon formi!

	Gæti litið út einhvern veginn svona(hérna var semesterID 8 notað á original gögnin:
	[
		{"student_id": "1", "first_name": "Guðrún", "last_name": "Ólafsdóttir", "courses_taken": "2"},
		{"student_id": "2", "first_name": "Andri Freyr", "last_name": "Kjartansson", "courses_taken": "1"},
		{"student_id": "5", "first_name": "Rheza Már", "last_name": "Hamid-Davíðs", "courses_taken": "2"},
		{"student_id": "6", "first_name": "Hadríra Gná", "last_name": "Schmidt", "courses_taken": "2"}
	]
*/


-- ACHTUNG:  2 og 3 nota líka cursor!

delimiter $$

drop procedure if exists SemesterInfoJson $$

create procedure SemesterInfoJson(in semID int, inout jsonString varchar(1000))
begin

    /* Finished is our way of ending a loop when the cursor has finished 
    I'm using different numbers to represent completion for different cursors.*/
    declare finished tinyint default 0;

    declare storeSID int default null;
    declare storeFirst varchar(20) default "";
    declare storeLast varchar(20) default "";
    declare storeCourseCount int default 0;

    declare concatString varchar(200) default "";

    /* ---- Cursor with select ---- */
    declare semCursor cursor for
        select
            s.studentID, s.firstName, s.lastName, count(r.studentID) 
        from Registration r 
        inner join Students s on s.studentID = r.studentID 
        group by r.studentID;

    /* ---- Cursor handler ---- */
    declare continue handler
        for not found set finished = 1;

    /* ---- Open the cursor and loop through the data ---- */
    open semCursor;
    loopStudents: loop
        fetch semCursor into storeSID, storeFirst, storeLast, storeCourseCount;
        set jsonString = concat(
            '{',
            '"student_id": ',
            concat('"', storeSID, '", '),
            '"first_name": ',
            concat('"', storeFirst, '", '),
            '"last_name": ',
            concat('"', storeLast, '", '),
            '"courses_taken": ',
            concat('"', storeCourseCount, '"'),
            '}'
        );

        if finished = 1 
            then leave loopStudents;
        end if;
        
        /* We need to append a comma at the end of each row UNLESS it's the last row */
        set jsonString = concat(jsonString, ",");
    end loop loopStudents;

    close semCursor;

    /* Prepend and append opening and closing brackets */
    set jsonString = concat("[ ", jsonString, " ]");
end;

set @jsonString = ""$$
call SemesterInfoJSon(3, @jsonString)$$
select @jsonString$$

delimiter ;