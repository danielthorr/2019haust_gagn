-- select * from Schools;
-- select * from Workshops;
-- select * from Schedules;


-- demo 1:
-- Öll námskeið allra skóla.  Ekkert aukastöff hér!
select Schools.schoolName, Workshops.workshopName
from Schools
inner join Workshops on Schools.schoolID = Workshops.schoolID;


-- demo 2:
-- Við viljum fá að sjá alla skóla og þeirra námskeið en við viljum 
-- líka sjá þá skóla sem ekki eru með nein námskeið í boði.
-- ATH: left outer join-ið vísar hér í töfluna Schools.  Það mætti lesa 
-- út úr því:  Gemmér alla skóla með námskeið og líka þá skóla sem ekki eru með nein.
select Schools.schoolName, Workshops.workshopName
from Schools
left outer join Workshops on Schools.schoolID = Workshops.schoolID;


-- demo 3:
-- Nú ætlum við sjá alla skóla og þeirra námskeið en viljum líka sjá þau námskeið sem ekki
-- er búið að skrá á neinn skóla.
-- Til að gera þetta notum við right outer join sem er eins og að segja að við
-- viljum fá öll námskeið sem einhverjir skólar bjó'ða uppá en l+íka öll skráð námskeið
-- sem ekki tilheyra neinum skóla!
select Schools.schoolName, Workshops.workshopName
from Schools
right outer join Workshops on Schools.schoolID = Workshops.schoolID;


-- demo 4:
-- ATH: Það að breyta einhverju í select-listanum hefur engin áhrif á það hvernig join virka!!
select Workshops.workshopID,Workshops.workshopName,Schools.schoolName
from Schools
right outer join Workshops on Schools.schoolID = Workshops.schoolID;


-- demo 5:
-- Nú viljum við kannske skoða námskeið og stundatöflur þeirra en við viljum líka vita
-- hvort einhver námskeið eru ekki (ennþá) komin með dagsetningar.
select Workshops.workshopName, Schedules.startTime,Schedules.endTime, Schedules.roomNo
from Workshops
left outer join Schedules on Workshops.workshopID = Schedules.workshopID;
