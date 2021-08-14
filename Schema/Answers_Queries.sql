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

