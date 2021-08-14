  Delimiter $$
  CREATE procedure show_comments(in id int)
  BEGIN
  select Content from Comments_ans where Ans_Id=id;
  END$$

  Create PROCEDURE insert_comments(in content varchar(100), in id int)
  BEGIN
  insert into Comments_ans(Content,Ans_Id) values(content,id);
  END$$

  Delimiter ;