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