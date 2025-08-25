#student result management system

CREATE DATABASE studentresult;
USE studentresult;

CREATE TABLE student(
	student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(50)
);

CREATE TABLE courses(
	course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);

CREATE TABLE marks(
	student_id INT,
    course_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES student (student_id),
    FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

CREATE TABLE teacher(
	teacher_id INT PRIMARY KEY,
    name VARCHAR(50),
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

INSERT INTO student
(student_id,name,age,gender)
VALUES
(101,'William',12,'Male'),
(102,'Bob',12,'Male'),
(103,'shruti',12,'Female'),
(104,'Ambika',12,'Female'),
(105,'Rohit',12,'Male');

INSERT  INTO courses 
(course_id,course_name)
VALUES
(01,'Science'),
(02,'English'),
(03,'Mathematics');

INSERT INTO marks
(student_id,course_id,marks)
VALUES
(101,01,85),
(101,02,78),
(101,03,87),
(102,01,67),
(102,03,95),
(103,01,85),
(103,02,81),
(104,01,77),
(104,03,88),
(105,02,98),
(105,03,90);

INSERT INTO teacher 
(teacher_id,name,course_id)
VALUES
(1,'Mr.kapoor',01),
(2,'Ms.Sharma',02),
(3,'Mr.Robert',03);

#1.shows all students with their courses and marks

SELECT s.name as student_name, c.course_name,m.marks 
FROM student as s
INNER JOIN marks as m
ON s.student_id = m.student_id
INNER JOIN courses as c
on m.course_id = c.course_id;

#2.shows the average mark of each student;
SELECT s.name as student_name,AVG(marks) as marks
FROM student as s
INNER JOIN marks
ON s.student_id = marks.student_id
GROUP BY s.name;

#3. shows all students  who  scored above 80 in any  subject
select s.name as student_name,c.course_name,marks
FROM student as s
INNER JOIN marks as m
on s.student_id = m.student_id
INNER JOIN courses as c
on m.course_id = c.course_id
WHERE marks > 80;

#4.shows each course and teacher teaching it
select course_name,t.name as teacher_name
FROM courses as c
INNER JOIN teacher as t
on c.course_id =  t.course_id;

#5.shows students with their courses and teacher
SELECT s.name as student_name,course_name,t.name as teacher_name
FROM student as s
INNER JOIN marks as m
on s.student_id =  m.student_id
INNER JOIN courses as c
on m.course_id = c.course_id
INNER JOIN teacher as t
on c.course_id = t.course_id; 

#6.shows top scorer in mathematics
select  s.name as student_name,marks
FROM student as s
INNER JOIN marks
on s.student_id = marks.student_id
INNER JOIN courses as c
on marks.course_id = c.course_id
WHERE c.course_name = 'Mathematics'
ORDER BY marks.marks DESC
LIMIT 1;

#7. Grade Calculation(A/B/C/FAIL)
select s.name,AVG(m.marks) as avg_mark,
CASE
	WHEN AVG(m.marks) >= 90 THEN 'A'
    WHEN AVG(m.marks) >= 75 THEN 'B'
    WHEN AVG(m.marks) >= 50 THEN 'C'
    ELSE 'FAIL'
END AS Grade
FROM student as s
JOIN marks  as m
on s.student_id = m.student_id
GROUP BY s.name;

#7. pass percentage per course
SELECT c.course_name,(COUNT(CASE WHEN m.marks >= 50 THEN 1 END)*100.0/COUNT(*)) as pass_percentage
FROM courses as c
JOIN marks as m
on c.course_id = m.course_id
GROUP BY c.course_name;





