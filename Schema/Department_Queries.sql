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


