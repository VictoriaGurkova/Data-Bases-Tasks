DROP DATABASE LibDatabase

CREATE DATABASE LibDatabase
USE [LibDatabase]
GO

CREATE TABLE City
(
City_ID INT NOT NULL PRIMARY KEY,
City_Name VARCHAR(50) NOT NULL,
)

CREATE TABLE Library
(
Library_ID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Library PRIMARY KEY,
Full_Name VARCHAR(100) NOT NULL,
City_ID INT NOT NULL, -- FK
Adress VARCHAR(100) NOT NULL,
Phone_Number VARCHAR(30) NOT NULL,
)

CREATE TABLE Publish_House 
(
Publisher_ID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Publish_House PRIMARY KEY,
Short_Name VARCHAR(25) NOT NULL,
City_ID INT NOT NULL, -- FK
Adress VARCHAR(100) NOT NULL,
Phone_Number VARCHAR(30) NOT NULL,
)

CREATE TABLE Librarian
(
Librarian_ID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Librarian PRIMARY KEY,
Library_ID INT NOT NULL, -- FK
Full_Name VARCHAR(100) NOT NULL,
)


CREATE TABLE Client
(
Client_ID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Client PRIMARY KEY,
Full_Name VARCHAR(100) NOT NULL,
Adress VARCHAR(100) NOT NULL,
Phone_Number VARCHAR(30) NOT NULL,
)

CREATE TABLE Reader_Form
(
Reader_Form_ID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Reader_Form PRIMARY KEY,
Instance_ID INT NOT NULL, -- FK
Librarian_ID INT NOT NULL, -- FK
Issue_Date DATE NOT NULL,
Expected_Return_Date DATE NOT NULL,
Actual_Return_Date DATE NOT NULL,
Time_Lag INT,
)

CREATE TABLE Clients_Reader_Forms 
(
Client_ID INT NOT NULL, -- FK,
Reader_Form_ID INT UNIQUE NOT NULL, -- FK
)

CREATE TABLE Book
(
Book_ID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Book PRIMARY KEY,
Author_ID INT NOT NULL, -- FK
Category_ID INT NOT NULL, -- FK
Title VARCHAR(100) NOT NULL,
)


CREATE TABLE Instance
(
Instance_ID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Instance PRIMARY KEY,
Book_ID INT NOT NULL, -- FK
Publisher_ID INT NOT NULL, -- FK
Presence VARCHAR(10) NOT NULL,
Condition INT NOT NULL,
Year_of_Publication DATE NOT NULL,
Amount_of_Page INT NOT NULL
)

CREATE TABLE Instance_Passport 
(
Passport_ID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Instance_Passport PRIMARY KEY,
Instance_ID INT NOT NULL, -- FK
)

CREATE TABLE Issue
(
Issue_ID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Issue PRIMARY KEY,
Passport_ID INT NOT NULL, -- FK
Client_ID INT NOT NULL, -- FK
Librarian_ID INT NOT NULL, -- FK
Issue_Date DATE NOT NULL,
Expected_Return_Date DATE NOT NULL,
Actual_Return_Date DATE,
Time_Lag INT,
)

CREATE TABLE Author
(
Author_ID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Author PRIMARY KEY,
Full_Name VARCHAR(100) NOT NULL,
Pseudonym VARCHAR(50) NOT NULL,
)

CREATE TABLE Category
(
Category_ID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Category PRIMARY KEY,
Category_Name VARCHAR(50) NOT NULL,
)

ALTER TABLE Library ADD CONSTRAINT FK_Library_City 
FOREIGN KEY (City_ID) REFERENCES City (City_ID)

---------------------------------------------------

ALTER TABLE Publish_House ADD CONSTRAINT FK_Publish_House_City
FOREIGN KEY (City_ID) REFERENCES City (City_ID)

---------------------------------------------------

ALTER TABLE Librarian ADD CONSTRAINT FK_Librarian_Library
FOREIGN KEY (Library_ID) REFERENCES Library (Library_ID)

---------------------------------------------------

ALTER TABLE Reader_Form ADD CONSTRAINT FK_Reader_Form_Instance
FOREIGN KEY (Instance_ID) REFERENCES Instance (Instance_ID)

ALTER TABLE Reader_Form ADD CONSTRAINT FK_Reader_Form_Librarian
FOREIGN KEY (Librarian_ID) REFERENCES Librarian (Librarian_ID)

