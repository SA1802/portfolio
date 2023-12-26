/*Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. 
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '*/
delimiter //
CREATE FUNCTION good_format(seconds INT)
RETURNS varchar(100)
DETERMINISTIC
BEGIN
DECLARE days INT DEFAULT 0;
DECLARE hours INT DEFAULT 0;
DECLARE minutes INT DEFAULT 0;
DECLARE result VARCHAR(50) DEFAULT '0 1';
SET days = FLOOR(seconds/86400);
SET seconds = seconds- days*86400;
SET hours = FLOOR(seconds/3600);
SET seconds = seconds- hours*3600;
SET minutes = FLOOR(seconds/60);
SET seconds = seconds- minutes*60;
SET result = CONCAT(days, ' ', 'days', ' ', hours, ' ', 'hours', ' ', minutes, ' ', 'minutes', ' ', seconds, ' ', 'seconds');
RETURN result;
END //
delimiter ;

SELECT good_format(123456) AS РЕЗУЛЬТАТ;

-- Создайте процедуру которая, выводит только четные числа от 1 до 10. Пример: 2,4,6,8,10
delimiter //
CREATE PROCEDURE even_digits()
BEGIN
DECLARE x INT DEFAULT 2;
SET x = 2;
WHILE x<=10 DO
	SELECT x;
    SET x=x+2;
END WHILE;
END //
delimiter ;

CALL even_digits();