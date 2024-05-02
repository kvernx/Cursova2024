--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--



--
-- Name: getarrivalchildren(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getarrivalchildren(arrivalid integer) RETURNS TABLE(name text, surname text, birthdate date, sex character, id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT "Contact".name, "Contact".surname, "Contact"."birthDate", "Contact".sex, "Client".id
    FROM "Contact"

    INNER JOIN "Client" ON "Contact".id="Client"."contactId"
    INNER JOIN "Bed" ON "Bed".id="Client"."bedId"
    INNER JOIN "Room" ON "Room".id="Bed"."roomId"
    INNER JOIN "House" ON "House".id="Room"."houseId"

    INNER JOIN "Detachment" ON "Detachment".id="Client"."detachmentId"
    INNER JOIN "Arrival" ON "Arrival".id="Detachment"."arrivalId"

    WHERE arrivalid = "Arrival".id;
END
$$;


ALTER FUNCTION public.getarrivalchildren(arrivalid integer) OWNER TO postgres;

--
-- Name: gethousebeds(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.gethousebeds(housename text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    bed_count INT;
BEGIN
    SELECT COALESCE(SUM("Room"."bedAmount"),0) INTO bed_count
    FROM "House"
    INNER JOIN "Room" ON "Room"."houseId"="House".id
    WHERE "House".name = houseName;

    RETURN bed_count;
END
$$;


ALTER FUNCTION public.gethousebeds(housename text) OWNER TO postgres;

--
-- Name: gethouseresidents(integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.gethouseresidents(arrivalid integer, housename text) RETURNS TABLE(name text, surname text, birthdate date, sex character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT "Contact".name, "Contact".surname, "Contact"."birthDate", "Contact".sex
    FROM "Contact"

    INNER JOIN "Client" ON "Contact".id="Client"."contactId"
    INNER JOIN "Bed" ON "Bed".id="Client"."bedId"
    INNER JOIN "Room" ON "Room".id="Bed"."roomId"
    INNER JOIN "House" ON "House".id="Room"."houseId"

    INNER JOIN "Detachment" ON "Detachment".id="Client"."detachmentId"
    INNER JOIN "Arrival" ON "Arrival".id="Detachment"."arrivalId"

    WHERE arrivalId = "Arrival".id AND houseName = "House".name;
END
$$;


ALTER FUNCTION public.gethouseresidents(arrivalid integer, housename text) OWNER TO postgres;

--
-- Name: getroomresidents(integer, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getroomresidents(arrivalid integer, housename text, roomnumber integer) RETURNS TABLE(name text, surname text, birthdate date, sex character)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT "Contact".name, "Contact".surname, "Contact"."birthDate", "Contact".sex
    FROM "Contact"
        
    INNER JOIN "Client" ON "Contact".id="Client"."contactId"
    INNER JOIN "Bed" ON "Bed".id="Client"."bedId"
    INNER JOIN "Room" ON "Room".id="Bed"."roomId"
    INNER JOIN "House" ON "House".id="Room"."houseId"

    INNER JOIN "Detachment" ON "Detachment".id="Client"."detachmentId"
    INNER JOIN "Arrival" ON "Arrival".id="Detachment"."arrivalId"

    WHERE arrivalId = "Arrival".id AND houseName = "House".name AND roomNumber = "Room".number;
END
$$;


ALTER FUNCTION public.getroomresidents(arrivalid integer, housename text, roomnumber integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Arrival; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Arrival" (
    id integer NOT NULL,
    "beginningDate" date NOT NULL,
    "endDate" date NOT NULL,
    price double precision NOT NULL
);


ALTER TABLE public."Arrival" OWNER TO postgres;

--
-- Name: Bed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Bed" (
    id integer NOT NULL,
    number integer NOT NULL,
    "roomId" integer NOT NULL
);


ALTER TABLE public."Bed" OWNER TO postgres;

--
-- Name: Client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Client" (
    id integer NOT NULL,
    alergy text,
    preferences integer,
    "bedId" integer NOT NULL,
    "contactId" integer NOT NULL,
    "detachmentId" integer NOT NULL
);


ALTER TABLE public."Client" OWNER TO postgres;

--
-- Name: Contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Contact" (
    id integer NOT NULL,
    name text NOT NULL,
    surname text NOT NULL,
    adress text,
    "birthDate" date NOT NULL,
    "phoneNumber" text NOT NULL,
    sex character(1)
);


ALTER TABLE public."Contact" OWNER TO postgres;

--
-- Name: Detachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Detachment" (
    id integer NOT NULL,
    name text NOT NULL,
    "arrivalId" integer NOT NULL
);


ALTER TABLE public."Detachment" OWNER TO postgres;

--
-- Name: House; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."House" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."House" OWNER TO postgres;

--
-- Name: HouseSupervisor; Type: TABLE; Schema: public; Owner: postgres
--


--
-- Name: Room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Room" (
    id integer NOT NULL,
    number integer NOT NULL,
    balcony boolean NOT NULL,
    floor integer NOT NULL,
    "houseId" integer NOT NULL,
    "bedAmount" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."Room" OWNER TO postgres;

--
-- Name: Spending; Type: TABLE; Schema: public; Owner: postgres
--




--
-- Name: Supervisor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Supervisor" (
    id integer NOT NULL,
    "contactId" integer NOT NULL,
    education text,
    "detachmentId" integer NOT NULL
);


ALTER TABLE public."Supervisor" OWNER TO postgres;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    login text,
    password text,
    id integer NOT NULL
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Users_id_seq" OWNER TO postgres;

--
-- Name: Users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Users_id_seq" OWNED BY public."Users".id;


--
-- Name: Users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users" ALTER COLUMN id SET DEFAULT nextval('public."Users_id_seq"'::regclass);


--
-- Data for Name: Arrival; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Users_id_seq"', 2, true);


--
-- Name: Arrival Arrival_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Arrival"
    ADD CONSTRAINT "Arrival_pkey" PRIMARY KEY (id);


--
-- Name: Bed Bed_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bed"
    ADD CONSTRAINT "Bed_pkey" PRIMARY KEY (id);


--
-- Name: Client Client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (id);


--
-- Name: Contact Contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contact"
    ADD CONSTRAINT "Contact_pkey" PRIMARY KEY (id);


--
-- Name: Detachment Detachment _pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Detachment"
    ADD CONSTRAINT "Detachment _pkey" PRIMARY KEY (id);


--
-- Name: HouseSupervisor HouseSupervisor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--



--
-- Name: House House_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."House"
    ADD CONSTRAINT "House_pkey" PRIMARY KEY (id);


--
-- Name: Room Room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Room"
    ADD CONSTRAINT "Room_pkey" PRIMARY KEY (id);


--
-- Name: Spending Spending_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--


--
-- Name: Supervisor Supervisor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Supervisor"
    ADD CONSTRAINT "Supervisor_pkey" PRIMARY KEY (id);


--
-- Name: Users Users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pk" PRIMARY KEY (id);


--
-- Name: House constraint_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."House"
    ADD CONSTRAINT constraint_name UNIQUE (name);


--
-- Name: Bed Bed_roomId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bed"
    ADD CONSTRAINT "Bed_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES public."Room"(id);


--
-- Name: Client Client_bedId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_bedId_fkey" FOREIGN KEY ("bedId") REFERENCES public."Bed"(id) NOT VALID;


--
-- Name: Client Client_contactId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES public."Contact"(id) NOT VALID;


--
-- Name: Client Client_detachmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_detachmentId_fkey" FOREIGN KEY ("detachmentId") REFERENCES public."Detachment"(id) NOT VALID;


--
-- Name: Detachment Detachment _arrivalId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Detachment"
    ADD CONSTRAINT "Detachment _arrivalId_fkey" FOREIGN KEY ("arrivalId") REFERENCES public."Arrival"(id) ON DELETE RESTRICT;


--
-- Name: HouseSupervisor HouseSupervisor_houseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--



--
-- Name: HouseSupervisor HouseSupervisor_supervisorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--



--
-- Name: Room Room_houseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Room"
    ADD CONSTRAINT "Room_houseId_fkey" FOREIGN KEY ("houseId") REFERENCES public."House"(id);


--
-- Name: Spending Spending_arrivalId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--


--
-- Name: Supervisor Supervisor_contactId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Supervisor"
    ADD CONSTRAINT "Supervisor_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES public."Contact"(id);


--
-- Name: Supervisor Supervisor_detachmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Supervisor"
    ADD CONSTRAINT "Supervisor_detachmentId_fkey" FOREIGN KEY ("detachmentId") REFERENCES public."Detachment"(id);


--
-- PostgreSQL database dump complete
--

