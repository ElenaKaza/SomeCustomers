--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

-- Started on 2021-03-06 13:37:20

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 200 (class 1259 OID 17878)
-- Name: some_customers1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.some_customers1 (
    title text,
    first_name text,
    last_name text,
    correspondence_language text,
    birth_date text,
    gender text,
    marital_status text,
    country text,
    postal_code text,
    region text,
    city text,
    street text,
    building_number text
);


ALTER TABLE public.some_customers1 OWNER TO postgres;

-- Completed on 2021-03-06 13:37:21

--
-- PostgreSQL database dump complete
--

