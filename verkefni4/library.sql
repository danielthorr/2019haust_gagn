 /*
  * RegisterStudent()
  * AssignToCourse()
  * CreateCourse()
  * AssignRestrictor()
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  */

delimiter $$

drop procedure if exists RegisterStudent $$
create procedure RegisterStudent(
    in fName varchar(55), 
    in lName varchar(55), 
    in dateOfBirth date, 
    in startSem int
    )
begin
    insert into Students (firstName, lastName, dob, startSemester)
    values (fName, lName, dateOfBirth, startSem);
end $$

delimiter ;