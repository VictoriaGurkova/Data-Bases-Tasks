/*
������� ��������� ������� � ����:

1. ������� � �������������� ��������� ����� ���������� ������ 
(Inner join, Outer join, Cross join, Cross apply, ��������������);

2. ���������� ������ � �������� � �������������� ���������� 
(EXISTS, IN, ALL, SOME/ANY, BETWEEN, LIKE);

3. ������� � �������������� ��������� CASE;

4. ������������� ���������� ������� (������� �������������� ����� (CAST, CONVERT), 
������� ��� �������� �������� NULL (ISNULL, NULLIF), 
COALESCE ���������� ������� (CHOOSE,  IIF) � �.�.);

5. ������� � �������������� ������� ���  ������ �� �������� 
(REPLACE, SUBSTRING, STUFF, STR,UNICODE, LOWER,UPPER � �.�.);

6. ������� � �������������� ������� ���� � ������� 
(DATEPART,DATEADD,DATEDIFF,  GETDATE(),SYSDATETIMEOFFSET() � �.�.);

7. ������� � �������������� ���������� �������, ����������� 
(GROUP BY) � ���������� ����� (HAVING).
*/

                                                    -- 1 --

-- INNER JOIN --
SELECT b.Title, a.Full_Name AS Author_Name, a.Pseudonym 
FROM Book b
INNER JOIN Author a ON b.Author_ID = a.Author_ID

-- LEFT OUTER JOIN --
SELECT b.Title, a.Full_Name AS Author_Name
FROM Book b
LEFT OUTER JOIN Author a ON b.Author_ID = a.Author_ID

-- RIGHT OUTER JOIN --
SELECT b.Title, a.Full_Name AS Author_Name
FROM Book b
RIGHT OUTER JOIN Author a ON b.Author_ID = a.Author_ID

-- CROSS JOIN --
SELECT b.Title, a.Full_Name AS Author_Name
FROM Book b
CROSS JOIN Author a

-- CROSS APPLY --
SELECT b.Title, a.Full_Name AS Author_Name
FROM Book b
CROSS APPLY Author a

-- �������������� --
SELECT l1.Library_ID, l1.Full_Name AS Librarian_1, l2.Full_Name AS Librarian_2
FROM Librarian l1 JOIN Librarian l2
ON l1.Library_ID = l2.Library_ID
WHERE l1.Librarian_ID <> l2.Librarian_ID

                                                    -- 2 --

-- EXISTS --
SELECT * FROM Issue WHERE Client_ID = 3 AND
EXISTS (SELECT Client_ID FROM Client)

SELECT Title FROM Book WHERE Author_ID = 3 AND
EXISTS (SELECT Author_ID FROM Author)


-- IN --
SELECT * FROM Book
WHERE Category_ID IN (4, 6)

-- ANY --
SELECT Full_Name, Pseudonym FROM Author
WHERE Author_ID = ANY(SELECT Author_ID FROM Book)

--SOME --
SELECT Full_Name, Pseudonym FROM Author
WHERE Author_ID = SOME(SELECT Author_ID FROM Book)

-- ALL --
SELECT * FROM Issue
WHERE Issue_Date >= ALL(SELECT Issue_Date FROM Issue)

SELECT * FROM Issue

-- BETWEEN --
SELECT Category_ID, Category_Name FROM Category
WHERE Category_ID BETWEEN 3 AND 6

SELECT Category_ID, Category_Name FROM Category
WHERE Category_ID NOT BETWEEN 3 AND 6

SELECT * FROM Issue
WHERE Issue_Date BETWEEN '19.06.2019' AND '20.03.2020'

-- LIKE --
SELECT * FROM Client
WHERE Full_Name LIKE '�%'

SELECT * FROM Librarian
WHERE Full_Name LIKE '%�'

SELECT * FROM Author
WHERE Pseudonym LIKE '% % %'

	SELECT * FROM Author
	WHERE Pseudonym NOT LIKE '% % %'

                                                    -- 3 --

