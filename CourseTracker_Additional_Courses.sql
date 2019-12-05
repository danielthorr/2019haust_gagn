insert into Courses(courseNumber,courseName,courseCredits)values('NÁT1AU','Líffræði 1',5);
insert into Courses(courseNumber,courseName,courseCredits)values('NÁT2AU','Líffræði 2',5);
insert into Courses(courseNumber,courseName,courseCredits)values('NÁT3AU','Jarðfræði',5);
insert into Courses(courseNumber,courseName,courseCredits)values('NÁT4AU','Veðurfræði',5);
insert into Courses(courseNumber,courseName,courseCredits)values('NÁT4BU','Vistfræði',5);
insert into Courses(courseNumber,courseName,courseCredits)values('EFN3A3U','Efnafræði 1',5);
insert into Courses(courseNumber,courseName,courseCredits)values('EFN3B3U','Efnafræði 2',5);
insert into Courses(courseNumber,courseName,courseCredits)values('EFN3C3U','Efnafræði 3',5);
insert into Courses(courseNumber,courseName,courseCredits)values('VEF3A3U','Vefforritun - Grunnur',5);
insert into Courses(courseNumber,courseName,courseCredits)values('VEF3B3U','Vefforritun - Framhald',5);
insert into Courses(courseNumber,courseName,courseCredits)values('VEF3C3U','Vefforritun - Full Stack',5);
insert into Courses(courseNumber,courseName,courseCredits)values('ROB3A3U','Róbótar - Grunnur',5);
insert into Courses(courseNumber,courseName,courseCredits)values('ROB3B3U','Róbótar - Hönnun og smíði',5);
insert into Courses(courseNumber,courseName,courseCredits)values('ROB3C3U','Róbótar - Forritun',5);
insert into Courses(courseNumber,courseName,courseCredits)values('REK3A3U','Inngangur að rekstrarfræði',5);
insert into Courses(courseNumber,courseName,courseCredits)values('REK3B3U','Stofnun og rekstur smáfyrirtækja',5);
insert into Courses(courseNumber,courseName,courseCredits)values('REK3C3U','Rekstrarumhverfi og styrkjakerfi',5);
insert into Courses(courseNumber,courseName,courseCredits)values('AÐF3A3U','Inngangur að aðferðafræði',5);
insert into Courses(courseNumber,courseName,courseCredits)values('AÐF3B3U','Uppsetning og framkvæmd rannsókna',5);
insert into Courses(courseNumber,courseName,courseCredits)values('AÐF3C3U','Falsfréttir og samfélagsmiðlar',5);
-- ===========================================================================
insert into Restrictors(courseNumber,restrictorID,restrictorType)values('NÁT2AU','NÁT1AU','1');
insert into Restrictors(courseNumber,restrictorID,restrictorType)values('NÁT4BU','NÁT1AU','1');
insert into Restrictors(courseNumber,restrictorID,restrictorType)values('EFN3B3U','EFN3A3U','1');
insert into Restrictors(courseNumber,restrictorID,restrictorType)values('EFN3C3U','EFN3B3U','1');
insert into Restrictors(courseNumber,restrictorID,restrictorType)values('VEF3B3U','VEF3A3U','1');
insert into Restrictors(courseNumber,restrictorID,restrictorType)values('VEF3C3U','VEF3B3U','1');
insert into Restrictors(courseNumber,restrictorID,restrictorType)values('ROB3B3U','ROB3A3U','1');
insert into Restrictors(courseNumber,restrictorID,restrictorType)values('ROB3C3U','ROB3A3U','1');
insert into Restrictors(courseNumber,restrictorID,restrictorType)values('REK3B3U','REK3A3U','1');
insert into Restrictors(courseNumber,restrictorID,restrictorType)values('REK3C3U','REK3A3U','1');


select * from Restrictors;