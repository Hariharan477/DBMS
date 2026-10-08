-- Ex No: 2
-- Table Creation and Data Insertion

CREATE TABLE Student (
    StudentID INT,
    Name VARCHAR(30),
    Age INT
);

CREATE TABLE Courses (
    CourseID INT,
    CourseName VARCHAR(20)
);

CREATE TABLE Enrollments (
    EnrollmentID INT,
    StudentID INT,
    CourseID INT,
    Grade VARCHAR(5)
);

INSERT INTO Student VALUES (1, 'Alice', 20);
INSERT INTO Student VALUES (2, 'Bob', 22);
INSERT INTO Student VALUES (3, 'Charlie', 21);

INSERT INTO Courses VALUES (1, 'Math');
INSERT INTO Courses VALUES (2, 'English');
INSERT INTO Courses VALUES (3, 'History');

INSERT INTO Enrollments VALUES (1, 1, 1, 'A');
INSERT INTO Enrollments VALUES (2, 1, 2, 'B');
INSERT INTO Enrollments VALUES (3, 2, 1, 'A-');
INSERT INTO Enrollments VALUES (4, 3, 3, 'B+');
INSERT INTO Enrollments VALUES (5, 3, 2, 'A');

-- Inner Join
SELECT Students.StudentID, Students.Name, Students.Age, 
       Courses.CourseID, Courses.CourseName, Enrollments.Grade 
FROM Student Students 
INNER JOIN Enrollments ON Students.StudentID = Enrollments.StudentID 
INNER JOIN Courses ON Enrollments.CourseID = Courses.CourseID;

-- Left Join
SELECT Students.StudentID, Students.Name, Students.Age, 
       Courses.CourseID, Courses.CourseName, Enrollments.Grade 
FROM Student Students 
LEFT JOIN Enrollments ON Students.StudentID = Enrollments.StudentID 
LEFT JOIN Courses ON Enrollments.CourseID = Courses.CourseID;

-- Right Join
SELECT Students.StudentID, Students.Name, Students.Age, 
       Courses.CourseID, Courses.CourseName, Enrollments.Grade 
FROM Courses 
RIGHT JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID 
RIGHT JOIN Student Students ON Enrollments.StudentID = Students.StudentID;
