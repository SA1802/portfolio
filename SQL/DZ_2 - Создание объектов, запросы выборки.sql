use dz2;

-- 1. Используя операторы языка SQL, создайте таблицу “sales”. Заполните ее данными.
CREATE TABLE sales(
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    count_product INT);
    
INSERT INTO sales(order_date, count_product)
VALUES
	('2022-01-01', 156),
    ('2022-01-02', 180),
    ('2022-01-03', 21),
    ('2022-01-04', 124),
    ('2022-01-05', 341);

/* 2.  Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва : 
меньше 100  -    Маленький заказ
от 100 до 300 - Средний заказ
больше 300  -     Большой заказ */
SELECT id, 
	IF(count_product < 100, 'Маленький заказ', 
    IF(count_product BETWEEN 100 AND 300, 'Средний заказ', 'Большой заказ')) AS 'order_type'
FROM sales;

/* 3. Создайте таблицу “orders”, заполните ее значениями. 
Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED -  «Order is cancelled»*/
CREATE TABLE orders(
	id INT PRIMARY KEY AUTO_INCREMENT,
	employee_id VARCHAR(3),
	amount DECIMAL(6, 2),
    order_status VARCHAR(9));

INSERT INTO orders(employee_id, amount, order_status)
VALUES
	('e03', 15.00, 'OPEN'),
    ('e01', 25.50, 'OPEN'),
    ('e05', 100.70, 'CLOSED'),
    ('e02', 22.18, 'OPEN'),
    ('e04', 9.50, 'CANCELLED');

-- 1 способ
SELECT *, 
	CASE
		WHEN order_status = 'OPEN'
			THEN 'Order is in open state'
		WHEN order_status = 'CLOSED'
			THEN 'Order is closed'
		ELSE 'Order is cancelled'
    END AS full_order_status
FROM orders;

-- 2 способ
SELECT *, 
	IF(order_status = 'OPEN', 'Order is in open state',
    IF(order_status = 'CLOSED', 'Order is closed', 'Order is cancelled')) AS full_order_status
FROM orders;

-- 4. Чем 0 отличается от NULL?
/* Ответ: NULL - это специальное значение, которое используется в SQL для обозначения отсутствия данных. 
Оно отличается от пустой строки или нулевого значения, так как NULL означает отсутствие какого-либо значения в ячейке таблицы.
Для оператора SELECT предусмотрена специальная форма предложения WHERE, 
которая используется для проверки значений NULL в столбцах и содержит оператор IS NULL или NOT NULL.
Также при использовании функции COUNT() значения с NULL не учитываются. 
0 же - просто число. */