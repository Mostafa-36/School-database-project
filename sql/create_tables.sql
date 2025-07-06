--- Create database
CREATE DATABASE SchoolDB;
USE SchoolDB;


--- Student
CREATE TABLE Students (
  StudentID INT PRIMARY KEY IDENTITY(1,1),
  FirstName NVARCHAR(30) NOT NULL,
  LastName NVARCHAR(30) NOT NULL,
  Address NVARCHAR(100),
  DateOfBirth DATE NOT NULL,
  AbsenceCount INT,
  Gender NVARCHAR(10) CHECK (Gender IN ('male', 'female')) NOT NULL,
  GuardianID INT NOT NULL,
  ClassID INT NOT NULL,
  EnrollmentDate DATE NOT NULL
);


--- Guardians
CREATE TABLE Guardians (
  GuardianID INT PRIMARY KEY IDENTITY(1,1),
  FullName NVARCHAR(50) NOT NULL,
  PhoneNumber NVARCHAR(20) UNIQUE,
  Email NVARCHAR(50) UNIQUE,
  Relation NVARCHAR(10) CHECK (Relation IN ('father', 'mother', 'guardian')) NOT NULL
);

--- Teachers
CREATE TABLE Teachers (
  TeacherID INT PRIMARY KEY IDENTITY(1,1),
  FullName NVARCHAR(50) NOT NULL,
  PhoneNumber NVARCHAR(20) UNIQUE,
  Email NVARCHAR(50) UNIQUE,
  HireDate DATE NOT NULL,
  Specialization NVARCHAR(50),
);

--- Classes
CREATE TABLE Classes (
  ClassID INT PRIMARY KEY IDENTITY(1,1),
  ClassName NVARCHAR(10) NOT NULL,
  AcademicYear INT NOT NULL,
  RoomNumber INT NOT NULL CHECK (RoomNumber > 0),
  HomeroomTeacherID INT NOT NULL
);

--- Subjects
CREATE TABLE Subjects (
  SubjectID INT PRIMARY KEY IDENTITY(1,1),
  Name NVARCHAR(50) NOT NULL,
  Description NVARCHAR(100)
);

--- Teacher-Subject
CREATE TABLE TeacherSubject (
  TeacherID INT NOT NULL,
  SubjectID INT NOT NULL,
  PRIMARY KEY (TeacherID, SubjectID)
);

--- Class-Subject
CREATE TABLE ClassSubject (
  ClassID INT NOT NULL,
  SubjectID INT NOT NULL,
  PRIMARY KEY (ClassID, SubjectID)
);

--- Attendance
CREATE TABLE Attendance (
  Date DATE NOT NULL,
  Status NVARCHAR(10) CHECK (Status IN ('Present', 'Absent', 'Late')) NOT NULL,
  StudentID INT NOT NULL,
  PRIMARY KEY (StudentID, Date)
);

--- Grades
CREATE TABLE Grades (
  GradeValue DECIMAL(5,2) CHECK (GradeValue BETWEEN 0 AND 100),
  GradeDate DATE NOT NULL,
  StudentID INT NOT NULL,
  TeacherID INT NOT NULL,
  SubjectID INT NOT NULL,
  PRIMARY KEY (StudentID, SubjectID, TeacherID)
);

--- TeacherSupervision
CREATE TABLE TeacherSupervision(
  SupervisorID INT ,
  TeacherID INT,
  PRIMARY KEY (SupervisorID, TeacherID)
)

--- 🔗(Foreign Keys)

--- Studen → Class, Guardian
ALTER TABLE Students
ADD CONSTRAINT FK_Students_Classes FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    CONSTRAINT FK_Students_Guardians FOREIGN KEY (GuardianID) REFERENCES Guardians(GuardianID),
	CONSTRAINT chk_Enrollment_After_Birth CHECK (EnrollmentDate > DateOfBirth);

--- Classes → Teachers
ALTER TABLE Classes
ADD CONSTRAINT FK_Classes_HomeroomTeacher FOREIGN KEY (HomeroomTeacherID) REFERENCES Teachers(TeacherID);

--- Teachers → Supervisors (Self-reference)

ALTER TABLE TeacherSupervision
ADD CONSTRAINT FK_TeacherSupervision_Supervisor FOREIGN KEY (SupervisorID) REFERENCES Teachers(TeacherID),
    CONSTRAINT FK_TeacherSupervision_Teacher FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID);


--- TeacherSubject
ALTER TABLE TeacherSubject
ADD CONSTRAINT FK_TeacherSubject_Teacher FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID),
    CONSTRAINT FK_TeacherSubject_Subject FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID);

--- ClassSubject
ALTER TABLE ClassSubject
ADD CONSTRAINT FK_ClassSubject_Class FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    CONSTRAINT FK_ClassSubject_Subject FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID);

--- Attendance
ALTER TABLE Attendance
ADD CONSTRAINT FK_Attendance_Student FOREIGN KEY (StudentID) REFERENCES Students(StudentID);

--- Grades
ALTER TABLE Grades
ADD CONSTRAINT FK_Grades_Student FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT FK_Grades_Teacher FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID),
    CONSTRAINT FK_Grades_Subject FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID);