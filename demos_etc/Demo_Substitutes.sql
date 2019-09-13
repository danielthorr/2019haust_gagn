-- Notum staðgenglaheiti á töflurnar.  C1 og C2 er til að "plata" gaganagrunninn 
-- þannig að hann haldi að Courses talan sé í raun tvær töflur (með sama innihaldi).
-- Að setja R sem staðgengilsheiti á Restrictors töfluna er meira svona til að þetta
-- look-i betur en hefur ekki neina þýðingu á fyrirspurnarniðurstöðuna. :-)
-- Nýju dálkaheitin Course og Restricted_by eru faktískt líka staðgengilsheiti en virka 
-- bara á þá dálka sem birtast og eru bara kosmetík sem gerir niðurstöðurnar meira læsilegar.
select C1.courseNumber as Course, C2.courseNumber as Restricted_by
from Courses C1
inner join Restrictors R on C1.courseNumber = R.courseNumber
inner join Courses C2 on R.restrictorID = C2.courseNumber;


-- Ef við skoðum niðurstöðurna hér þá sjáum við að áfanginn GSF3A3U
-- er Restricted by GSF2B3U en einnig GSF3B3U.
-- Eiginlega þyrftum við að sýna týpuna af restrictornum líka til að gera niðurstöðurnar 
-- nákvæmnari:
select C1.courseNumber as Course, C2.courseNumber as Restricted_by, R.restrictorType as Restrictor_Type
from Courses C1
inner join Restrictors R on C1.courseNumber = R.courseNumber
inner join Courses C2 on R.restrictorID = C2.courseNumber;


-- Tegund restrictor-a kemur núna með en er ekki neitt sérstaklega upplýsandi þar sem um kóðun á upplýsingum er 
-- að ræða og sú kóðun er ekki geymd í þessari frum hönnun á gagnagrunninum.
-- Við erum líklega með kóðunina 1 = undafari, 2 = bundinn samfari og 3 = valkvæður samfari.  
-- Það er mögulegt að nýta þessar upplýsingar í fyrirspurninni og nota case when strúktúr til að 
-- sækja þessar upplýsingar.
-- Sjálfstætt starfandi svona case when gæti litið svona út:
select courseNumber, restrictorID,
case
    when restrictorType = 1 then "Undanfari"
    when restrictorType = 2 then "Verður að taka samhliða"
    when restrictorType = 3 then "Má taka samhliða"
    else "Óþekkt tegund undanfara"
end as restrictor_type
from Restrictors; 


-- else hlutinn er hafður með ef ske kynni að einhver annar kóði(t.d. rangur innsláttur)
-- væri með og gæti stútað fyrirspurninni.
-- Þá er bara að sameina þessa case fyrirspurn við hina fyrirspurnina og fá út betur
-- nothæfar upplýsingar.
select C1.courseNumber as Course, C2.courseNumber as Restricted_by, 
case
    when R.restrictorType = 1 then "Undanfari"
    when R.restrictorType = 2 then "Verður að taka samhliða"
    when R.restrictorType = 3 then "Má taka samhliða"
    else "Óþekkt tegund undanfara"
end as Restrictor_type
from Courses C1
inner join Restrictors R on C1.courseNumber = R.courseNumber
inner join Courses C2 on R.restrictorID = C2.courseNumber;

-- Ef við rýnur í upplýsingarnar sem koma núna og fókuserum á áfangan GSF3A3U
-- þá kemur greinilega eitthvað fishy í ljós:

-- 'GSF3A3U', 'GSF2B3U', 'Undanfari'
-- 'GSF3A3U', 'GSF3B3U', 'Verður að taka samhliða'
-- 'GSF3B3U', 'GSF3A3U', 'Má taka samhliða'

-- Undanfarinn er alveg eðlilegur(efsta línan) en eitthvað hefur skolast til í skráningu á hinum restrictor-unum :-)
-- Læt ykkur eftir að b-vega þetta og meta og jafnvel koma með hugmyndir um lausn :-)
