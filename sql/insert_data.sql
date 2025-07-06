--- ===== Guardians =====
INSERT INTO Guardians (FullName, PhoneNumber, Email, Relation) VALUES
('John Smith', '+1-202-555-0148', 'john.smith@example.com', 'father'),
('Emily Davis', '+44-7700-900123', 'emily.davis@example.com', 'mother');

--- ===== Teachers =====
INSERT INTO Teachers (FullName, PhoneNumber, Email, HireDate, Specialization) VALUES
('Michael Johnson', '+1-310-555-2211', 'michael.johnson@school.com', '2018-09-01', 'Math'),
('Sarah Wilson', '+61-412-345-678', 'sarah.wilson@school.com', '2019-08-15', 'Science'),
('Thomas Baker', '+49-160-1234567', 'thomas.baker@school.com', '2020-01-10', 'English');

--- ===== Classes =====
INSERT INTO Classes (ClassName, AcademicYear, RoomNumber, HomeroomTeacherID) VALUES
('6A', 2024, 101, 1),
('7B', 2024, 102, 2);

--- ===== Students =====
INSERT INTO Students (FirstName, LastName, DateOfBirth, Gender, Address, ClassID, GuardianID, EnrollmentDate) VALUES
('Oliver', 'Johnson', '2011-06-10', 'male', '12 Greenway Ave', 1, 1, '2017-09-01'),
('Sophia', 'Davis', '2012-03-22', 'female', '45 Hillcrest Rd', 2, 2, '2018-09-01');

--- ===== Subjects =====
INSERT INTO Subjects (Name, Description) VALUES
('Mathematics', 'Basic math operations and problem solving'),
('Science', 'Introduction to biology, physics, and chemistry'),
('English', 'Reading, writing, and grammar');

--- ===== ClassSubject =====
INSERT INTO ClassSubject (ClassID, SubjectID) VALUES
(1, 1), --- 6A - Math
(1, 2), --- 6A - Science
(2, 2), --- 7B - Science
(2, 3); --- 7B - English

--- ===== TeacherSubject =====
INSERT INTO TeacherSubject (TeacherID, SubjectID) VALUES
(1, 1), --- Michael teaches Math
(2, 2), --- Sarah teaches Science
(3, 3); --- Thomas teaches English

--- ===== Attendance =====
INSERT INTO Attendance (StudentID, Date, Status) VALUES
(1, '2025-07-01', 'Present'),
(1, '2025-07-02', 'Absent'),
(2, '2025-07-01', 'Late');

--- ===== Grades =====
INSERT INTO Grades (StudentID, SubjectID, TeacherID, GradeValue, GradeDate) VALUES
(1, 1, 1, 88.5, '2025-06-20'),  --- Oliver - Math by Michael
(1, 2, 2, 91.0, '2025-06-22'),  --- Oliver - Science by Sarah
(2, 2, 2, 84.0, '2025-06-22'),  --- Sophia - Science by Sarah
(2, 3, 3, 79.5, '2025-06-23');  --- Sophia - English by Thomas
