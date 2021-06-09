1.Copy table some_customers.csv into Postgres.
First create table with columns of type text: 

copy public.some_customers1 FROM 'C:/Lena/some_customers.csv' DELIMITER ','
===================

2. Create table countries  -- the list of countries 

3.An entry in the new table of countries of those countries that occur in some_customers1:

with t2 as (with t1 as (select distinct country from some_customers1)
select row_number() OVER (), * FROM t1)
insert into countries (select *, '' from t2)
-------------got a list of 21 countries---------------


4.Instead of the short name of the country, write its code in some_customers1.country

DO $$DECLARE r record;
BEGIN
    FOR r IN SELECT country_code, countries.id  FROM countries 
	LOOP
		EXECUTE 'UPDATE some_customers1 SET country = '|| '''' || r.id || '''' ||
		'where some_customers1.country =' 
		|| '''' ||r.country_code|| '''' ;
	    END LOOP;
END$$;
-------------Now the table some_customers will use the countries list


5.We need to make a foreign key for this pair (fields in the key should be of the same type smallint).
--To do this, we need to change the column type (text to smallint) - it didn't work.
Therefore, I create a new column id_country (smallint) and rewrite the values from the country column into it:

UPDATE some_customers1 SET id_country = CAST(country as smallint) 

6. Column some_customers1.country can be removed.

+++++++++++++++++
7.We do the same for the some_customers1.correspondence_language field.
This field will be associated with the language catalog:

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
Fill in language catalog:

with t2 as (with t1 as
(select distinct correspondence_language from some_customers1 where correspondence_language<>'')
select row_number() OVER (), * FROM t1)
insert into languages (select *, t2.correspondence_language from t2)
-----------it turned out 17 lines----------

-- in the "name" field I had to write the "correspondence_language" value to bypass the "NameMustBeUnique" UNIQUE (name) -------

ALTER TABLE some_customers1 ADD COLUMN id_language smallint

---Transferring the id of languages to the some_customers1 table in the id_language field:

DO $$DECLARE r record;
BEGIN
    FOR r IN SELECT code, id  FROM languages 
	LOOP
		EXECUTE 'UPDATE some_customers1 SET id_language = '|| '''' || r.id || '''' ||
		'where some_customers1.correspondence_language =' 
		|| '''' ||r.code|| '''' ;
	    END LOOP;
END$$;

---Create foreign key.

ALTER TABLE public.some_customers1
    ADD CONSTRAINT "id_languageFk" FOREIGN KEY (id_language)
    REFERENCES public.languages (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE RESTRICT;
	
---The some_customers.correspondence_language column can be removed.


7.Change the types of columns in the some_customers1 table;

8.The countries.name and languages.name columns will have to be filled in manually (no data available).

9. Likewise, we isolate the tables of cities and regions:

 - create table cities(id, name, region, country) -- city with country and region 
 - fill in with data:
 
 - Create a column some_customers1.id_city
 - Create a column some_customers1.id_region
   
  create table(regions) -- with the country, fill it
  
  with t2 as (with t1 as
(select distinct region, id_country from some_customers1 where region<>'')
select row_number() OVER (), * FROM t1)
insert into regions (select * from t2)

transferring id_region to some_customers1:

DO $$DECLARE r record;
BEGIN
    FOR r IN SELECT region, id  FROM regions
	LOOP
		EXECUTE 'UPDATE some_customers1 SET id_region = '|| '''' || r.id || '''' ||
		'where some_customers1.region =' 
		|| '''' ||r.region|| '''' ;
	    END LOOP;
END$$;

(Had to manually replace values with single quotes with values with apostrophes.
In the future, entering a single quote in a column should be prohibited.)

 with t2 as (with t1 as
(select distinct city, id_region from some_customers1 where city<>'')
select row_number() OVER (), * FROM t1)
insert into cities (select * from t2)

Replace empty ("") values with NULL.
Making Foreign Keys for New Tables Using PGAdmin.

Only the id_city field can be left in the some_customers1 table.
Add the apartment number.

--Let's shorten the gender field to one letter

UPDATE some_customers1 SET gender = substring(gender from 1 for 1) 

The martial_status, birth_day fields are empty, remove them.

Add id.some_customers1.

Add uniqueness by fields to some_customers1:

title
first_name
last_name
gender
id_city
street
building_number
flat 

Now these fields will determine the uniqueness of the customer.
There are the same names with different addresses,
but we do not know if they are different people or the same person with just different addresses.
If the date of birth were filled in, some could be split (not all).
In order to be able to have several addresses for one person,
you need to identify it by phone number, for example.
Then it will be possible to create a list of addresses for each person.

  
  