---------------------------------------------------

ALTER TABLE Clients_Reader_Forms ADD CONSTRAINT FK_Clients_Reader_Forms_Reader_Form
FOREIGN KEY (Reader_Form_ID) REFERENCES Reader_Form (Reader_Form_ID)

ALTER TABLE Clients_Reader_Forms ADD CONSTRAINT FK_Clients_Reader_Forms_Client
FOREIGN KEY (Client_ID) REFERENCES Client (Client_ID)

---------------------------------------------------

ALTER TABLE Book ADD CONSTRAINT FK_Book_Author
FOREIGN KEY (Author_ID) REFERENCES Author (Author_ID)

ALTER TABLE Book ADD CONSTRAINT FK_Book_Category
FOREIGN KEY (Category_ID) REFERENCES Category (Category_ID)

---------------------------------------------------

ALTER TABLE Instance ADD CONSTRAINT FK_Instance_Book
FOREIGN KEY (Book_ID) REFERENCES Book (Book_ID)

ALTER TABLE Instance ADD CONSTRAINT FK_Instance_Publish_House
FOREIGN KEY (Publisher_ID) REFERENCES Publish_House (Publisher_ID)

---------------------------------------------------

ALTER TABLE Instance_Passport ADD CONSTRAINT FK_Instance_Passport_Instance
FOREIGN KEY (Instance_ID) REFERENCES Instance (Instance_ID)

---------------------------------------------------

ALTER TABLE Issue ADD CONSTRAINT FK_Issue_Instance_Passport
FOREIGN KEY (Passport_ID) REFERENCES Instance_Passport (Passport_ID)

ALTER TABLE Issue ADD CONSTRAINT FK_Issue_Client
FOREIGN KEY (Client_ID) REFERENCES Client (Client_ID)

ALTER TABLE Issue ADD CONSTRAINT FK_Issue_Librarian
FOREIGN KEY (Librarian_ID) REFERENCES Librarian (Librarian_ID)

INSERT Author(Full_Name,Pseudonym) VALUES
(N'Александр Сергеевич Пушкин',N'Феофилакт Косичкин'),
(N'Иван Сергеевич Тургенев',N'Т. Л.'),
(N'Анна Андреевна Горенко',N'Анна Ахматова'),
(N'Михаил Юрьевич Лермонтов',N'Ламвер'),
(N'Лев Николаевич Толстой',N'Л.Н.'),
(N'Фёдор Михайлович Достоевский',N'Друг Кузьмы Пруткова')

SELECT * FROM Author

INSERT Category(Category_Name) VALUES
(N'Драма'), 
(N'Комедия'), 
(N'Ужасы'),
(N'Роман'),
(N'Любовный роман'),
(N'Философский роман'),
(N'Исторический жанр'),
(N'Военная проза'),
(N'Автобиографический роман')

SELECT * FROM Category

INSERT City(City_ID, City_Name) VALUES
(8452, N'Саратов'),
(8612, N'Краснодар'),
(812, N'Санкт-Петербург'),
(495, N'Москва'),
(8442, N'Волгоград')

SELECT * FROM City

INSERT Book(Author_ID, Category_ID, Title) VALUES
(5, 4, N'Война и мир'),
(5, 4, N'Анна Каренина'),
(5, 9, N'Детство'),
(6, 6, N'Преступление и наказание'),
(6, 6, N'Идиот')

SELECT * FROM Book

INSERT Publish_House(Short_Name, City_ID, Adress, Phone_Number) VALUES
(N'ЭКСМО', 495, N'г. Москва, ул. Зорге, д. 1', N'+7(495)411-68-86'),
(N'АСТ', 495, N'г. Москва, Пресненская наб., д. 6', N'+7(499)951-6-000'),
(N'РОСМЭН', 495, N'г. Москва, ул. Октябрьская, д. 4', N'+7(495)933-71-30'),
(N'АЛЬФА–КНИГА', 495, N'г. Москва, Бумажный проезд, д. 14', N'+7(499)458-51-07'),
(N'ВЕЧЕ', 495, N'г. Москва, ул. Алтуфьевское шоссе, 48 корп. 1', N'+7(499)940-48-70')



SELECT * FROM Publish_House

