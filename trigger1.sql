CREATE TRIGGER insert_trigger_check_librarian
ON Issue FOR INSERT
AS
IF @@ROWCOUNT=1
BEGIN 
	IF NOT EXISTS(SELECT * FROM inserted 
		WHERE inserted.Librarian_ID = ANY(SELECT Librarian_ID FROM Librarian))
		BEGIN 
			ROLLBACK TRAN 
		PRINT
			'Отмена записи: в базе нет такого библиотекаря'
		END
END 
INSERT Issue VALUES (3, 3, 8, '04.04.2020', '04.05.2020', NULL, NULL)
INSERT Issue VALUES (5, 4, 1, '05.04.2020', '05.05.2020', NULL, NULL)

DROP TRIGGER insert_trigger_check_librarian
SELECT * FROM Issue
SELECT * FROM Reader_Form