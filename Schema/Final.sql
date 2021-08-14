Use InfoVault;
Delimiter $$
# Drop Procedure New_Department;

Create Procedure Show_Department()
Begin
Select * from Department;
End $$

Create Procedure New_Department(IN dept_name Varchar(30), In HOD Varchar(50))
Begin 
Insert Into Department 
Values(dept_name,HOD);
End $$


Delimiter ;

# Use InfoVault;

Delimiter $$

Create Procedure Show_Section()
Begin
Select * from Section;
End $$

Create Procedure New_Section(IN Id Varchar(5))
Begin 
Insert Into Section (Sec_Id)
Values(Id);
End $$

Delimiter ;
# Use InfoVault;

# Drop Procedure New_Student;
# Drop Procedure StudentInfo;
# Drop View Student_View;

Create View Student_View As
Select S.Stud_Id, S.Stud_Name, S.Branch, S.Semester, S.YearOfStudy, S.Stud_Points, S.Sec_Id, T.Teacher_Name As Instructor   
From Student S join Manages using(Sec_Id) join Teacher T using(Teacher_Id);

Delimiter $$

Create Procedure Get_Stud_Count(Out X Int)
Begin 
Select Count(*) Into X From Student;
Set X = X+1; 
End $$

Create Procedure Create_Id(Out temp Varchar(10))
Begin 
Call Get_Stud_Count(@X);
Set temp = concat("S",@X);
End $$

Create Procedure StudentInfo(In Id Varchar(10))
Begin
Select * From Student_View S
Where S.Stud_Id = Id;
End $$

Create Procedure New_Student(In SName Varchar(50), In Sem Int, In Study Int, 
                             In batch Varchar(5), In dept Varchar(30), In pass Varchar(50))
Begin
Call Create_Id(@Id);
Insert Into Student (Stud_Id,Stud_Name,Semester,YearOfStudy,Sec_Id,Branch,Stud_Password)
Values(@Id,SName,Sem,Study,batch,dept,pass);
End $$                             


Create Trigger Add_Stud
After Insert On Student
For Each Row 
Update Section As S
Set S.NumOfStudents = S.NumOfStudents+1;


Delimiter ;

# Use InfoVault;

# Drop Procedure New_Department;

Create VIEW teacher_view as
select t.Teacher_Id, t.Teacher_name,t.dept_name,m.Sec_id 
from Teacher t, Manages m
where t.Teacher_Id=m.Teacher_Id;

Delimiter $$

Create Procedure Get_Teacher_Count(Out X Int)
Begin 
Select Count(*) Into X From Teacher;
Set X = X+1; 
End $$

Create Procedure Create_Teacher_Id(Out temp Varchar(10))
Begin 
Call Get_Teacher_Count(@X);
Set temp = concat("T",@X);
End $$


Create Procedure Show_Teacher(in Id Varchar(10))
Begin
Select * from teacher_view
where Teacher_Id=Id;
End $$

Create Procedure New_Teacher(IN Teacher_name Varchar(50),IN dept_name Varchar(30),
                             In pass Varchar(50))
Begin 
Call Create_Teacher_Id(@Id);
Insert Into Teacher 
Values(@Id,Teacher_name,dept_name,pass);
End $$


Delimiter ;

Use InfoVault;


Create View View_Ques As
Select Q.Ques_Id, Q.Content, Q.Upvotes, A.Person_Id As "Asked By", Q.Num_of_answers
From Questions Q join AskedBy A using(Ques_Id);

Delimiter $$

/*Create Procedure Set_Id(Out temp Varchar(10))
Begin 
Call Get_Id(@X);
Set temp = @X;
End $$*/

Create Procedure Show_Question(In Id Int)
Begin
Select * from View_Ques
Where Ques_Id = Id;
End $$

Create Procedure New_Question(In content Varchar(100), In Tag Varchar(15), In Person_Id Varchar(10))
Begin 
# Set @Tag = Tagged; 
# Call Get_QuesId(@Id);
Set @P_Id = Person_Id; 
Insert Into Questions (Content,tag_name)
Values(content,Tag);
End $$

Create procedure count_upvotes_ques(In id int)
Begin
select Upvotes from Questions
where Ques_Id= id;
End $$

Create procedure update_upvotes_ques(In id int)
Begin
update Questions
set upvotes=upvotes+1
where Ques_Id= id;
End $$

Delimiter ;

