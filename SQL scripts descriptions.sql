1.����������� ������ ������� some_customers.csv � Postgres:
������� ������� ������� � PG �� ��������� ���� text;

copy public.some_customers1 FROM 'C:/Lena/OTUS/MySQL/some_customers.csv' DELIMITER ','
===================
2. Create table countries  - ���������� �����

3.������ � ����� ������� ����� countries ��� �����, ������� ����������� � some_customers:

with t2 as (with t1 as (select distinct country from some_customers1)
select row_number() OVER (), * FROM t1)
insert into countries (select *, '' from t2)
---------- ��������� ������ �� 21 ������---------------

4.---- ������ ��������� �������� ������ ������� � ��� � ���� some_customers.country:
DO $$DECLARE r record;
BEGIN
    FOR r IN SELECT country_code, countries.id  FROM countries 
	LOOP
		EXECUTE 'UPDATE some_customers1 SET country = '|| '''' || r.id || '''' ||
		'where some_customers1.country =' 
		|| '''' ||r.country_code|| '''' ;
	    END LOOP;
END$$;
----------- ������ ������� some_customers  ����� ������������ ������������ ����� countries. 

5. ����� ������� ��� ���� ���� ������� ���� (���� � ����� �.�.������ ���� smallint). 
��� ����� ���� �������� ��� ������� (text �� smallint) - �� ����������.
������� ������ ����� ������� id_country(smallint) � ����������� � ���� �������� �� ������� country:

UPDATE some_customers1 SET id_country = CAST(country as smallint) 

6. ������� some_customers.country ����� �������.

+++++++++++++++++
7.���� ����� ������ ��� ���� some_customers1.correspondence_language. 
��� ����  ����� ������� �� ������������ ������:
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
�������� ������� ������:

with t2 as (with t1 as
(select distinct correspondence_language from some_customers1 where correspondence_language<>'')
select row_number() OVER (), * FROM t1)
insert into languages (select *, t2.correspondence_language from t2)
----------- ���������� 17 �����-------
-- � ���� name �������� ������ �������� correspondence_language ��� ������ ����������� "NameMustBeUnique" UNIQUE (name) -------

ALTER TABLE some_customers1 ADD COLUMN id_language smallint

������� id ������ � ������� some_customers1 � ���� id_language:
DO $$DECLARE r record;
BEGIN
    FOR r IN SELECT code, id  FROM languages 
	LOOP
		EXECUTE 'UPDATE some_customers1 SET id_language = '|| '''' || r.id || '''' ||
		'where some_customers1.correspondence_language =' 
		|| '''' ||r.code|| '''' ;
	    END LOOP;
END$$;

������� ������� ����.

ALTER TABLE public.some_customers1
    ADD CONSTRAINT "id_languageFk" FOREIGN KEY (id_language)
    REFERENCES public.languages (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE RESTRICT;
	
������� some_customers.correspondence_language ����� �������.

7. ������ ���� �������� � ������� some_customers1;

8. ������� countries.name � languages.name �������� ��������� ������� (������ ���)

9. ���������� �������� ������� ������� � ��������:
 - create table cities(id, name, region, country) - ����� �� ������� � ��������
 - ��������� �������:

 - ������� ������� some_customers1.id_city
 -������� ������� some_customers1.id_region
  
  create table(regions) �� �������, ��������� �� �-��:
  
  with t2 as (with t1 as
(select distinct region, id_country from some_customers1 where region<>'')
select row_number() OVER (), * FROM t1)
insert into regions (select * from t2)

������� id_region � some_customers1:

DO $$DECLARE r record;
BEGIN
    FOR r IN SELECT region, id  FROM regions
	LOOP
		EXECUTE 'UPDATE some_customers1 SET id_region = '|| '''' || r.id || '''' ||
		'where some_customers1.region =' 
		|| '''' ||r.region|| '''' ;
	    END LOOP;
END$$;
(�������� ������� �������� �������� � ��������� �������� �� �������� � ����������. 
� ���������� ���� ��������� ������� � ������� ������ ���� ��������.)

 with t2 as (with t1 as
(select distinct city, id_region from some_customers1 where city<>'')
select row_number() OVER (), * FROM t1)
insert into cities (select * from t2)

������ ("") �������� �������� �� NULL
������ ������� ����� ��� ����� ������, ��������� PGAdmin

� ������� some_customers1 ����� �������� ������ ���� id_city
������� ����� ��������

�������� ���� gender �� ����� �����:
UPDATE some_customers1 SET gender = substring(gender from 1 for 1) 

���� martial_status, birth_day ������, ������ ��.

������� id.some_customers1

�������  � some_customers1 ������������ �� �����:
title
first_name
last_name
gender
id_city
street
building_number
flat 

������ ����� ������ ����������� ������������ ����������.
���� ���������� ����� � ������� ��������,
�� �� �� �����, ������ ��� ���� ��� ���� � ��� �� ������� ������ � ������� ��������.
���� �� ���� �������� ���� �� ���������, ����� ���� �� ��������� ��������� (�� ����).
��� ����, ����� ����� ����������� ������ �������� ����� ��������� �������,
���� ���������������� ��� �� ������ ��������, ��������.
����� ����� ����� ������� ������ ������� ������� ��������.

  
  







