--- 1. List all students with their class and guardian

SELECT 
  s.FirstName + ' ' + s.LastName AS FullName,
  c.ClassName,
  g.FullName AS GuardianName
FROM Students s
JOIN Classes c ON s.ClassID = c.ClassID
JOIN Guardians g ON s.GuardianID = g.GuardianID;

--- 2. Get attendance report for a specific date

SELECT 
  s.FirstName + ' ' + s.LastName AS Student,
  a.Date,
  a.Status
FROM Attendance a
JOIN Students s ON a.StudentID = s.StudentID
WHERE a.Date = '2025-07-01';

--- 3. Show all grades for a student

SELECT 
  s.FirstName + ' ' + s.LastName AS Student,
  sub.Name AS Subject,
  t.FullName AS Teacher,
  g.GradeValue,
  g.GradeDate
FROM Grades g
JOIN Students s ON g.StudentID = s.StudentID
JOIN Teachers t ON g.TeacherID = t.TeacherID
JOIN Subjects sub ON g.SubjectID = sub.SubjectID
WHERE s.FirstName = 'Oliver' AND s.LastName = 'Johnson';

--- 4. List all subjects taught by each teacher

SELECT 
  t.FullName AS Teacher,
  sub.Name AS Subject
FROM TeacherSubject ts
JOIN Teachers t ON ts.TeacherID = t.TeacherID
JOIN Subjects sub ON ts.SubjectID = sub.SubjectID
ORDER BY t.FullName;

--- 5. Count students per class

SELECT 
  c.ClassName,
  COUNT(s.StudentID) AS NumberOfStudents
FROM Classes c
LEFT JOIN Students s ON c.ClassID = s.ClassID
GROUP BY c.ClassName;

--- 6. Get top 3 students by average grade

SELECT TOP 3
  s.FirstName + ' ' + s.LastName AS Student,
  AVG(g.GradeValue) AS AverageGrade
FROM Grades g
JOIN Students s ON g.StudentID = s.StudentID
GROUP BY s.FirstName, s.LastName
ORDER BY AverageGrade DESC;

--- 7. List students who have never been marked Present

SELECT 
  s.FirstName + ' ' + s.LastName AS Student
FROM Students s
WHERE s.StudentID NOT IN (
  SELECT DISTINCT StudentID 
  FROM Attendance 
  WHERE Status = 'Present'
);

--- 8. Number of absences in a given month for a student

SELECT dbo.fn_GetMonthlyAbsences(1, 2025, 7) AS AbsencesInMay;

--- 9. Average student grades

SELECT dbo.fn_GetStudentAverageGrade(1) AS AverageGrade;

--- 10. Attendance summary for each student

SELECT * FROM vw_StudentAttendanceSummary;

--- 11. Student grades with subject and teacher details

SELECT * FROM vw_StudentGrades;