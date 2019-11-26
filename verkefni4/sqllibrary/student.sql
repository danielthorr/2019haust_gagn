/* CRUD 
    Create
    Read
    Update
    Delete 
*/

delimiter $$

/* Create */
drop procedure if exists NewStudent$$
create procedure NewStudent(in fName varchar(55), lName varchar(55), dOfBirth date, sSemester int)
begin
    insert into Students(firstName, lastName, dob, startSemester)
    values (fName, lName, dOfBirth, sSemester);
end$$

 /* Read */
drop function if exists GetStudent$$
create function GetStudent(stID int)
returns varchar(160)
begin
    return(
        Select 
        concat_ws("::",st.firstName, st.lastName, st.dob, sem.semesterName)
        from Students st inner join Semesters sem on st.startSemester = sem.semesterID where studentID = stID
    );
end$$

/* Update */
drop procedure if exists UpdateStudent$$
create procedure UpdateStudent(in stID int, in fName varchar(55), in lName varchar(55))
begin
    update Students set firstName = fName, lastName = lName where studentID = stID;
end$$

/* Delete */
drop procedure if exists DeleteStudent$$
create procedure DeleteStudent(in stID int)
begin
    delete from Students where studentID = stID;
end$$

delimiter ;