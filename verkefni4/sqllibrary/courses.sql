/* CRUD 
    Create
    Read
    Update
    Delete 
*/

delimiter $$

/* Create */
drop procedure if exists NewCourse$$
create procedure NewCourse(in couNumber char(10), in couName varchar(75), in couCredits tinyint(4))
begin
    insert into Courses (courseNumber, courseName, courseCredits) 
    values (couNumber, couName, couCredits);
end$$

 /* Read */
drop procedure if exists GetCourse$$
create procedure GetCourse(in couNumber char(10))
begin
    Select 
        courseNumber, courseName, courseCredits
    from Courses where courseNumber = couNumber;
end$$
drop procedure if exists GetAllCourses$$
create procedure GetAllCourses()
begin
    Select 
        courseNumber, courseName, courseCredits
    from Courses;
end$$

/* Update */
drop procedure if exists UpdateCourse$$
create procedure UpdateCourse(
    in couNumber char(10), 
    in newCouNumber char(10), 
    in couName varchar(75)
)
begin
    update Courses set courseNumber = newCouNumber, courseName = couName 
    where courseNumber = couNumber;
end$$

/* Delete */
drop procedure if exists DeleteCourse$$
create procedure DeleteCourse(in couNumber char(10))
begin
    delete from Courses where courseNumber = couNumber;
end$$

delimiter ;