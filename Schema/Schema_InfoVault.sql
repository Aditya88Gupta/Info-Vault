Create Database InfoVault;
Use InfoVault;

# Drop Database Infovault;


CREATE TABLE Department (
  dept_name Varchar(30) NOT NULL,
  HOD Varchar(50) NOT NULL,
  PRIMARY KEY (dept_name)
);

CREATE TABLE Section (
  Sec_Id Varchar(5) NOT NULL,
  NumOfStudents INT NOT NULL Default 0,
  PRIMARY KEY (Sec_Id)
);

CREATE TABLE Teacher(
  Teacher_Id Varchar(10) NOT NULL,
  Teacher_Name Varchar(50) NOT NULL,
  dept_name Varchar(30) NOT NULL,
  Teacher_Password Varchar(50) NOT NULL,
  PRIMARY KEY (Teacher_Id),
  FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

Create Table Manages (
  Teacher_Id Varchar(10) NOT NULL,
  Sec_Id Varchar(5) NOT NULL,
  Primary Key (Sec_Id,Teacher_Id),
  foreign key(Sec_Id) references Section(Sec_Id),
  foreign key(Teacher_Id) references Teacher(Teacher_Id)
);

CREATE TABLE Course (
  Course_Id Varchar(10) NOT NULL,
  Title Varchar(25) NOT NULL,
  Credits INT NOT NULL,
  # Prereq_id_Course_Id Varchar(10) Default "None",
  PRIMARY KEY (Course_Id)
  # FOREIGN KEY (Prereq_id_Course_Id) REFERENCES Course(Course_Id)
);

CREATE TABLE Lecture (
  Lec_No INT NOT NULL,
  Topic Varchar(25) NOT NULL,
  Course_Id Varchar(10) NOT NULL,
  PRIMARY KEY (Lec_No),
  FOREIGN KEY (Course_Id) REFERENCES Course(Course_Id)
);

CREATE TABLE Teaches (
  Teacher_Id Varchar(10) NOT NULL,
  Course_Id Varchar(25) NOT NULL,
  PRIMARY KEY (Teacher_Id, Course_Id),
  FOREIGN KEY (Teacher_Id) REFERENCES Teacher(Teacher_Id),
  FOREIGN KEY (Course_Id) REFERENCES Course(Course_Id)
);

CREATE TABLE Student (
  Stud_Id Varchar(10) NOT NULL,
  Stud_Name Varchar(50) NOT NULL,
  Semester INT NOT NULL,
  YearOfStudy Int NOT NULL,
  Sec_Id Varchar(5) NOT NULL,
  Branch Varchar(30) NOT NULL,
  Stud_Points INT Default 0,
  Stud_Password Varchar(50) NOT NULL,
  PRIMARY KEY (Stud_Id),
  FOREIGN KEY (Sec_Id) REFERENCES Section(Sec_Id),
  FOREIGN KEY (Branch) REFERENCES Department(dept_name)
);

CREATE TABLE Studies (
  Stud_Id Varchar(10) NOT NULL,
  Course_Id Varchar(10) NOT NULL,
  PRIMARY KEY (Stud_Id, Course_Id),
  FOREIGN KEY (Stud_Id) REFERENCES Student(Stud_Id),
  FOREIGN KEY (Course_Id) REFERENCES Course(Course_Id)
);

CREATE TABLE Questions (
  Ques_Id INT auto_increment,
  Content Varchar(100) NOT NULL,
  Upvotes INT Default 0,
  tag_name Varchar(15) NOT NULL,
  Num_of_answers Int Default 0,
  PRIMARY KEY (Ques_Id),
  UNIQUE (Content)
);

Create Table AskedBy (
  Ques_Id INT NOT NULL,
  Person_Id Varchar(10) NOT NULL,
  PRIMARY KEY (Ques_Id)
  # Foreign KEY (Person_id) references Student(Stud_Id),
  # Foreign KEY (Person_id) references Teacher(Teacher_Id)
);

CREATE TABLE Answers (
  Ques_Id INT NOT NULL,
  Ans_Id INT auto_increment,
  Content Varchar(100) NOT NULL,
  Upvotes INT default 0,
  PRIMARY KEY (Ans_Id),
  FOREIGN KEY (Ques_Id) REFERENCES Questions(Ques_Id)
);

CREATE TABLE AnswesedBy (
  Ans_Id INT NOT NULL,
  Person_Id Varchar(10) NOT NULL,
  PRIMARY KEY (Ans_Id)
  # Foreign KEY (Person_id) references Student(Stud_Id),
  # Foreign KEY (Person_id) references Teacher(Teacher_Id)
);

/*CREATE TABLE Stud_Answers (
  Ans_Id INT NOT NULL,
  Stud_Id INT NOT NULL,
  PRIMARY KEY (Ans_Id, Stud_Id),
  FOREIGN KEY (Ans_Id) REFERENCES Answers(Ans_Id),
  FOREIGN KEY (Stud_Id) REFERENCES Student(Stud_Id)
);*/

/*CREATE TABLE Tags (
  Tag_name Varchar(15) NOT NULL,
  PRIMARY KEY (Tag_name)
);*/

/*CREATE TABLE TaggedUnder (
  Tag_name Varchar(15) NOT NULL,
  Ques_Id INT NOT NULL,
  PRIMARY KEY (Tag_name, Ques_Id),
  FOREIGN KEY (Tag_name) REFERENCES Tags(Tag_name),
  FOREIGN KEY (Ques_Id) REFERENCES Questions(Ques_Id)
);*/

/*CREATE TABLE Blogs (
  C_ID INT NOT NULL,
  Content Varchar(100) NOT NULL,
  Upvotes INT NOT NULL,
  Tag_name Varchar(15) NOT NULL,
  Stud_Id Varchar(10) NOT NULL,
  lectue_no INT NOT NULL,
  PRIMARY KEY (C_ID),
  FOREIGN KEY (Tag_name) REFERENCES Tags(Tag_name),
  FOREIGN KEY (Stud_Id) REFERENCES Student(Stud_Id),
  FOREIGN KEY (lectue_no) REFERENCES Lecture(lectue_no)
);*/

/*CREATE TABLE Comments (
  Comment_Id INT NOT NULL,
  Content Varchar(100) NOT NULL,
  Ques_Id INT,
  Ans_Id INT,
  #C_ID INT NOT NULL,
  PRIMARY KEY (Comment_Id),
  FOREIGN KEY (Ques_Id) REFERENCES Questions(Ques_Id),
  FOREIGN KEY (Ans_Id) REFERENCES Answers(Ans_Id)
  #FOREIGN KEY (C_ID) REFERENCES Blogs(C_ID)
);*/

  CREATE TABLE if not exists Comments_ans (
  Comment_Id INT auto_increment,
  Content Varchar(100),
  Ans_Id INT NOT NULL,
  # C_ID INT NOT NULL,
  PRIMARY KEY (Comment_Id),
  FOREIGN KEY (Ans_Id) REFERENCES Answers(Ans_Id)
  );
  
  CREATE TABLE if not exists Comments_ques (
  Comment_Id INT auto_increment,
  Content Varchar(100),
  Ques_Id INT NOT NULL,
  # C_ID INT NOT NULL,
  PRIMARY KEY (Comment_Id),
  FOREIGN KEY (Ques_Id) REFERENCES Questions(Ques_Id)
  );

/*CREATE TABLE teacher_tasks (
  C_ID INT NOT NULL,
  Teacher_Id Varchar(10) NOT NULL,
  PRIMARY KEY (C_ID, Teacher_Id),
  FOREIGN KEY (C_ID) REFERENCES Blogs(C_ID),
  FOREIGN KEY (Teacher_Id) REFERENCES Teacher(Teacher_Id)
);*/




