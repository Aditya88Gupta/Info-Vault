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
Call Search_tags("#SQL");