1.копирование данных таблицы some_customers.csv в Postgres:
сначала создать таблицу в PG со столбцами типа text;

copy public.some_customers1 FROM 'C:/Lena/OTUS/MySQL/some_customers.csv' DELIMITER ','
===================
2. Create table countries  - справочник стран

3.запись в новую таблицу стран countries тех стран, которые встречаются в some_customers:

with t2 as (with t1 as (select distinct country from some_customers1)
select row_number() OVER (), * FROM t1)
insert into countries (select *, '' from t2)
---------- получился список из 21 страны---------------

4.---- вместо короткого названия страны запишем её код в поле some_customers.country:
DO $$DECLARE r record;
BEGIN
    FOR r IN SELECT country_code, countries.id  FROM countries 
	LOOP
		EXECUTE 'UPDATE some_customers1 SET country = '|| '''' || r.id || '''' ||
		'where some_customers1.country =' 
		|| '''' ||r.country_code|| '''' ;
	    END LOOP;
END$$;
----------- теперь таблица some_customers  будет пользоваться справочником стран countries. 

5. Нужно сделать для этой пары внешний ключ (поля в ключе д.б.одного типа smallint). 
Для этого надо изменить тип столбца (text на smallint) - не получилось.
Поэтому создаю новый столбец id_country(smallint) и переписываю в него значения из столбца country:

UPDATE some_customers1 SET id_country = CAST(country as smallint) 

6. Столбец some_customers.country можно удалить.

+++++++++++++++++
7.Тоже самое делаем для поля some_customers1.correspondence_language. 
Это поле  будет связано со справочником языков:
CREATE TABLE public.languages
(
    id smallserial NOT NULL,
    code character varying NOT NULL,
    name character varying NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT "CodeMustBeUnique" UNIQUE (code),
    CONSTRAINT "NameMustBeUnique" UNIQUE (name)
);

ALTER TABLE public.languages
    OWNER to postgres;
-----
Заполним таблицу языков:

with t2 as (with t1 as
(select distinct correspondence_language from some_customers1 where correspondence_language<>'')
select row_number() OVER (), * FROM t1)
insert into languages (select *, t2.correspondence_language from t2)
----------- получилось 17 строк-------
-- в поле name пришлось писать значение correspondence_language для обхода констрейнта "NameMustBeUnique" UNIQUE (name) -------

ALTER TABLE some_customers1 ADD COLUMN id_language smallint

Перенос id языков в таблицу some_customers1 в поле id_language:
DO $$DECLARE r record;
BEGIN
    FOR r IN SELECT code, id  FROM languages 
	LOOP
		EXECUTE 'UPDATE some_customers1 SET id_language = '|| '''' || r.id || '''' ||
		'where some_customers1.correspondence_language =' 
		|| '''' ||r.code|| '''' ;
	    END LOOP;
END$$;

Сделать внешний ключ.

ALTER TABLE public.some_customers1
    ADD CONSTRAINT "id_languageFk" FOREIGN KEY (id_language)
    REFERENCES public.languages (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE RESTRICT;
	
Столбец some_customers.correspondence_language можно удалить.

7. Меняем типы столбцов в таблице some_customers1;

8. Столбцы countries.name и languages.name придется заполнить вручную (данных нет)

9. Аналогично выделяем таблицы городов и регионов:
 - create table cities(id, name, region, country) - город со страной и регионом
 - заполняем данными:

 - создаем столбец some_customers1.id_city
 -создаем столбец some_customers1.id_region
  
  create table(regions) со страной, заполнить ее д-ми:
  
  with t2 as (with t1 as
(select distinct region, id_country from some_customers1 where region<>'')
select row_number() OVER (), * FROM t1)
insert into regions (select * from t2)

перенос id_region в some_customers1:

DO $$DECLARE r record;
BEGIN
    FOR r IN SELECT region, id  FROM regions
	LOOP
		EXECUTE 'UPDATE some_customers1 SET id_region = '|| '''' || r.id || '''' ||
		'where some_customers1.region =' 
		|| '''' ||r.region|| '''' ;
	    END LOOP;
END$$;
(пришлось вручную заменить значения с одинарной кавычкой на значения с апострофом. 
В дальнейшем ввод одинарной кавычки в столбец должен быть запрещен.)

 with t2 as (with t1 as
(select distinct city, id_region from some_customers1 where city<>'')
select row_number() OVER (), * FROM t1)
insert into cities (select * from t2)

Пустые ("") значения заменить на NULL
Делаем внешние ключи для новых таблиц, используя PGAdmin

В таблице some_customers1 можно оставить только поле id_city
Добавим номер квартиры

Укоротим поле gender до одной буквы:
UPDATE some_customers1 SET gender = substring(gender from 1 for 1) 

Поля martial_status, birth_day пустые, удалим их.

Добавим id.some_customers1

Добавим  в some_customers1 уникальность по полям:
title
first_name
last_name
gender
id_city
street
building_number
flat 

Сейчас этими полями определятся уникальность покупателя.
Есть одинаковые имена с разными адресами,
но мы не знаем, разные это люди или один и тот же человек просто с разными адресами.
Если бы дата рождения была бы заполнена, можно было бы некоторых разделить (не всех).
Для того, чтобы иметь возможность одному человеку иметь несколько адресов,
надо идентифицировать его по номеру телефона, например.
Тогда можно будет создать список адресов каждого человека.

  
  







