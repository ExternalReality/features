--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: schema_version; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_version (
    version_rank integer NOT NULL,
    installed_rank integer NOT NULL,
    version character varying(50) NOT NULL,
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


--
-- Name: snap_auth_user; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE snap_auth_user (
    uid integer NOT NULL,
    login text NOT NULL,
    email text,
    password text,
    activated_at timestamp with time zone,
    suspended_at timestamp with time zone,
    remember_token text,
    login_count integer NOT NULL,
    failed_login_count integer NOT NULL,
    locked_out_until timestamp with time zone,
    current_login_at timestamp with time zone,
    last_login_at timestamp with time zone,
    current_login_ip text,
    last_login_ip text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    reset_token text,
    reset_requested_at timestamp with time zone
);


--
-- Name: snap_auth_user_uid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE snap_auth_user_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: snap_auth_user_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE snap_auth_user_uid_seq OWNED BY snap_auth_user.uid;


--
-- Name: uid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY snap_auth_user ALTER COLUMN uid SET DEFAULT nextval('snap_auth_user_uid_seq'::regclass);


--
-- Name: schema_version_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY schema_version
    ADD CONSTRAINT schema_version_pk PRIMARY KEY (version);


--
-- Name: snap_auth_user_login_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY snap_auth_user
    ADD CONSTRAINT snap_auth_user_login_key UNIQUE (login);


--
-- Name: snap_auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY snap_auth_user
    ADD CONSTRAINT snap_auth_user_pkey PRIMARY KEY (uid);


--
-- Name: schema_version_ir_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX schema_version_ir_idx ON schema_version USING btree (installed_rank);


--
-- Name: schema_version_s_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX schema_version_s_idx ON schema_version USING btree (success);


--
-- Name: schema_version_vr_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX schema_version_vr_idx ON schema_version USING btree (version_rank);


--
-- PostgreSQL database dump complete
--

