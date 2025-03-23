-- Task-1
CREATE DATABASE SISDB;
USE SISDB;
-- Students Table:
CREATE TABLE Students (
student_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
date_of_birth DATE NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone_number bigint UNIQUE NOT NULL
); 
-- eacher Table:
CREATE TABLE Teacher (
teacher_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL
); 
-- Courses Table:
CREATE TABLE Courses (
course_id INT AUTO_INCREMENT PRIMARY KEY,
course_name VARCHAR(100) NOT NULL,
credits INT NOT NULL,
teacher_id INT,
FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id) ON DELETE SET NULL
); 
-- Enrollments Table:
CREATE TABLE Enrollments (
enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
course_id INT,
enrollment_date DATE NOT NULL,
FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
); 
-- Payments Table:
CREATE TABLE Payments (
payment_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
amount DECIMAL(10,2) NOT NULL,
payment_date DATE NOT NULL,
FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE
); 
SHOW TABLES;
DESC Students;
DESC Courses;
DESC Enrollments;
DESC Teacher;
DESC Payments;

-- Students: 
INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number) VALUES
('Malar', 'Vizhi', '2001-05-15', 'malar04@gmail.com', 9876543210),
('Vetri', 'Vel', '2002-07-20', 'vetri8@gmail.com', 9123456789),
('Kathir', 'Raja', '2003-01-10', 'kathir3@gmail.com', 9988776655),
('Kalai', 'Arasi', '2001-09-25', 'kalai09@gmail.com', 9876123456),
('Vijay', 'Varma', '2002-11-11', 'vijay07@gmail.com', 8765432190),
('Sophia', 'Wilson', '2003-03-30', 'sophia05@gmail.com', 9234567890),
('David', 'Martin', '2001-06-14', 'david06@gmail.com', 9321456789),
('Hema', 'Shri', '2002-12-05', 'hema11@gmail.com', 9456783210),
('Selva', 'Raj', '2003-04-21', 'selva66@gmail.com', 9345678123),
('Olivia', 'Taylor', '2001-08-18', 'olivia9@gmail.com', 9212345678);

SELECT * FROM Students;

-- Teacher:
INSERT INTO Teacher (first_name, last_name, email) VALUES
('James', 'Miller', 'james.miller@gmail.com'),
('Sarah', 'Johnson', 'sarah.johnson@gmail.com'),
('William', 'Brown', 'william.brown@gmail.com'),
('Jennifer', 'Williams', 'jennifer.williams@gmail.com'),
('David', 'Anderson', 'david.anderson@gmail.com'),
('Laura', 'Thomas', 'laura.thomas@gmail.com'),
('Mark', 'Taylor', 'mark.taylor@gmail.com'),
('Jessica', 'Moore', 'jessica.moore@gmail.com'),
('Daniel', 'White', 'daniel.white@gmail.com'),
('Emma', 'Harris', 'emma.harris@gmail.com');

SELECT * FROM Teacher;

-- Courses:
INSERT INTO Courses (course_name, credits, teacher_id) VALUES
('Database Systems', 3, 1),
('Operating Systems', 4, 2),
('Data Structures', 3, 3),
('Computer Networks', 3, 4),
('Web Development', 3, 5),
('Artificial Intelligence', 4, 6),
('Cybersecurity', 3, 7),
('Software Engineering', 3, 8),
('Cloud Computing', 4, 9),
('Machine Learning', 4, 10);

SELECT * FROM Courses;

-- Enrollments:
INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-01-10'),
( 2, 2, '2024-01-11'),
( 3, 3, '2024-01-12'),
( 4, 4, '2024-01-13'),
( 5, 5, '2024-01-14'),
( 6, 6, '2024-01-15'),
( 7, 7, '2024-01-16'),
( 8, 8, '2024-01-17'),
( 9, 9, '2024-01-18'),
( 10, 10, '2024-01-19');

