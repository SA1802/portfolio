use tinkoff;

CREATE TABLE Jobtitles
(
	jobtitle_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45)
);

INSERT Jobtitles
VALUES
	(1, "Разработчик"),
    (2, "Системный аналитик"), 
    (3, "Менеджер проектов"),
	(4, "Системный администратор"),
	(5, "Руководитель группы"),
	(6, "Инженер тестирования"),
	(7, "Сотрудник группы поддержки");
    
Select * from Jobtitles;

CREATE TABLE Staff
(
	staff_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    salary INT, 
    email VARCHAR(45),
    birthday date, 
    jobtitle_id int not null,
    foreign key(jobtitle_id) references Jobtitles(jobtitle_id)
);

INSERT Staff
VALUES
	(1, "Иванов Сергей", 100000, "test@test.ru", "1990-03-03", 1),
    (2, "Петров Пётр", 60000, "petr@test.ru", "2000-12-01", 7 ),
    (3, "Сидоров Василий", 80000, "test@test.ru", "1999-02-04", 6 ),
    (4, "Максимов Иван", 70000, "ivan.m@test.ru", "1997-10-02", 4),
	(5, "Попов Иван", 120000, "popov@test.ru", "2001-04-25", 5);
    
SELECT *
FROM Staff;

truncate Staff;

-- Напишите запрос, с помощью которого можно найти дубли в поле email из таблицы Sfaff.
SELECT *
FROM Staff
WHERE email IN (
	SELECT email
	FROM Staff
	GROUP BY email
	HAVING count(email) > 1
    );

/* Напишите запрос, с помощью которого можно определить возраст каждого сотрудника 
из таблицы Staff на момент запроса.*/
SELECT name AS Имя, TIMESTAMPDIFF(year, birthday, CURRENT_DATE()) as Возраст
FROM Staff;

/* Напишите запрос, с помощью которого можно определить должность (Jobtitles.name) 
со вторым по величине уровнем зарплаты. */
SELECT name AS Должность
FROM (
	SELECT Jobtitles.name, RANK() OVER(ORDER BY salary DESC) rnk 
	FROM Staff JOIN Jobtitles ON Staff.jobtitle_id = Jobtitles.jobtitle_id) q
WHERE rnk = 2;