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

CREATE SEQUENCE snap_auth_user_uid_seq
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1;


ALTER SEQUENCE snap_auth_user_uid_seq OWNED BY snap_auth_user.uid;

ALTER TABLE ONLY snap_auth_user ALTER COLUMN uid SET DEFAULT nextval('snap_auth_user_uid_seq'::regclass);

ALTER TABLE ONLY snap_auth_user
ADD CONSTRAINT snap_auth_user_login_key UNIQUE (login);

ALTER TABLE ONLY snap_auth_user
ADD CONSTRAINT snap_auth_user_pkey PRIMARY KEY (uid);
