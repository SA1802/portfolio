use dz1;

-- 1. Создайте и заполните таблицу с мобильными телефонами.
CREATE TABLE Phones(
	id INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(20),
    Manufacturer VARCHAR(20),
    ProductCount INT,
    Price INT);

INSERT INTO phones(ProductName, Manufacturer, ProductCount, Price)
VALUES 
	('IPhone X', 'Apple', 3, 76000),
    ('IPhone 8', 'Apple', 2, 51000),
    ('Galaxy S9', 'Samsung', 2, 56000),
    ('Galaxy S8', 'Samsung', 1, 41000),
    ('P20 Pro', 'Huawei', 5, 36000);

-- 2. Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT ProductName, Manufacturer, Price
FROM phones
WHERE ProductCount > 2;

-- 3. Выведите весь ассортимент товаров марки “Samsung”
SELECT * FROM phones
WHERE Manufacturer = 'Samsung';

-- 4.1 Товары, в которых есть упоминание "Iphone"
SELECT *
FROM phones
WHERE ProductName LIKE '%IPhone%';

-- 	4.2. "Samsung" 
SELECT *
FROM phones
WHERE Manufacturer LIKE '%Samsung%';

-- 4.3.  Товары, в которых есть ЦИФРА "8"  
SELECT *
FROM phones
WHERE ProductName LIKE '%8%';