-- with
--Common Table Expression (CTE) или обобщенное табличное выражение (OTB) – 
--это временные результирующие наборы (т.е. результаты выполнения SQL запроса), 
--которые не сохраняются в базе данных в виде объектов, но к ним можно 
--обращаться.

-- Основной целью OTB является написание рекурсивных запросов, можно сказать
--для этого они, и были созданы;
-- OTB можно использовать также и для замены представлений (VIEW), например, в 
--тех случаях, когда нет необходимости сохранять в базе SQL запрос 
--представления, т.е. его определение;
-- Обобщенные табличные выражения повышают читаемость кода путем разделения 
--запроса на логические блоки, и тем самым упрощают работу со сложными запросами;
-- Также OTB предназначены и для многократных ссылок на результирующий набор 
--из одной и той же SQL инструкции.

--Какие бывают обобщенные табличные выражения?
--Они бывают простые и рекурсивные.

--Простые не включают ссылки на самого себя, а рекурсивные соответственно 
--включают.

--Рекурсивные ОТВ используются для возвращения иерархических данных, 
--например, классика жанра это отображение сотрудников в структуре 
--организации (чуть ниже мы это рассмотрим).

--При написании рекурсивного ОТВ нужно быть внимательным, так как неправильное 
--его составление может привести к бесконечному циклу. Поэтому для этих целей 
--есть опция MAXRECURSION, которая может ограничивать количество уровней 
--рекурсии. Давайте представим, что мы не уверены, что написали рекурсивное 
--обобщенное выражение правильно и для отладки напишем инструкцию OPTION 
--(MAXRECURSION 5), т.е. отобразим только 5 уровня рекурсии, и если уровней 
--будет больше, SQL инструкция будет прервана.


--
-- ROW_NUMBER – функция нумерации в Transact-SQL, которая возвращает просто 
--номер строки.
-- Синтаксис
--ROW_NUMBER () OVER ([PARTITION BY столбы группировки] ORDER BY столбец сортировки)
--partition by — это не обязательное ключевое слово, после которого указывается 
--столбец или столбцы, по которым группировать данные, а order by столбец для 
--сортировки, т.е. по данному столбцу будут отсортированы данные, а потом 
--пронумерованы, он уже обязателен. Сразу скажу, чтобы не возвращаться, что 
--эти ключевые слова относятся ко всем функциям ранжирования, которые мы будем 
--сегодня использовать.


CREATE TABLE contacts(
    contact_id INT IDENTITY(1,1) NOT NULL,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL,

	CONSTRAINT PK_Contacts PRIMARY KEY(contact_id),
);

INSERT INTO contacts
    (first_name,last_name,email) 
VALUES
    ('Syed','Abbas','syed.abbas@example.com'),
    ('Catherine','Abel','catherine.abel@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Hazem','Abolrous','hazem.abolrous@example.com'),
    ('Hazem','Abolrous','hazem.abolrous@example.com'),
    ('Humberto','Acevedo','humberto.acevedo@example.com'),
    ('Humberto','Acevedo','humberto.acevedo@example.com'),
    ('Pilar','Ackerman','pilar.ackerman@example.com');


--delete duplicates
WITH cte AS (
    SELECT contact_id, first_name, last_name, email, 
        ROW_NUMBER() OVER (
            PARTITION BY first_name, last_name, email
            ORDER BY first_name, last_name, email
        ) row_num
     FROM 
        contacts
)
DELETE FROM cte
WHERE row_num > 1;

SELECT *
FROM contacts
ORDER BY first_name, last_name, email;
