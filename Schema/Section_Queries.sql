Use InfoVault;

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
