--- Trigger to prevent a teacher from deleting associated materials.
CREATE TRIGGER trg_PreventDeletingTeacher
ON Teachers
INSTEAD OF DELETE
AS
BEGIN
  IF EXISTS (
    SELECT 1
    FROM deleted d
    JOIN TeacherSubject ts ON ts.TeacherID = d.TeacherID
  )
  BEGIN
    RAISERROR('Cannot delete teacher: teacher is assigned to subjects.', 16, 1);
    RETURN;
  END

  DELETE FROM Teachers WHERE TeacherID IN (SELECT TeacherID FROM deleted);
END;



--- Trigger to prevent future attendance entry and update AbsenceCount if Status was absent
CREATE TRIGGER trg_ValidateAndTrackAttendance
ON Attendance
AFTER INSERT
AS
BEGIN
  IF EXISTS (
    SELECT 1 FROM inserted WHERE Date > CAST(GETDATE() AS DATE)
  )
  BEGIN
    RAISERROR('Attendance date cannot be in the future.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END

  UPDATE Students
  SET AbsenceCount = ISNULL(AbsenceCount, 0) + 1
  FROM Students s
  JOIN inserted i ON s.StudentID = i.StudentID
  WHERE i.Status = 'Absent';
END;