SELECT * FROM Enrollments;

-- Payments:
INSERT INTO Payments (student_id, amount, payment_date) VALUES
(1, 500.00, '2024-02-01'),
(2, 600.00, '2024-02-02'),
(3, 550.00, '2024-02-03'),
(4, 700.00, '2024-02-04'),
(5, 450.00, '2024-02-05'),
(6, 650.00, '2024-02-06'),
(7, 600.00, '2024-02-07'),
(8, 750.00, '2024-02-08'),
(9, 500.00, '2024-02-09'),
(10, 800.00, '2024-02-10');

SELECT * FROM Payments;


-- Task-2
-- 1. Insert a new student

INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number) VALUES 
('John', 'Doe', '1995-08-15', 'john.doe@example.com', 1234567890);

-- 2. Enroll a student in a course
INSERT INTO enrollments(student_id, course_id, enrollment_date) VALUES (3,5,'2025-03-01');

-- 3. Update a teacher's email
UPDATE teacher SET email='jennifer123@gmail.com' WHERE teacher_id=4;

-- 4. Delete an enrollment record
DELETE FROM enrollments WHERE student_id=1 AND course_id=1;

-- 5. Assign a teacher to a course
UPDATE courses SET teacher_id=3 WHERE course_id=6;

-- 6. Delete a student and their enrollments
DELETE FROM students WHERE student_id=5;

-- 7. Update payment amount
UPDATE payments SET amount=1000 WHERE payment_id=3;  


-- Task-3
-- 1. Calculate the total payments made by a specific student
SELECT s.student_id, s.first_name, s.last_name, SUM (p.amount) AS total_amount 
FROM Students s 
JOIN Payments p ON s.student_id = p.student_id 
GROUP BY s.student_id;

-- 2.Retrieve a list of courses along with the count of students enrolled in each course
SELECT c.course_id, c.course_name, COUNT (e.student_id) AS student_count
FROM Courses c 
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY student_count DESC;

-- 3.Find the names of students who have not enrolled in any course
SELECT s.student_id, s.first_name, s.last_name 
FROM Students s 
LEFT JOIN Enrollments e ON s.student_id=e.student_id
WHERE e.enrollment_id IS NULL;

-- 4.Retrieve the first name, last name of students, and the names of the courses they are enrolled in
SELECT s.first_name, s.last_name, c.course_name 
FROM Students s 
JOIN Enrollments e ON s.student_id=e.student_id
JOIN Courses c ON e.course_id=c.course_id
ORDER BY s.first_name;

-- 5.List the names of teachers and the courses they are assigned to
SELECT t.teacher_id, t.first_name, t.last_name, c.course_name 
FROM Teacher t 
JOIN Courses c ON t.teacher_id=c.teacher_id
ORDER BY t.first_name;

-- 6. Retrieve a list of students and their enrollment dates for a specific course.
SELECT s.first_name, s.last_name, e.enrollment_date 
FROM Students s
JOIN Enrollments e ON s.student_id=e.student_id
JOIN Courses c ON e.course_id=c.course_id
WHERE c.course_id=3;

-- 7. Find the names of students who have not made any payments
SELECT s.student_id, s.first_name, s.last_name 
FROM Students s 
LEFT JOIN Payments p ON s.student_id=p.student_id
WHERE p.payment_id IS NULL;

-- 8.Identify courses that have no enrollments
SELECT c.course_id, c.course_name 
FROM Courses c 
LEFT JOIN Enrollments e ON c.course_id=e.course_id
WHERE e.enrollment_id IS NULL;

-- 9. Identify students who are enrolled in more than one course
SELECT s.student_id, s.first_name, s.last_name, COUNT (e.course_id) 
FROM Enrollments e JOIN Students s
ON s.student_id=e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT (e.course_id)>1;

-- 10. Find teachers who are not assigned to any courses
SELECT t.teacher_id, t.first_name, t.last_name
FROM Teacher t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id
WHERE c.course_id IS NULL;

