--- View for Student grade report with subject and teacher information
CREATE VIEW vw_StudentGrades AS
SELECT 
    s.FirstName + ' ' + s.LastName AS StudentName,
    sub.Name AS Subject,
    t.FullName AS Teacher,
    g.GradeValue,
    g.GradeDate
FROM Grades g
JOIN Students s ON g.StudentID = s.StudentID
JOIN Teachers t ON g.TeacherID = t.TeacherID
JOIN Subjects sub ON g.SubjectID = sub.SubjectID;


--- View for Number of days of attendance and absence for each student
CREATE VIEW vw_StudentAttendanceSummary AS
SELECT
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS StudentName,
    COUNT(CASE WHEN a.Status = 'Present' THEN 1 END) AS PresentDays,
    COUNT(CASE WHEN a.Status = 'Absent' THEN 1 END) AS AbsentDays,
    COUNT(CASE WHEN a.Status = 'Late' THEN 1 END) AS LateDays
FROM Students s
LEFT JOIN Attendance a ON s.StudentID = a.StudentID
GROUP BY s.StudentID, s.FirstName, s.LastName;
