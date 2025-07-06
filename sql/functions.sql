--- Calculating the student's overall average
CREATE FUNCTION fn_GetStudentAverageGrade(@STUDENTID INT)
RETURNS FLOAT
AS
BEGIN
    
    DECLARE @Avarage FLOAT
    
    SELECT @Avarage = AVG(GradeValue) FROM Grades
    WHERE StudentID = @STUDENTID
    
    RETURN @Avarage
END;

--- Returns the number of absences for a student in a specific month and year.
CREATE FUNCTION fn_GetMonthlyAbsences(
    @StudentID INT,
    @Year INT,
    @Month INT
)
RETURNS INT
AS
BEGIN
    DECLARE @AbsenceCount INT

    SELECT @AbsenceCount = COUNT(*) FROM Attendance
    WHERE StudentID = @StudentID AND Status = 'Absent'
    AND YEAR(Date) = @Year AND MONTH(Date) = @Month

    RETURN ISNULL(@AbsenceCount, 0);
END











