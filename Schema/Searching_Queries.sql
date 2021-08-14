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
Call Search_Keyword("SQL?");