Create Trigger Add_Ques
After Insert On Questions
For Each Row 
# Call Get_Id(@P_Id); Create a Global Var for LoggedIN Id 
Insert Into AskedBy (Ques_Id,Person_Id)
Values (New.Ques_Id,@P_Id);

/*Create Trigger Add_Tag
After Insert On Question 
For Each Row 
Insert Into TaggedUnder (Tag_name,Ques_Id)
Values (@Tag,New.Ques_Id);*/

Use InfoVault;

# Drop Procedure New_Department;

Create view answer_view as
Select A.Ques_Id, A.Ans_Id, A.content, A.Upvotes, B.Person_id As "Answered By"
from Answers A join AnswesedBy B using(Ans_Id);

Delimiter $$
Create Procedure Show_Answers(In id int)
Begin
Select * from answer_view
where Ans_Id=id;
End $$

Create Procedure New_Answers(IN Ques_Id int,IN Ans_Id int,IN Content Varchar(100),In Person_Id Varchar(10))
Begin 
Set @P_Id = Person_Id;
Insert Into Answers (Ques_Id,Ans_Id,Content)
Values (Ques_Id,Ans_Id,Content);
End $$

Create procedure count_answers(In id int)
Begin
Select Count(*) from Answers 
Where Ques_Id = id;
End $$

Create procedure count_upvotes_ans(In id int)
Begin
select Upvotes from Answers
where Ans_Id= id;
End $$

Create procedure update_upvotes_ans(In id int)
Begin
update answers
set upvotes=upvotes+1
where Ans_Id= id;
End $$


Delimiter ;
 
Create trigger Add_ans
After Insert on Answers
for each row
# Call Get_Id(@P_Id); Create a Global Var for LoggedIN Id 
Insert Into answesedby(Ans_Id,Person_id)
Values(New.Ans_Id,@P_Id);

Create trigger Update_Count
After Insert on Answers
for each row
# Call Get_Id(@P_Id); Create a Global Var for LoggedIN Id 
Update Questions Q
Set Num_of_answers = Num_of_answers + 1
Where Q.Ques_Id = New.Ques_Id;

Use InfoVault;

Delimiter $$ 

Create procedure Search_Keyword(In KeyWord Varchar(10))
Begin
Set @ExpressionToFind = concat("%",KeyWord);
Set @ExpressionToFind = concat(@ExpressionToFind,"%");
Select * From View_Ques
Where Content Like  @ExpressionToFind 
Order By Ques_Id Desc 
Limit 5;
End$$

Create procedure Last5()
Begin
Select * From View_Ques
Order By Ques_Id Desc 
Limit 5;
End $$

Delimiter ;
# Call Search_Keyword("SQL?");
Use InfoVault;

Create View View_Tag As 
Select Distinct Q.tag_name From Questions Q;

Delimiter $$
# Drop Procedure New_Department;

Create Procedure Show_Tag()
Begin
Select * from View_Tag;
End $$

/*Create Procedure New_Tag(IN Tag_name Varchar(15),IN Category Varchar(25))
Begin 
Insert Into tags 
Values(Tag_name,Category);
End $$*/

Create Procedure Search_tags(In tag Varchar(15))
begin
select Content, Upvotes from questions where  tag_name=tag;
end $$



Delimiter ;
# Call Search_tags("#SQL");
Use InfoVault;

Delimiter $$

Create Procedure Show_Course()
Begin
Select * from Course;
End $$

Create Procedure New_Course(IN Id Varchar(10), In title Varchar(25), In credits Int)
Begin 
Insert Into Course (Course_Id,Title,Credits)
Values(Id,title,credits);
End $$


  Delimiter ;
  Delimiter $$
  CREATE procedure show_comments(in id int)
  BEGIN
  select Content from Comments_ans where Ans_Id=id;
  END$$

  Create PROCEDURE insert_comments(in content varchar(100), in id int)
  BEGIN
  insert into Comments_ans(Content,Ans_Id) values(content,id);
  END$$

  Delimiter ;
  Delimiter $$
  CREATE procedure show_comments_ques(in id int)
  BEGIN
  select Content from Comments_ques where Ques_Id=id;
  END$$

  Create PROCEDURE insert_comments_ques(in content varchar(100), in id int)
  BEGIN
  insert into Comments_ques(Content,ques_Id) values(content,id);
  END$$

  Delimiter ;