--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: employee; Type: TABLE; Schema: public; Owner: hex
--

CREATE TABLE public.employee (
    first_name character varying(20) NOT NULL,
    surname character varying(30) NOT NULL,
    middle_name character varying(20),
    birthday date,
    id integer NOT NULL,
    id_position integer,
    update_time timestamp without time zone NOT NULL
);


ALTER TABLE public.employee OWNER TO hex;

--
-- Name: employee_id_seq; Type: SEQUENCE; Schema: public; Owner: hex
--

CREATE SEQUENCE public.employee_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_id_seq OWNER TO hex;

--
-- Name: employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hex
--

ALTER SEQUENCE public.employee_id_seq OWNED BY public.employee.id;


--
-- Name: position; Type: TABLE; Schema: public; Owner: hex
--

CREATE TABLE public."position" (
    position_name character varying(60) NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public."position" OWNER TO hex;

--
-- Name: position_id_seq; Type: SEQUENCE; Schema: public; Owner: hex
--

CREATE SEQUENCE public.position_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.position_id_seq OWNER TO hex;

--
-- Name: vacation; Type: TABLE; Schema: public; Owner: hex
--

CREATE TABLE public.vacation (
    id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    employee_id integer NOT NULL,
    year date
);


ALTER TABLE public.vacation OWNER TO hex;

--
-- Name: vacation_id_seq; Type: SEQUENCE; Schema: public; Owner: hex
--

CREATE SEQUENCE public.vacation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vacation_id_seq OWNER TO hex;

--
-- Name: vacations_per_year; Type: TABLE; Schema: public; Owner: hex
--

CREATE TABLE public.vacations_per_year (
    id integer NOT NULL,
    days integer NOT NULL,
    year date NOT NULL,
    employee_id integer NOT NULL
);


ALTER TABLE public.vacations_per_year OWNER TO hex;

--
-- Name: vacations_per_year_id_seq; Type: SEQUENCE; Schema: public; Owner: hex
--

CREATE SEQUENCE public.vacations_per_year_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vacations_per_year_id_seq OWNER TO hex;

--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: hex
--

COPY public.employee (first_name, surname, middle_name, birthday, id, id_position, update_time) FROM stdin;
Joey	Baxter	Joe	1993-03-10	25	12	2019-08-23 10:50:15.801696
Calum	Olsen	\N	\N	20	4	2019-08-23 10:50:21.09645
Sabiha	Corona	\N	1985-02-04	35	4	2019-08-23 10:50:27.246985
Zidan	Chamberlain	\N	1967-09-06	38	21	2019-08-28 01:21:53.489969
Mclaughlin	Cade	Neala	1978-12-10	12	13	2019-08-23 10:12:45.956357
\.


--
-- Data for Name: position; Type: TABLE DATA; Schema: public; Owner: hex
--

COPY public."position" (position_name, id) FROM stdin;
engineer	4
director	5
accountant	12
head of economic department	13
logistician	21
\.


--
-- Data for Name: vacation; Type: TABLE DATA; Schema: public; Owner: hex
--

COPY public.vacation (id, start_date, end_date, employee_id, year) FROM stdin;
9	2019-08-05	2019-08-13	20	2019-01-01
1	2019-10-13	2019-10-19	25	2017-01-01
12	2017-06-12	2017-06-18	35	2017-01-01
13	2017-09-11	2017-09-24	35	2017-01-01
14	2018-04-16	2018-04-22	35	2017-01-01
15	2018-06-11	2018-06-25	35	2018-01-01
16	2018-08-13	2018-08-28	35	2018-01-01
17	2019-06-10	2019-06-16	35	2019-01-01
18	2019-08-12	2019-08-18	35	2019-01-01
19	2019-09-16	2019-09-29	35	2019-01-01
20	2020-05-11	2020-05-24	35	2020-01-01
21	2020-06-15	2020-06-21	35	2020-01-01
23	2020-08-17	2020-08-23	35	2020-01-01
25	2018-06-04	2018-06-30	38	2018-01-01
26	2018-09-02	2018-09-02	38	2018-01-01
27	2019-10-07	2019-10-14	38	2019-01-01
28	2019-11-18	2019-11-26	38	2019-01-01
29	2019-09-15	2019-09-25	38	2019-01-01
30	2019-04-14	2019-04-27	12	2019-01-01
32	2019-09-09	2019-09-22	12	2019-01-01
35	2020-05-03	2020-05-30	12	2020-01-01
\.


--
-- Data for Name: vacations_per_year; Type: TABLE DATA; Schema: public; Owner: hex
--

COPY public.vacations_per_year (id, days, year, employee_id) FROM stdin;
25	28	2017-01-01	20
26	28	2018-01-01	20
27	31	2019-01-01	20
28	31	2020-01-01	20
21	28	2017-01-01	35
22	31	2018-01-01	35
23	28	2019-01-01	35
24	28	2020-01-01	35
17	31	2017-01-01	25
18	28	2018-01-01	25
19	28	2019-01-01	25
20	28	2020-01-01	25
33	28	2017-01-01	12
34	28	2018-01-01	12
35	28	2019-01-01	12
36	28	2020-01-01	12
29	28	2017-01-01	38
30	28	2018-01-01	38
31	28	2019-01-01	38
32	28	2020-01-01	38
\.


--
-- Name: employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hex
--

SELECT pg_catalog.setval('public.employee_id_seq', 38, true);


--
-- Name: position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hex
--

SELECT pg_catalog.setval('public.position_id_seq', 21, true);


--
-- Name: vacation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hex
--

SELECT pg_catalog.setval('public.vacation_id_seq', 35, true);


--
-- Name: vacations_per_year_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hex
--

SELECT pg_catalog.setval('public.vacations_per_year_id_seq', 36, true);


--
-- Name: employee employee_pk; Type: CONSTRAINT; Schema: public; Owner: hex
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pk PRIMARY KEY (id);


--
-- Name: position position_pk; Type: CONSTRAINT; Schema: public; Owner: hex
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_pk PRIMARY KEY (id);


--
-- Name: position position_un; Type: CONSTRAINT; Schema: public; Owner: hex
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_un UNIQUE (position_name);


--
-- Name: vacation vacation_pk; Type: CONSTRAINT; Schema: public; Owner: hex
--

ALTER TABLE ONLY public.vacation
    ADD CONSTRAINT vacation_pk PRIMARY KEY (id);


--
-- Name: employee employee_fk; Type: FK CONSTRAINT; Schema: public; Owner: hex
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_fk FOREIGN KEY (id_position) REFERENCES public."position"(id);


--
-- Name: vacation vacation_fk; Type: FK CONSTRAINT; Schema: public; Owner: hex
--

ALTER TABLE ONLY public.vacation
    ADD CONSTRAINT vacation_fk FOREIGN KEY (employee_id) REFERENCES public.employee(id);


--
-- Name: vacations_per_year vacations_per_year_fk; Type: FK CONSTRAINT; Schema: public; Owner: hex
--

ALTER TABLE ONLY public.vacations_per_year
    ADD CONSTRAINT vacations_per_year_fk FOREIGN KEY (employee_id) REFERENCES public.employee(id);


--
-- PostgreSQL database dump complete
--

