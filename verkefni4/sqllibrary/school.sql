/* CRUD 
    Create
    Read
    Update
    Delete 
*/

delimiter $$

/* Create */
drop procedure if exists NewSchool$$
create procedure NewSchool(in schName varchar(75))
begin
    insert into Schools (schoolName) values (schName);
end$$

 /* Read */
drop procedure if exists GetSchool$$
create procedure GetSchool(in schID int)
begin
    Select 
        schoolID, schoolName
    from Schools where schoolID = schID;
end$$
drop procedure if exists GetAllSchools$$
create procedure GetAllSchools()
begin
    Select 
        schoolID, schoolName
    from Schools;
end$$

/* Update */
drop procedure if exists UpdateSchool$$
create procedure UpdateSchool(in schID int, in schName varchar(75))
begin
    update Schools set schoolName = schName where schoolID = schID;
end$$

/* Delete */
drop procedure if exists DeleteSchool$$
create procedure DeleteSchool(in schID int)
begin
    delete from Schools where schoolID = schID;
end$$

delimiter ;