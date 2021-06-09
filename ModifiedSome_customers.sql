--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

-- Started on 2021-03-09 17:33:09

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
-- TOC entry 206 (class 1259 OID 17958)
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    id smallint NOT NULL,
    name character varying NOT NULL,
    region smallint
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE cities; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cities IS 'the list of cities';


--
-- TOC entry 205 (class 1259 OID 17956)
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cities_id_seq OWNER TO postgres;

--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 205
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- TOC entry 202 (class 1259 OID 17891)
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    id smallint NOT NULL,
    country_code character varying NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 202
-- Name: TABLE countries; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.countries IS 'list of countries';


--
-- TOC entry 201 (class 1259 OID 17889)
-- Name: countries_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."countries_ID_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."countries_ID_seq" OWNER TO postgres;

--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 201
-- Name: countries_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."countries_ID_seq" OWNED BY public.countries.id;


--
-- TOC entry 204 (class 1259 OID 17929)
-- Name: languages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.languages (
    id smallint NOT NULL,
    code character varying NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.languages OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 17927)
-- Name: languages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.languages_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.languages_id_seq OWNER TO postgres;

--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 203
-- Name: languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.languages_id_seq OWNED BY public.languages.id;


--
-- TOC entry 208 (class 1259 OID 17975)
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regions (
    id smallint NOT NULL,
    name character varying NOT NULL,
    id_country smallint NOT NULL
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN regions.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.regions.name IS 'The name of region';


--
-- TOC entry 207 (class 1259 OID 17973)
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regions_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regions_id_seq OWNER TO postgres;

--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 207
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regions_id_seq OWNED BY public.regions.id;


--
-- TOC entry 200 (class 1259 OID 17878)
-- Name: some_customers1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.some_customers1 (
    title character varying,
    first_name character varying,
    last_name character varying,
    gender character(1),
    postal_code character varying,
    street character varying,
    building_number character varying,
    id_language smallint,
    id_city smallint,
    id bigint NOT NULL,
    flat smallint
);


ALTER TABLE public.some_customers1 OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 18020)
-- Name: some_customers1_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.some_customers1_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.some_customers1_id_seq OWNER TO postgres;

--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 209
-- Name: some_customers1_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.some_customers1_id_seq OWNED BY public.some_customers1.id;


--
-- TOC entry 2882 (class 2604 OID 17961)
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- TOC entry 2880 (class 2604 OID 17894)
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public."countries_ID_seq"'::regclass);


--
-- TOC entry 2881 (class 2604 OID 17932)
-- Name: languages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languages ALTER COLUMN id SET DEFAULT nextval('public.languages_id_seq'::regclass);


--
-- TOC entry 2883 (class 2604 OID 17978)
-- Name: regions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions ALTER COLUMN id SET DEFAULT nextval('public.regions_id_seq'::regclass);


--
-- TOC entry 2879 (class 2604 OID 18022)
-- Name: some_customers1 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.some_customers1 ALTER COLUMN id SET DEFAULT nextval('public.some_customers1_id_seq'::regclass);


--
-- TOC entry 2902 (class 2606 OID 17993)
-- Name: cities CityRegionUnique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT "CityRegionUnique" UNIQUE (name, region);


--
-- TOC entry 2896 (class 2606 OID 17939)
-- Name: languages CodeMustBeUnique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT "CodeMustBeUnique" UNIQUE (code);


--
-- TOC entry 2907 (class 2606 OID 17985)
-- Name: regions CountryRegionUnique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT "CountryRegionUnique" UNIQUE (id_country, name);


--
-- TOC entry 2890 (class 2606 OID 18016)
-- Name: countries CountryUnique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT "CountryUnique" UNIQUE (name);


--
-- TOC entry 2885 (class 2606 OID 18058)
-- Name: some_customers1 CustomersUnique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.some_customers1
    ADD CONSTRAINT "CustomersUnique" UNIQUE (title, first_name, last_name, gender, id_city, street, building_number, flat);


--
-- TOC entry 2898 (class 2606 OID 17941)
-- Name: languages NameMustBeUnique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT "NameMustBeUnique" UNIQUE (name);


--
-- TOC entry 2904 (class 2606 OID 17966)
-- Name: cities citiesPk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT "citiesPk" PRIMARY KEY (id);


--
-- TOC entry 2892 (class 2606 OID 17899)
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- TOC entry 2900 (class 2606 OID 17937)
-- Name: languages languagesPk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT "languagesPk" PRIMARY KEY (id);


--
-- TOC entry 2910 (class 2606 OID 17983)
-- Name: regions regionsPk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT "regionsPk" PRIMARY KEY (id);


--
-- TOC entry 2894 (class 2606 OID 17901)
-- Name: countries short_name_must_be_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT short_name_must_be_unique UNIQUE (country_code);


--
-- TOC entry 2888 (class 2606 OID 18039)
-- Name: some_customers1 some_customers1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.some_customers1
    ADD CONSTRAINT some_customers1_pkey PRIMARY KEY (id);


--
-- TOC entry 2886 (class 1259 OID 18045)
-- Name: fki_CityFk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_CityFk" ON public.some_customers1 USING btree (id_city);


--
-- TOC entry 2908 (class 1259 OID 18014)
-- Name: fki_CountryFK; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_CountryFK" ON public.regions USING btree (id_country);


--
-- TOC entry 2905 (class 1259 OID 18008)
-- Name: fki_regionFk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_regionFk" ON public.cities USING btree (region);


--
-- TOC entry 2912 (class 2606 OID 18040)
-- Name: some_customers1 CityFk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.some_customers1
    ADD CONSTRAINT "CityFk" FOREIGN KEY (id_city) REFERENCES public.cities(id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 2914 (class 2606 OID 18009)
-- Name: regions CountryFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT "CountryFK" FOREIGN KEY (id_country) REFERENCES public.countries(id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


--
-- TOC entry 2911 (class 2606 OID 17951)
-- Name: some_customers1 languageFk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.some_customers1
    ADD CONSTRAINT "languageFk" FOREIGN KEY (id_language) REFERENCES public.languages(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2913 (class 2606 OID 18003)
-- Name: cities regionFk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT "regionFk" FOREIGN KEY (region) REFERENCES public.regions(id) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;


-- Completed on 2021-03-09 17:33:10

--
-- PostgreSQL database dump complete
--

