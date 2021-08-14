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