-- CASE --
SELECT Instance_ID, Publisher_ID, Year_of_Publication,
CASE
	WHEN Amount_of_Page > 800 THEN '���������� ������� ������ 800'
	WHEN Amount_of_Page = 800 THEN '���������� ������� ����� 800'
	ELSE '���������� ������� ������ 800'
END AS '���������� �������'
FROM Instance

SELECT Passport_ID, Client_ID, Librarian_ID,
CASE
	WHEN Issue_Date > '31.12.2019' THEN '������ ����� 2019 ����'
	WHEN Issue_Date BETWEEN '01.01.2019' AND '31.12.2019' THEN '������ � 2019 ����'
	ELSE '������ �� 2019 ����'
END AS '��� ������'
FROM Issue

                                                    -- 4 --

-- CAST --
SELECT Short_Name, CAST(Adress AS TEXT) AS '�����' 
FROM Publish_House

SELECT Book_ID, Condition, Amount_of_Page, CAST(Year_of_Publication AS DATETIME2)
FROM Instance WHERE Book_ID = 2

-- CONVERT --
SELECT Book_ID, Condition, Amount_of_Page, CONVERT(VARCHAR, Year_of_Publication, 100) AS '���� ����������'
FROM Instance

SELECT Book_ID, Condition, Amount_of_Page, CONVERT(VARCHAR, Year_of_Publication, 101) AS '���� ����������'
FROM Instance

SELECT Book_ID, Condition, Amount_of_Page, CONVERT(VARCHAR, Year_of_Publication, 110) AS '���� ����������'
FROM Instance

SELECT Book_ID, Condition, Amount_of_Page, CONVERT(VARCHAR, Year_of_Publication, 112) AS '���� ����������'
FROM Instance

-- ISNULL --
SELECT Client_ID AS '������', ISNULL(CAST(Time_Lag AS VARCHAR(50)), '�������� �������� ��� �� ����������') AS '�������� ��������'
FROM Issue

-- NULLIF --
SELECT Author_ID, Title,
	NULLIF(Author_ID, 5) 'NULL ���� ����� �.�.�������'
FROM Book 

SELECT Author_ID, Title,
	NULLIF(Author_ID, 1) 'NULL ���� ����� �.�.������'
FROM Book 

-- COALESCE --
SELECT COALESCE(CONVERT(VARCHAR(50),Actual_Return_Date,100), '��� �� ����������') AS '���������� ���� �������'
FROM Issue

-- CHOOSE --
SELECT Client_ID, Librarian_ID, CHOOSE(Passport_ID, '1', '2', '3', '4', '5') AS '��������� �����'
FROM Issue

-- IIF --
SELECT Short_Name, Phone_Number, IIF(City_ID = 495, '������', '�������')  '����������� ����' 
FROM Publish_House

-- COALESCE and IIF--
SELECT Issue_Date, COALESCE(IIF(Time_Lag IS NULL, -1, Time_Lag), Time_Lag ) AS '-1 - ����� ��� �� �������'
FROM Issue


                                                    -- 5 --

-- REPLACE --
SELECT REPLACE(Full_Name, '�', '�') AS '������'
FROM Author

SELECT REPLACE(Full_Name, '����������', '��������') AS '��������'
FROM Library

-- SUBSTRING --
SELECT Full_Name, SUBSTRING(Full_Name, 1, 1) AS '������ ����� ������� �������' 
FROM Client

SELECT City_Name, UPPER(SUBSTRING(City_Name, LEN(City_Name), 1)) AS '��������� ����� �������� ������' 
FROM City

-- STUFF --
SELECT STUFF(Full_Name, LEN(Full_Name), 1, '� ������� ��������!') AS '������� ��������'
FROM Author WHERE Author_ID >= 5

-- STR --
SELECT STR(CAST(Amount_of_Page AS FLOAT), 2, 0) FROM Instance

SELECT STR(CAST(Amount_of_Page AS FLOAT), 3, 0) FROM Instance

SELECT STR(CAST(Amount_of_Page AS FLOAT), 4, 0) FROM Instance