INSERT Library(Full_Name, City_ID, Adress, Phone_Number) VALUES
(N'Библиотека № 15', 8452, N'ул. Азина, 34, г. Саратов', N'8(845)249-22-85'),
(N'Центральная городская детская библиотека для детей и юношества', 8452, N'ул. Чапаева, 6,	 г. Саратов', N'8(845)220-25-81'),
(N'Зональная научная библиотека им. В. А. Артисевич', 8452, N'ул. Университетская, 42, г. Саратов', N' 8(845)251-17-58'),
(N'Библиотека № 25', 8452, N'ул. Шелковичная, 130, г. Саратов', N'8(845)251-50-77'),
(N'Детская библиотека, филиал ЦБС № 35', 8452, N'Политехническая ул., 116, г. Саратов', N'8(845)252-70-97')

SELECT * FROM Library

INSERT Librarian(Library_ID, Full_Name) VALUES
(1, N'Белозёрова Альбина Петровна'),
(1, N'Лапина Варвара Даниловна'),
(3, N'Худобяк Георгина Васильевна'),
(4, N'Гайчук Абрам Юхимович'),
(5, N'Ковальчук Дан Васильевич')

SELECT * FROM Librarian

INSERT Instance(Book_ID, Publisher_ID, Presence, Condition, Year_of_Publication, Amount_of_Page) VALUES
(2, 1, N'Да', 8, '03.05.2015', 800),
(2, 2, N'Нет', 5, '02.06.2009', 864),
(2, 4, N'Да', 6, '16.01.2012', 1056),
(5, 1, N'Да', 3, '25.07.2008', 672),
(3, 5, N'Да', 10, '29.11.2018', 160)

INSERT INTO Instance VALUES (1, 3, N'Да', 7, '17.10.2007', 1126) 

SELECT * FROM Instance

INSERT Instance_Passport(Instance_ID) VALUES
(1),
(2),
(3),
(4),
(5)

SELECT * FROM Instance_Passport

INSERT Reader_Form(Instance_ID, Librarian_ID, Issue_Date, Expected_Return_Date, Actual_Return_Date, Time_Lag) VALUES
(1, 1, '19.06.2019', '19.07.2019', '01.07.2019', 0),
(2, 5, '15.06.2019', '15.09.2019', '30.09.2019', 15),
(3, 3, '18.03.2020', '18.04.2020', '12.03.2020', 0),
(4, 4, '22.03.2020', '22.05.2020', '25.05.2020', 3),
(5, 2, '20.03.2020', '20.04.2020', '28.04.2020', 8)

SELECT * FROM Reader_Form

INSERT Client(Full_Name, Adress, Phone_Number) VALUES
(N'Едемский Галактион Глебович', N'г. Саратов, 2-й проезд Азина, 14', N'89876351245'), 
(N'Ермушин Эрик Станиславович', N'г. Саратов, ул. Чернышевского, 21', N'89058945123'),
(N'Лукин Аркадий Макарович', N'г. Саратов, ул. Чапаева, 26', N'89412235482'),
(N'Безукладников Самуил Георгиевич', N'г. Саратов, ул. Школьная, 15', N'8170256422'),
(N'Беломестнов Ермолай Вениаминович', N'г. Саратов, ул. Тракторная, 12', N'8956148237')

SELECT * FROM Client

INSERT Clients_Reader_Forms(Client_ID, Reader_Form_ID) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4), 
(4, 5)

SELECT * FROM Clients_Reader_Forms

INSERT Issue(Passport_ID, Client_ID, Librarian_ID, Issue_Date, Expected_Return_Date, Actual_Return_Date, Time_Lag) VALUES
(1, 1, 1, '19.06.2019', '19.07.2019', '01.07.2019', 0),
(2, 3, 5, '15.06.2019', '15.09.2019', '30.09.2019', 15),
(4, 1, 2, '22.08.2019', '22.09.2019', '30.08.2019', 0),
(2, 2, 5, '13.11.2019', '13.12.2019', '30.12.2019', 17),
(3, 4, 3, '18.03.2020', '18.04.2020', NULL, NULL),
(4, 5, 4, '22.03.2020', '22.05.2020', NULL, NULL),
(5, 3, 2, '20.03.2020', '20.04.2020', NULL, NULL)

INSERT INTO Issue VALUES (5, 2, 1, '18.06.2019', '18.08.2019', '30.08.2019', 12) 

SELECT * FROM Issue

DELETE Issue WHERE Time_Lag = 0 -- удаление отдельных записей
DELETE Issue -- удаление всей таблицы
SELECT * FROM Issue







