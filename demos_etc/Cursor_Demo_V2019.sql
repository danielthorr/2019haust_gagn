delimiter $$
drop procedure if exists StudentListXML $$

create procedure StudentListXML()
begin
	-- breyta til að geyma nemandanúmerið (studentID)
    declare student_id int;
	-- breyta til að geyma nafn nemanda
	declare student_name varchar(125);
    -- breyta til að geyma fæðingardag
	declare student_dob date;
    -- Þessi breyta geymir XML-textann sem á að búa til.
    declare student_xml text;
    
	-- stoppbreytan fyrir cursor lúppuna skilgreindur
	declare done int default false;
	-- cursorinn sjálfur skilgreindur með tilheyrandi fyrirspurn
	declare studentCursor cursor 
		for select studentID,concat(firstName,' ',lastName), dob from Students;
	-- stopp höndlarinn er alltaf skilgreindur á eftir cursornum sjálfum
	declare continue handler for not found set done = true;
    
    set student_xml = '<students>';
	-- við það að opna cursorinn er select fyrirspurnin keyrð.
	open studentCursor;
	-- Nú er kominn aðgangur í hverja einustu röð á það sem að select fyrirspurnin skilaði
	-- og byrjað er að lúppa fremst
	read_loop: loop
		-- innihaldið í viðkomandi röð sett í breyturnar
		fetch studentCursor into student_id,student_name,student_dob;
		-- Tékkað á því hvort allt sé búið
		if done then
		  leave read_loop;
		end if;
		-- Hérna er svo unnið með gögnin í cursornum:
		set student_xml = concat(student_xml,'<student><id>',
							    student_id,'</id><name>',
                                student_name,'</name><dob>',
                                student_dob,'</dob></student>');
	end loop;
	set student_xml = concat(student_xml,'</students>');
    
	close studentCursor; -- cursor'inn endar
    
    select student_xml;	
END $$

delimiter ;

-- Testum cursorinn.
-- ATH: Textastrengurinn er fremur ljótur en ef þið export-ið yfir í xml skrá
-- og notið síðan xml beautyfier á netinu(t.d: https://codebeautify.org/xmlviewer)
-- þá getið þið séð gögnin eins og þau eiga að vera!
call StudentListXML();