-- Task-4
-- 1.Calculate the average number of students enrolled in each course
SELECT AVG (StudentCount) AS AverageEnrollment
FROM (SELECT c.course_id, c.course_name, COUNT(e.student_id) AS StudentCount
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name)
AS enrollment_counts;

-- 2. Identify the student(s) who made the highest payment
SELECT s.student_id, s.first_name, s.last_name, p.amount
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
WHERE p.amount = (SELECT MAX (amount) FROM Payments);

-- 3. Retrieve a list of courses with the highest number of enrollments
SELECT course_id, course_name, TotalStudents
FROM (SELECT C.course_id, C.course_name, COUNT (E.student_id) AS TotalStudents
FROM Courses C
LEFT JOIN Enrollments E ON C.course_id = E.course_id
GROUP BY C.course_id, C.course_name) 
AS CourseCounts
WHERE TotalStudents = (SELECT MAX (TotalStudents) 
FROM (SELECT COUNT (student_id) AS total_students 
FROM Enrollments GROUP BY course_id ) AS EnrollmenstCounts);

-- 4. Calculate the total payments made to courses taught by each teacher
SELECT T.teacher_id, T.first_name, T.last_name, 
(SELECT SUM(P.amount) 
FROM Payments P 
JOIN Enrollments E ON P.student_id = E.student_id
JOIN Courses C ON E.course_id = C.course_id
WHERE C.teacher_id = T.teacher_id) AS TotalPayment
FROM Teacher T;

-- 5. Identify students who are enrolled in all available courses
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
WHERE (SELECT COUNT (e.course_id) 
FROM Enrollments e 
WHERE e.student_id = s.student_id) = (SELECT COUNT (*) FROM Courses);

-- 6. Retrieve the names of teachers who have not been assigned to any courses
SELECT t.teacher_id, t.first_name, t.last_name
FROM Teacher t
WHERE t.teacher_id NOT IN (SELECT DISTINCT c.teacher_id FROM Courses c);

-- 7. Calculate the average age of all students
SELECT AVG(student_age) AS average_age
FROM (SELECT TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS student_age
FROM Students) AS age_subquery;

-- 8. Identify courses with no enrollments
SELECT AVG(student_age) AS average_age
FROM (SELECT TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS student_age
FROM Students) AS age_subquery;

-- 9. Calculate the total payments made by each student for each course they are enrolled in
SELECT S.student_id, S.first_name, S.last_name, C.course_id, C.course_name, 
(SELECT SUM (P.amount) FROM Payments P 
WHERE P.student_id = S.student_id) AS TotalPayments
FROM Students S
JOIN Enrollments E ON S.student_id = E.student_id
JOIN Courses C ON E.course_id = C.course_id;

-- 10. Identify students who have made more than one payment
SELECT student_id, first_name, last_name 
FROM Students 
WHERE student_id IN (
SELECT student_id FROM Payments GROUP BY student_id 
HAVING COUNT (*) > 1);

-- 11.Calculate the total payments made by each student
SELECT S.student_id, S.first_name, S.last_name, SUM(P.amount) AS TotalPayments
FROM Students S
LEFT JOIN Payments P ON S.student_id = P.student_id
GROUP BY S.student_id, S.first_name, S.last_name;

-- 12. Retrieve a list of course names along with the count of students enrolled in each course
SELECT C.course_name, COUNT (E.student_id) AS StudentCount
FROM Courses C
LEFT JOIN Enrollments E ON C.course_id = E.course_id
GROUP BY C.course_id, C.course_name;

-- 13. Calculate the average payment amount made by students
SELECT S.student_id, S.first_name, S.last_name, AVG(P.amount) AS avg_payment
FROM Students S
JOIN Payments P ON S.student_id = P.student_id
GROUP BY S.student_id, S.first_name, S.last_name;
