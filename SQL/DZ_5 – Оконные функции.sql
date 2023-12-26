use dz5;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
CREATE VIEW price_lower_25000 AS
	SELECT name
    from cars
    WHERE cost < 25000;

SELECT * FROM price_lower_25000;

-- 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
ALTER VIEW price_lower_25000 AS
	SELECT name
    from cars
    WHERE cost < 30000; 
    
-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)
CREATE VIEW new_view AS
	SELECT *
    FROM cars
    WHERE name IN('Skoda', 'Audi');

SELECT * FROM new_view;

-- 1* Получить ранжированный список автомобилей по цене в порядке возрастания
SELECT DENSE_RANK () OVER (ORDER BY cost) Ранг_авто, name 
FROM cars;

-- 2* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость
SELECT name, sum(cost) OVER() AS total_price
FROM (SELECT name, cost FROM cars ORDER BY cost DESC LIMIT 3) AS table_1;

-- 3* Получить список автомобилей, у которых цена больше предыдущей цены (т.е. у которых произошло повышение цены)
SELECT name 
FROM (SELECT name, cost, LAG(cost) OVER() AS lg FROM cars) AS table_2 
WHERE cost > lg;

-- 4* Получить список автомобилей, у которых цена меньше следующей цены (т.е. у которых произойдет снижение цены)
SELECT name 
FROM (SELECT name, cost, LEAD(cost) OVER() ld FROM cars) AS table_2 
WHERE cost < ld;

/*5*Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец 
со значением разницы между текущей ценой и ценой следующего автомобиля*/
SELECT name, cost, cost-LEAD(cost) OVER(ORDER BY cost) AS 'Разница'
from cars;