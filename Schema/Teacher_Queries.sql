Use InfoVault;

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