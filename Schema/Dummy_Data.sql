Use InfoVault;
INSERT INTO infovault.department (dept_name, HOD) VALUES ('Mechanical', 'Anuj');
INSERT INTO infovault.department (dept_name, HOD) VALUES ('Bio-Tech', 'Vishrut');
INSERT INTO infovault.department (dept_name, HOD) values ("Computer Science","Deepak Garg");
INSERT INTO infovault.section (Sec_Id, NumOfStudents) VALUES ('EB02', '5');
INSERT INTO infovault.section (Sec_Id) VALUES ('EB01');
INSERT INTO infovault.section (Sec_Id) VALUES ('EB03');
INSERT INTO infovault.section (Sec_Id) VALUES ('EB04');


# call New_Teacher('Panda','Mechanical','1234');
call New_Teacher('Pandi','Computer Science','1234');
call New_Teacher('Mohit','Computer Science','1234');
Insert Into Manages (Teacher_Id,Sec_Id)
Values ("T1","EB01");
Insert Into Manages (Teacher_Id,Sec_Id)
Values ("T2","EB02");


INSERT INTO infovault.course (Course_Id, Title, Credits) VALUES ('C1', 'DS', '5');
INSERT INTO infovault.course (Course_Id, Title, Credits) VALUES ('C2', 'Micro', '4');
INSERT INTO infovault.course (Course_Id, Title, Credits) VALUES ('C3', 'Ims', '4');
INSERT INTO infovault.course (Course_Id, Title, Credits) VALUES ('C4', 'DMS', '3');
INSERT INTO infovault.course (Course_Id, Title, Credits) VALUES ('C5', 'Probability', '4');

INSERT INTO infovault.lecture (Lec_No, Topic, Course_Id) VALUES ('1', 'Education', 'C1');
INSERT INTO infovault.lecture (Lec_No, Topic, Course_Id) VALUES ('2', 'Study', 'C2');

INSERT INTO infovault.teaches (Teacher_Id, Course_Id) VALUES ('T1', 'C1');
INSERT INTO infovault.teaches (Teacher_Id, Course_Id) VALUES ('T2', 'C2');

call New_Student("chinmay",4,2,"EB02","Mechanical","chinky");
call New_Student("Raghav",4,2,"EB01","Computer Science","dramekie");

INSERT INTO infovault.studies (Stud_Id, Course_Id) VALUES ('S1', 'C1');
INSERT INTO infovault.studies (Stud_Id, Course_Id) VALUES ('S2', 'C2');

Call New_Question("What is SQL?","#SQl","S1");
Call Show_Question(1);

# Drop procedure Show_Answers;
Call New_Answers(1,1,"It's Amazing","S2");
Call Show_Answers(1);

Delimiter $$
Create Procedure Find_Id(In Id Varchar(10))
Begin
Case 
When (Id Like "T%") Then Call Show_Teacher(Id);
When (Id Like "S%") Then Call StudentInfo(Id);
End Case;
End $$

Delimiter ;
Call Find_Id("T1");