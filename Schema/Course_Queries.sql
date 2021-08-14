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
