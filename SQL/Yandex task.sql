/*Вам доступны данные о помесячной выручке сети магазинов Диэлектрик за 12 месяцев. Данные хранятся в
таблице со схемой:
CREATE TABLE revenue_data(
	shop_id integer NOT NULL,
	city text NOT NULL,
	month text NOT NULL,
	revenue integer NOT NULL
);
Необходимо для каждого города найти top-3 магазина с наибольшей выручкой без учета
магазинов с суммарной выручкой меньше 120. Для выбранных магазинов также нужно
вычислить долю их выручки в суммарной выручке всех магазинов того же города. Долю
округлить до целого числа процентов.
В результате у вас должно получиться 3 колонки: city, shop_id, city_revenue_share.
Результат должен быть упорядочен по:
1) названию города (city) в лексикографическом порядке;
2) доле выручки в городе (city_revenue_share) от наибольшей к наименьшей;
3) идентификатору магазина (shop_id) в порядке возрастания.*/

USE task_yndx;

CREATE TABLE revenue_data(
	shop_id integer NOT NULL,
	city text NOT NULL,
	month text NOT NULL,
	revenue integer NOT NULL
);

INSERT INTO revenue_data
VALUES
    (1, 'MSK', '1', 14),
    (1, 'MSK', '2', 12),
    (1, 'MSK', '3', 10),
    (1, 'MSK', '4', 14),
    (1, 'MSK', '5', 9),
    (1, 'MSK', '6', 9),
    (1, 'MSK', '7', 11),
    (1, 'MSK', '8', 13),
    (1, 'MSK', '9', 9),
    (1, 'MSK', '10', 9),
    (1, 'MSK', '11', 13),
    (1, 'MSK', '12', 10),
    (2, 'MSK', '1', 13),
    (2, 'MSK', '2', 11),
    (2, 'MSK', '3', 12),
    (2, 'MSK', '4', 9),
    (2, 'MSK', '5', 10),
    (2, 'MSK', '6', 14),
    (2, 'MSK', '7', 11),
    (2, 'MSK', '8', 14),
    (2, 'MSK', '9', 9),
    (2, 'MSK', '10', 11),
    (2, 'MSK', '11', 9),
    (2, 'MSK', '12', 12),
    (3, 'MSK', '1', 12),
    (3, 'MSK', '2', 11),
    (3, 'MSK', '3', 14),
    (3, 'MSK', '4', 11),
    (3, 'MSK', '5', 13),
    (3, 'MSK', '6', 11),
    (3, 'MSK', '7', 9),
    (3, 'MSK', '8', 11),
    (3, 'MSK', '9', 9),
    (3, 'MSK', '10', 13),
    (3, 'MSK', '11', 9),
    (3, 'MSK', '12', 11),
    (4, 'MSK', '1', 11),
    (4, 'MSK', '2', 13),
    (4, 'MSK', '3', 10),
    (4, 'MSK', '4', 14),
    (4, 'MSK', '5', 14),
    (4, 'MSK', '6', 10),
    (4, 'MSK', '7', 9),
    (4, 'MSK', '8', 9),
    (4, 'MSK', '9', 10),
    (4, 'MSK', '10', 13),
    (4, 'MSK', '11', 11),
    (4, 'MSK', '12', 14),
    (5, 'MSK', '1', 12),
    (5, 'MSK', '2', 14),
    (5, 'MSK', '3', 14),
    (5, 'MSK', '4', 12),
    (5, 'MSK', '5', 9),
    (5, 'MSK', '6', 10),
    (5, 'MSK', '7', 9),
    (5, 'MSK', '8', 12),
    (5, 'MSK', '9', 13),
    (5, 'MSK', '10', 12),
    (5, 'MSK', '11', 11),
    (5, 'MSK', '12', 9),
    (6, 'MSK', '1', 13),
    (6, 'MSK', '2', 14),
    (6, 'MSK', '3', 13),
    (6, 'MSK', '4', 13),
    (6, 'MSK', '5', 12),
    (6, 'MSK', '6', 12),
    (6, 'MSK', '7', 13),
    (6, 'MSK', '8', 14),
    (6, 'MSK', '9', 11),
    (6, 'MSK', '10', 9),
    (6, 'MSK', '11', 10),
    (6, 'MSK', '12', 14),
    (7, 'SPB', '1', 11),
    (7, 'SPB', '2', 9),
    (7, 'SPB', '3', 10),
    (7, 'SPB', '4', 11),
    (7, 'SPB', '5', 11),
    (7, 'SPB', '6', 12),
    (7, 'SPB', '7', 13),
    (7, 'SPB', '8', 10),
    (7, 'SPB', '9', 12),
    (7, 'SPB', '10', 10),
    (7, 'SPB', '11', 9),
    (7, 'SPB', '12', 11),
    (8, 'SPB', '1', 12),
    (8, 'SPB', '2', 9),
    (8, 'SPB', '3', 12),
    (8, 'SPB', '4', 12),
    (8, 'SPB', '5', 13),
    (8, 'SPB', '6', 9),
    (8, 'SPB', '7', 12),
    (8, 'SPB', '8', 11),
    (8, 'SPB', '9', 12),
    (8, 'SPB', '10', 12),
    (8, 'SPB', '11', 11),
    (8, 'SPB', '12', 11),
    (9, 'SPB', '1', 11),
    (9, 'SPB', '2', 9),
    (9, 'SPB', '3', 9),
    (9, 'SPB', '4', 11),
    (9, 'SPB', '5', 10),
    (9, 'SPB', '6', 11),
    (9, 'SPB', '7', 10),
    (9, 'SPB', '8', 13),
    (9, 'SPB', '9', 11),
    (9, 'SPB', '10', 9),
    (9, 'SPB', '11', 12),
    (9, 'SPB', '12', 10),
    (10, 'SPB', '1', 11),
    (10, 'SPB', '2', 9),
    (10, 'SPB', '3', 12),
    (10, 'SPB', '4', 13),
    (10, 'SPB', '5', 12),
    (10, 'SPB', '6', 13),
    (10, 'SPB', '7', 13),
    (10, 'SPB', '8', 12),
    (10, 'SPB', '9', 11),
    (10, 'SPB', '10', 11),
    (10, 'SPB', '11', 10),
    (10, 'SPB', '12', 12),
    (11, 'SPB', '1', 13),
    (11, 'SPB', '2', 9),
    (11, 'SPB', '3', 9),
    (11, 'SPB', '4', 11),
    (11, 'SPB', '5', 11),
    (11, 'SPB', '6', 13),
    (11, 'SPB', '7', 9),
    (11, 'SPB', '8', 12),
    (11, 'SPB', '9', 9),
    (11, 'SPB', '10', 11),
    (11, 'SPB', '11', 11),
    (11, 'SPB', '12', 13),
    (12, 'SPB', '1', 9),
    (12, 'SPB', '2', 10),
    (12, 'SPB', '3', 10),
    (12, 'SPB', '4', 12),
    (12, 'SPB', '5', 9),
    (12, 'SPB', '6', 12),
    (12, 'SPB', '7', 10),
    (12, 'SPB', '8', 9),
    (12, 'SPB', '9', 13),
    (12, 'SPB', '10', 9),
    (12, 'SPB', '11', 9),
    (12, 'SPB', '12', 13),
    (13, 'EKB', '1', 8),
    (13, 'EKB', '2', 10),
    (13, 'EKB', '3', 8),
    (13, 'EKB', '4', 11),
    (13, 'EKB', '5', 13),
    (13, 'EKB', '6', 10),
    (13, 'EKB', '7', 8),
    (13, 'EKB', '8', 9),
    (13, 'EKB', '9', 13),
    (13, 'EKB', '10', 13),
    (13, 'EKB', '11', 10),
    (13, 'EKB', '12', 11),
    (14, 'EKB', '1', 10),
    (14, 'EKB', '2', 10),
    (14, 'EKB', '3', 9),
    (14, 'EKB', '4', 11),
    (14, 'EKB', '5', 8),
    (14, 'EKB', '6', 8),
    (14, 'EKB', '7', 14),
    (14, 'EKB', '8', 12),
    (14, 'EKB', '9', 14),
    (14, 'EKB', '10', 13),
    (14, 'EKB', '11', 10),
    (14, 'EKB', '12', 13),
    (15, 'EKB', '1', 12),
    (15, 'EKB', '2', 10),
    (15, 'EKB', '3', 11),
    (15, 'EKB', '4', 8),
    (15, 'EKB', '5', 8),
    (15, 'EKB', '6', 13),
    (15, 'EKB', '7', 10),
    (15, 'EKB', '8', 9),
    (15, 'EKB', '9', 12),
    (15, 'EKB', '10', 9),
    (15, 'EKB', '11', 9),
    (15, 'EKB', '12', 13),
    (16, 'EKB', '1', 13),
    (16, 'EKB', '2', 14),
    (16, 'EKB', '3', 8),
    (16, 'EKB', '4', 11),
    (16, 'EKB', '5', 8),
    (16, 'EKB', '6', 14),
    (16, 'EKB', '7', 11),
    (16, 'EKB', '8', 9),
    (16, 'EKB', '9', 11),
    (16, 'EKB', '10', 8),
    (16, 'EKB', '11', 12),
    (16, 'EKB', '12', 14),
    (17, 'EKB', '1', 14),
    (17, 'EKB', '2', 8),
    (17, 'EKB', '3', 10),
    (17, 'EKB', '4', 8),
    (17, 'EKB', '5', 9),
    (17, 'EKB', '6', 12),
    (17, 'EKB', '7', 11),
    (17, 'EKB', '8', 12),
    (17, 'EKB', '9', 9),
    (17, 'EKB', '10', 8),
    (17, 'EKB', '11', 14),
    (17, 'EKB', '12', 11),
    (18, 'UFA', '1', 9),
    (18, 'UFA', '2', 10),
    (18, 'UFA', '3', 12),
    (18, 'UFA', '4', 9),
    (18, 'UFA', '5', 12),
    (18, 'UFA', '6', 11),
    (18, 'UFA', '7', 12),
    (18, 'UFA', '8', 12),
    (18, 'UFA', '9', 9),
    (18, 'UFA', '10', 10),
    (18, 'UFA', '11', 13),
    (18, 'UFA', '12', 12),
    (19, 'UFA', '1', 12),
    (19, 'UFA', '2', 13),
    (19, 'UFA', '3', 13),
    (19, 'UFA', '4', 10),
    (19, 'UFA', '5', 9),
    (19, 'UFA', '6', 10),
    (19, 'UFA', '7', 8),
    (19, 'UFA', '8', 11),
    (19, 'UFA', '9', 12),
    (19, 'UFA', '10', 11),
    (19, 'UFA', '11', 9),
    (19, 'UFA', '12', 10),
    (20, 'UFA', '1', 12),
    (20, 'UFA', '2', 8),
    (20, 'UFA', '3', 11),
    (20, 'UFA', '4', 10),
    (20, 'UFA', '5', 12),
    (20, 'UFA', '6', 8),
    (20, 'UFA', '7', 8),
    (20, 'UFA', '8', 11),
    (20, 'UFA', '9', 11),
    (20, 'UFA', '10', 8),
    (20, 'UFA', '11', 12),
    (20, 'UFA', '12', 11),
    (21, 'UFA', '1', 13),
    (21, 'UFA', '2', 13),
    (21, 'UFA', '3', 13),
    (21, 'UFA', '4', 11),
    (21, 'UFA', '5', 8),
    (21, 'UFA', '6', 8),
    (21, 'UFA', '7', 13),
    (21, 'UFA', '8', 8),
    (21, 'UFA', '9', 11),
    (21, 'UFA', '10', 11),
    (21, 'UFA', '11', 11),
    (21, 'UFA', '12', 12),
    (22, 'OMSK', '1', 8),
    (22, 'OMSK', '2', 9),
    (22, 'OMSK', '3', 10),
    (22, 'OMSK', '4', 12),
    (22, 'OMSK', '5', 12),
    (22, 'OMSK', '6', 9),
    (22, 'OMSK', '7', 9),
    (22, 'OMSK', '8', 10),
    (22, 'OMSK', '9', 11),
    (22, 'OMSK', '10', 10),
    (22, 'OMSK', '11', 12),
    (22, 'OMSK', '12', 12),
    (23, 'OMSK', '1', 11),
    (23, 'OMSK', '2', 10),
    (23, 'OMSK', '3', 9),
    (23, 'OMSK', '4', 12),
    (23, 'OMSK', '5', 10),
    (23, 'OMSK', '6', 8),
    (23, 'OMSK', '7', 12),
    (23, 'OMSK', '8', 9),
    (23, 'OMSK', '9', 12),
    (23, 'OMSK', '10', 12),
    (23, 'OMSK', '11', 10),
    (23, 'OMSK', '12', 9),
    (24, 'OMSK', '1', 10),
    (24, 'OMSK', '2', 12),
    (24, 'OMSK', '3', 11),
    (24, 'OMSK', '4', 12),
    (24, 'OMSK', '5', 9),
    (24, 'OMSK', '6', 10),
    (24, 'OMSK', '7', 12),
    (24, 'OMSK', '8', 8),
    (24, 'OMSK', '9', 12),
    (24, 'OMSK', '10', 10),
    (24, 'OMSK', '11', 12),
    (24, 'OMSK', '12', 8),
    (25, 'OMSK', '1', 8),
    (25, 'OMSK', '2', 8),
    (25, 'OMSK', '3', 12),
    (25, 'OMSK', '4', 12),
    (25, 'OMSK', '5', 10),
    (25, 'OMSK', '6', 10),
    (25, 'OMSK', '7', 12),
    (25, 'OMSK', '8', 8),
    (25, 'OMSK', '9', 8),
    (25, 'OMSK', '10', 12),
    (25, 'OMSK', '11', 10),
    (25, 'OMSK', '12', 11);

SELECT * FROM revenue_data;
    
WITH cities_ranked_by_revenue AS(
	SELECT
		city, 
		shop_id, 
		RANK() OVER(PARTITION BY city ORDER BY sum(revenue) DESC) AS rnk, 
		sum(revenue) AS shop_total_rev, 
		sum(sum(revenue)) OVER(PARTITION BY city) AS city_total_rev
	FROM revenue_data
	GROUP BY shop_id)
SELECT  
	city, 
    shop_id, 
    round((shop_total_rev/city_total_rev)*100) AS city_revenue_share
FROM cities_ranked_by_revenue
WHERE rnk <= 3 AND shop_total_rev >= 120
ORDER BY city, city_revenue_share DESC, shop_id;