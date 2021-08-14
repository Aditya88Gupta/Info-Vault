Use InfoVault;

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

Delimiter ;

Create Trigger Add_Stud
After Insert On Student
For Each Row 
Update Section As S
Set S.NumOfStudents = S.NumOfStudents+1;




