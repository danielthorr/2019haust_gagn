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
drop procedure if exists GetStudent$$
create procedure GetStudent(in stID int)
begin
    Select 
        st.studentID, st.firstName, st.lastName, st.dob, sem.semesterName
    from Students st 
    inner join Semesters sem on st.startSemester = sem.semesterID 
    where studentID = stID;
end$$
drop procedure if exists GetAllStudents$$
create procedure GetAllStudents()
begin
    Select 
        st.studentID, st.firstName, st.lastName, st.dob, sem.semesterName
    from Students st 
    inner join Semesters sem on st.startSemester = sem.semesterID;
end$$

drop procedure if exists GetStudentCourses$$
create procedure GetStudentCourses(in stID int)
begin
	select courseNumber, passed, semesterID 
	from Registration where studentID = stID order by passed;
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