-- UNICODE --
SELECT Full_Name AS 'Authors names', SUBSTRING(Full_Name, 1, 1) AS 'First character', UNICODE(Full_Name) AS 'UNICODE Value' 
FROM Author

-- UPPER --
SELECT UPPER(Full_Name) AS 'Uppercase full names'
FROM Librarian

-- LOWER --
SELECT LOWER(Full_Name) AS 'Lowercase full names' FROM Librarian

                                                    -- 6 --

-- DATEPART --
SELECT Instance_ID, Amount_of_Page, DATEPART(YEAR, Year_of_Publication) AS 'Year_of_Publication' 
FROM Instance WHERE Book_ID = 2

SELECT Issue_Date AS '���� ������', DATEPART(DAY, Issue_Date) AS '�����', DATEPART(MONTH, Issue_Date) AS '�����', 
	DATEPART(WEEK, Issue_Date) AS '����� ������ � ����',  DATEPART(WEEKDAY, Issue_Date)AS '���� ������', 
	DATEPART(DAYOFYEAR, Issue_Date) AS '����� ��� � ����'
FROM Issue

-- DATEADD --
SELECT Year_of_publication, DATEADD(YEAR, 1, Year_of_Publication) AS 'Year + 1' 
FROM Instance 

SELECT Year_of_publication, DATEADD(MONTH, 1, Year_of_Publication) AS 'Month + 1' 
FROM Instance 

SELECT Year_of_publication, DATEADD(DAY, 1, Year_of_Publication) AS 'Day + 1' 
FROM Instance 

-- DATEDIFF --
SELECT Year_of_Publication AS '��� �������', DATEDIFF(YEAR, Year_of_Publication, '01.01.2020') AS '������� ��� �������', 
	DATEDIFF(MONTH, Year_of_Publication, '01.01.2020') AS '������� ������� �������', 
	DATEDIFF(DAY, Year_of_Publication, '01.01.2020') AS '������� ���� �������'
FROM Instance 


SELECT SYSDATETIME() AS 'SYSDATETIME', 
	   SYSDATETIMEOFFSET() AS 'SYSDATETIMEOFFSET'

SELECT SYSUTCDATETIME() AS 'SYSUTCDATETIME', CURRENT_TIMESTAMP AS 'CURRENT_TIMESTAMP',
	   GETDATE() AS 'GETDATE', GETUTCDATE() AS 'GETUTCDATE'


                                                    -- 7 --

-- ���������� ������� --
SELECT SUM(Amount_of_Page) AS '���������� ������� � ��� ����������� "���� ���������"'
FROM Instance WHERE Book_ID = 2

SELECT AVG(Time_Lag) AS '������� ������������ �������� ��������'
FROM Issue

SELECT AVG(Condition) AS '������� ��������� ���� � ����������'
FROM Instance

SELECT MAX(Time_Lag) AS '������������ �������� ��������'
FROM Issue

SELECT MIN(Amount_of_Page) AS '���������� ���������� ������� � ������� "���� ���������"' 
FROM Instance WHERE Book_ID = 2

SELECT COUNT(Instance_ID) AS '���������� ����������� ���� � ����������' 
FROM Instance

SELECT COUNT(*) AS '���������� ������� � ������' 
FROM Issue

-- GROUP BY --
SELECT Client_ID AS '������', COUNT(Issue_ID) AS '���������� ����� �������'
FROM Issue
GROUP BY Client_ID

SELECT Librarian_ID AS '������������', COUNT(Issue_ID) AS '���������� ����� �������������'
FROM Issue
GROUP BY Librarian_ID

SELECT Author_ID AS '�����', COUNT(Book_ID) AS '���������� ���� ������'
FROM Book
GROUP BY Author_ID

-- HAVING --
SELECT Author_ID AS '�����', COUNT(Book_ID) AS '���������� ���� ������'
FROM Book
GROUP BY Author_ID
HAVING COUNT(Book_ID) > 2

SELECT Book_ID, COUNT(Instance_ID) AS '���������� �����������', AVG(Condition) AS '������� ��������� � ����������'
FROM Instance
GROUP BY Book_ID
HAVING AVG(Condition) > 6




