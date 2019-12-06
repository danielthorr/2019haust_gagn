-- 1:
-- Skrifið Stored Procedure ElectedCourses
-- Kalla skal á ElectedCourses með nemendanúmeri og hann skilar til baka vali fyrir næstu önn.

-- ATHUGIÐ:
-- Það má alveg takmarka fjölda áfanga sem kerfið velur við t.d. 5 eða einhvern fjölda sem hentar ykkar hönnun.

-- ATTENTION:
-- ElectedCourses þarf að finna þessa áfanga útfrá óloknum áföngum. Skoða þarf hvaða áfangar koma
-- næst. Ef ekki er hægt með góðu móti að finna út hvaða áfangi kemru næst í röðinni þá er bara hægt
-- að velja random 

-- ACHTUNG:
-- Ekki þarf að kanna fall í núverandi áföngum(þeir áfangar sem nemandinn er í en hefur ekki klárað
-- þegar val fer fram).

-- ATTENZIONE:
-- Málið er eiginlega þetta:  Nemandinn er í X áföngum og búinn með Y áfanga.  Hvað getur hann tekið næst



-- 2:
-- Bætið við eða aðlagið klasasafnið ykkar(library) úr verkefni 4 þannig að þig getið prófað þessa virkni úr forriti
-- í viðbót við að testa þetta í grunninum sjálfum!

delimiter $$

-- ###################################################################### --
--                            Attention!                                  --
-- The restrictors table is not set up properly so you often get courses  --
-- courses which should be in the restrictors table                       --
--                                                                        --
-- If I had more time I would like to rewrite this entire procedure       --
-- to be more readable and more efficient but I don't have the time       --
-- ###################################################################### --

drop procedure if exists ElectedCoursesProc$$

create procedure ElectedCoursesProc(in stID int, out returnCourses varchar(60))
begin
  declare finished int default 0;
  declare firstLoop int default 0;
  declare _course char(10) default null;
  declare tmpCourse char(10) default null;
  declare coursesAdded int default 0;
  declare rowCount int default 0;
  declare limitCounter int default 0;
  declare allCourses int default 0;
  declare allCoursesCounter int default 0;

  -- Cursor for courses the student has already completed
  declare curs cursor for 
      select courseNumber 
      from Registration where studentID = stID and passed = 1;
  declare continue handler for
      not found set finished = 1;

  -- Get the number of courses available
  select count(*) into allCourses from Courses;    

  open curs;

  set returnCourses = "";
  -- #### Begin main loop #### --
  loopCourses: loop
      fetch curs into _course;

      -- Get the number of courses that match the student's prerequisites
      select count(courseNumber) into rowCount
          from Restrictors where restrictorID = _course;

      -- #### Begin restrictor loop #### --
      insertCourses: while rowCount > 0 do
          -- We use limitCounter to get one row at a time
          set limitCounter = rowCount - 1;
          select courseNumber into tmpCourse
              from Restrictors where restrictorID = _course
              limit limitCounter, 1;

          -- Checking if the student has already completed this course
          if (select count(*) from Registration 
              where studentID = stID and courseNumber = tmpCourse and passed = 1
              ) = 0 then
              if firstLoop = 0
                  then set returnCourses = tmpCourse;
                  set coursesAdded = coursesAdded + 1;
                  set firstLoop = 1;
              else
                  set returnCourses = concat(returnCourses, "::", tmpCourse);
                  set coursesAdded = coursesAdded + 1;
              end if;
          end if;

          -- If we've added more than 4 courses, we can exit the loop entirely
          if coursesAdded > 4
              then leave loopCourses;
          end if;

          -- Decrement the rowCount counter
          set rowCount = rowCount - 1;
      end while insertCourses;

      -- Reset rowCount just to be safe
      set rowCount = 0;

      -- Check if we have got up to 5 courses and if our cursor has finished
      -- If we haven't gotten 5 courses yet we want to select the first few we find
      if coursesAdded < 5 and finished = 1 then
          -- #### Begin additional loop #### --
          additionalCourses: loop
              -- We use the same limit trick here to get one row at a time
              select courseNumber into tmpCourse from Courses limit allCoursesCounter, 1;
              if (
                      -- Check if the student has already completed this course
                      select count(*) from Registration 
                      where studentID = stID and courseNumber = tmpCourse and passed = 1
                  ) = 0
                      -- Check if the course has a prerequisite before taking it
                      and (select count(*) from Restrictors where courseNumber = tmpCourse) = 0
                      -- Check if our course is already among the courses we assigned
                      and locate(tmpCourse, returnCourses) = 0 
                  then
                  
                  if firstLoop = 0 then
                      set returnCourses = tmpCourse;
                      set coursesAdded = coursesAdded + 1;
                      set firstLoop = 1;
                  else
                      set returnCourses = concat(returnCourses, "::", tmpCourse);
                      set coursesAdded = coursesAdded + 1;
                  end if;
              end if;
              
              if coursesAdded > 4
                  then leave loopCourses;
              end if;

              -- Increment our counter for limit
              set allCoursesCounter = allCoursesCounter + 1;
          end loop additionalCourses;
      end if;

  end loop loopCourses;
  close curs;
end$$

drop procedure if exists ElectedCourses$$
create procedure ElectedCourses(in stID int)
begin
  call ElectedCoursesProc(stID, @tmp);
  select @tmp;
end$$

drop procedure if exists AssignCourse$$
create procedure AssignCourse(in stID int, in crsNumber char(10))
begin
  set foreign_key_checks = 0;
  -- TrackCourses is barely ever used to so I decided to just feed it something
  insert into Registration(studentID, courseNumber, registrationDate) 
  values (stID, crsNumber, CURDATE());
  set foreign_key_checks = 1;
end$$

call ElectedCourses(1)$$


delimiter ;