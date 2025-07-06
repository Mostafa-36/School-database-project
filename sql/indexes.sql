--- Index for attendance inquiries
CREATE INDEX idx_Attendance_StudentDate on Attendance(StudentID, Date)

--- Indx for Analyzing a student's grades in a subject
CREATE INDEX idx_Grades_Student_Subject
ON Grades(StudentID, SubjectID);

--- Index for Filter teachers by specialty
CREATE INDEX idx_Teachers_Specialization
ON Teachers(Specialization);