--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

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
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO blog;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO blog;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO blog;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO blog;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO blog;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO blog;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO blog;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO blog;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO blog;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO blog;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO blog;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO blog;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: blog_comment; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.blog_comment (
    id integer NOT NULL,
    name character varying(80) NOT NULL,
    email character varying(254) NOT NULL,
    body text NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    active boolean NOT NULL,
    post_id integer NOT NULL
);


ALTER TABLE public.blog_comment OWNER TO blog;

--
-- Name: blog_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.blog_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_comment_id_seq OWNER TO blog;

--
-- Name: blog_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.blog_comment_id_seq OWNED BY public.blog_comment.id;


--
-- Name: blog_post; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.blog_post (
    id integer NOT NULL,
    title character varying(250) NOT NULL,
    slug character varying(250) NOT NULL,
    body text NOT NULL,
    publish timestamp with time zone NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    status character varying(10) NOT NULL,
    author_id integer NOT NULL,
    title_ru character varying(250),
    title_en character varying(250),
    body_ru text,
    body_en text
);


ALTER TABLE public.blog_post OWNER TO blog;

--
-- Name: blog_post_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.blog_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_post_id_seq OWNER TO blog;

--
-- Name: blog_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.blog_post_id_seq OWNED BY public.blog_post.id;


--
-- Name: blog_profile; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.blog_profile (
    id integer NOT NULL,
    date_of_birth date,
    photo character varying(100),
    user_id integer NOT NULL
);


ALTER TABLE public.blog_profile OWNER TO blog;

--
-- Name: blog_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.blog_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_profile_id_seq OWNER TO blog;

--
-- Name: blog_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.blog_profile_id_seq OWNED BY public.blog_profile.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO blog;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO blog;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO blog;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO blog;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO blog;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO blog;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO blog;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO blog;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.django_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO blog;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: django_summernote_attachment; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.django_summernote_attachment (
    id integer NOT NULL,
    name character varying(100),
    file character varying(255) NOT NULL,
    uploaded timestamp with time zone NOT NULL
);


ALTER TABLE public.django_summernote_attachment OWNER TO blog;

--
-- Name: django_summernote_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.django_summernote_attachment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_summernote_attachment_id_seq OWNER TO blog;

--
-- Name: django_summernote_attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog
--

ALTER SEQUENCE public.django_summernote_attachment_id_seq OWNED BY public.django_summernote_attachment.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: blog_comment id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.blog_comment ALTER COLUMN id SET DEFAULT nextval('public.blog_comment_id_seq'::regclass);


--
-- Name: blog_post id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.blog_post ALTER COLUMN id SET DEFAULT nextval('public.blog_post_id_seq'::regclass);


--
-- Name: blog_profile id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.blog_profile ALTER COLUMN id SET DEFAULT nextval('public.blog_profile_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: django_summernote_attachment id; Type: DEFAULT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_summernote_attachment ALTER COLUMN id SET DEFAULT nextval('public.django_summernote_attachment_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add post	1	add_post
2	Can change post	1	change_post
3	Can delete post	1	delete_post
4	Can view post	1	view_post
5	Can add comment	2	add_comment
6	Can change comment	2	change_comment
7	Can delete comment	2	delete_comment
8	Can view comment	2	view_comment
9	Can add log entry	3	add_logentry
10	Can change log entry	3	change_logentry
11	Can delete log entry	3	delete_logentry
12	Can view log entry	3	view_logentry
13	Can add permission	4	add_permission
14	Can change permission	4	change_permission
15	Can delete permission	4	delete_permission
16	Can view permission	4	view_permission
17	Can add group	5	add_group
18	Can change group	5	change_group
19	Can delete group	5	delete_group
20	Can view group	5	view_group
21	Can add user	6	add_user
22	Can change user	6	change_user
23	Can delete user	6	delete_user
24	Can view user	6	view_user
25	Can add content type	7	add_contenttype
26	Can change content type	7	change_contenttype
27	Can delete content type	7	delete_contenttype
28	Can view content type	7	view_contenttype
29	Can add session	8	add_session
30	Can change session	8	change_session
31	Can delete session	8	delete_session
32	Can view session	8	view_session
33	Can add site	9	add_site
34	Can change site	9	change_site
35	Can delete site	9	delete_site
36	Can view site	9	view_site
37	Can add attachment	10	add_attachment
38	Can change attachment	10	change_attachment
39	Can delete attachment	10	delete_attachment
40	Can view attachment	10	view_attachment
41	Can add profile	11	add_profile
42	Can change profile	11	change_profile
43	Can delete profile	11	delete_profile
44	Can view profile	11	view_profile
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$180000$hoVxTvmYBYSh$CZreI/tLmDszSQHyHPP7CrrjcbznSCB6attE0zogC/o=	\N	f	j2X8V8DhAGc8			account@gmail.com	f	t	2020-05-06 20:11:12+03
7	pbkdf2_sha256$216000$n2rI0VEhJKgA$nzvJ7NOEO+bbfuIcNnH0Bb9tXZVZP6xuPpkYll1h1o8=	2021-04-08 16:30:26.89286+03	f	alexs	Алексей		alex.shef@tut.by	f	t	2021-03-30 23:28:04.714381+03
1	pbkdf2_sha256$180000$OwXO2kpR9q6q$SFV7+VED0z23kG9NYkie27GT1O8aq4h8VNckqpEC96k=	2021-05-21 13:19:06.694155+03	t	root	Alexei	Shevchuck	alexei.shef@gmail.com	t	t	2020-04-22 13:08:09+03
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: blog_comment; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.blog_comment (id, name, email, body, created, updated, active, post_id) FROM stdin;
1	alex	account@gmail.com	Интересно будет узнать	2020-04-25 23:33:30.125146+03	2020-05-13 21:57:22.321532+03	t	4
6	Алексей	alexei.shef@gmail.com	когда уже добавите инфу	2020-04-25 23:54:00.708934+03	2020-04-25 23:55:45.483265+03	f	4
2	Алексей	alex.shef@tut.by	пампарапам	2021-03-30 18:54:43.259852+03	2021-04-04 22:57:02.684779+03	t	19
8	Роман	account@gmail.com	3 test-comment	2021-04-20 12:39:09.513607+03	2021-04-20 12:42:32.887925+03	f	19
9	alex	alex.shef@tut.by	4 test-comment	2021-04-20 12:39:55.629943+03	2021-04-20 12:42:38.207393+03	f	19
10	alex	alex.shef@tut.by	5 test-comment	2021-04-20 12:40:36.258716+03	2021-04-20 12:42:42.524229+03	f	19
7	alex	admin@myletter.com	2 test-comment	2021-04-20 12:38:26.394241+03	2021-04-20 12:43:08.082533+03	t	19
11	alex	alex.shef@tut.by	test_comment	2021-05-21 14:06:13.255627+03	2021-05-21 14:06:13.255627+03	t	20
12	alex	alex.shef@tut.by	test_comment	2021-05-21 14:07:36.081344+03	2021-05-21 14:07:36.081344+03	t	20
13	alex	alex.shef@tut.by	test	2021-05-21 14:17:16.364895+03	2021-05-21 14:17:16.364895+03	t	20
\.


--
-- Data for Name: blog_post; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.blog_post (id, title, slug, body, publish, created, updated, status, author_id, title_ru, title_en, body_ru, body_en) FROM stdin;
1	Soon about Belgazprombank	bgp	International transfers\r\nOnline-transfers "Unistream"\r\nMobilePay\r\nPromotions and promotional games	2020-04-22 10:33:09+03	2020-04-22 10:34:14.689497+03	2021-04-28 12:50:34.997403+03	published	1	Скоро о Белгазпромбанке	Soon about Belgazprombank	Международные переводы\r\nОнлайн-переводы "Юнистрим"\r\nMobilePay\r\nАкции и рекламные игры	International transfers\r\nOnline-transfers "Unistream"\r\nMobilePay\r\nPromotions and promotional games
24	test2	test2	<p>test2</p>	2021-04-28 00:43:26+03	2021-04-28 00:44:23.495402+03	2021-04-28 19:12:26.477835+03	draft	1	тест2	test2	<p>тест2</p>	<p>test2</p>
12	Money transfers with Belgazprombank	denezhnye-perevody-s-belgazprombankom	<p><b>Transfers from the card of Belgazprombank to the card of other banks.</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/upload/iblock/2bd/mp_pscnc_1_.jpg" style="width: 160px;"><b><br></b></p><p>With" Mastercard MoneySend "and" Visa Payments and Transfers", money transfers become much easier and more convenient. Each cardholder of Belgazprombank can make money transfers to cardholders of VISA and Mastercard payment systems of other banks through ATMs of Belgazprombank. To do this, you need to know the recipient's bank card number.</p><p></p><p><a href="https://belgazprombank.by/personal_banking/perevesti_dengi/perevodi_s_kart_bgpb/" target="_blank">More detailed</a></p><p><br></p><p><b>"UNISTREAM" money transfers</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/upload/resize_cache/iblock/a01/220_170_2/unistream.jpg" style="width: 220px;"><b><br></b></p><p>Money transfers to individuals</p><p>Transfer delivery time: from 10 minutes after sending the transfer</p><p>Money transfers are made in Belarusian rubles, US dollars, euros, Russian rubles</p><p>The commission for sending the transfer is determined in accordance with the tariffs of the UNISTREAM system. The commission can be calculated on the website of the Unistream system</p><p>Receiving a transfer without paying a commission</p><p>Online-transfers from bank cards with the transfer being issued to the recipient in cash</p><p><a href="https://belgazprombank.by/personal_banking/perevesti_dengi/perevodi_unistream/" target="_blank">More detailed</a></p><p><br></p><p><b>Transfers of funds of individuals through the correspondent and branch network of Gazprombank (Joint-stock Company)</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/upload/iblock/b4e/gpb_logo.jpg" style="width: 220px;"><b><br></b></p><p>The transfer can be sent from Gazprombank (Joint-stock Company) to JSC Belgazprombank (the destination is specified by the sender).</p><p>The transfer is made within one banking day</p><p>Currency of transfers – US dollars, Euros, Russian rubles</p><p>Receiving a transfer without paying a commission</p><p><a href="https://belgazprombank.by/personal_banking/perevesti_dengi/prevody_gpb_express/" target="_blank">More detailed</a></p><p><br></p><p><b>Bank money transfers SWIFT</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/upload/iblock/574/swift_logo_2.jpg" style="width: 220px;"><b><br></b></p><p>JSC "Belgazprombank" makes bank transfers of individuals in foreign currency outside the Republic of Belarus to legal entities and individuals at the bank details specified by the sender of the transfer. The delivery time of bank transfers depends on the currency of the transfer and, as a rule, does not exceed 2 banking days.</p><p><a href="https://belgazprombank.by/personal_banking/perevesti_dengi/perevodi_swift/" target="_blank">More detailed</a></p>	2020-04-27 10:32:22+03	2020-04-27 10:33:31.683557+03	2021-04-28 17:40:42.069197+03	published	1	Денежные переводы с Белгазпромбанком	Money transfers with Belgazprombank	<p><b>Переводы с карты Белгазпромбанка на карту других банков.</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/upload/iblock/2bd/mp_pscnc_1_.jpg" style="width: 160px;"><b><br></b></p><p>С «Masterсard MoneySend» и «Платежи и переводы Visa» денежные переводы становятся гораздо проще и удобнее. Каждый владелец карты Белгазпромбанка может совершать переводы денежных средств владельцам карт платежных систем VISA и Masterсard других банков через банкоматы Белгазпромбанка. Для этого нужно знать номер банковской карты получателя.</p><p></p><p><a href="https://belgazprombank.by/personal_banking/perevesti_dengi/perevodi_s_kart_bgpb/" target="_blank">Подробнее</a></p><p><br></p><p><b>Денежные переводы «ЮНИСТРИМ»</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/upload/resize_cache/iblock/a01/220_170_2/unistream.jpg" style="width: 220px;"><b><br></b></p><p>Денежные переводы в адрес физических лиц</p><p>Срок доставки перевода: от 10 минут после отправки перевода</p><p>Денежные переводы осуществляются в белорусских рублях, долларах США, евро, российских рублях</p><p>Комиссия за отправку перевода определяется в соответствии с тарифами системы «ЮНИСТРИМ». Комиссию возможно рассчитать на сайте системы «Юнистрим»</p><p>Получение перевода без уплаты комиссии</p><p>Online-переводы с банковских карточек с выдачей перевода получателю наличными</p><p><a href="https://belgazprombank.by/personal_banking/perevesti_dengi/perevodi_unistream/" target="_blank">Подробнее</a></p><p><br></p><p><b>Переводы денежных средств физических лиц через корреспондентскую и филиальную сеть «Газпромбанк» (Акционерное общество)</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/upload/iblock/b4e/gpb_logo.jpg" style="width: 220px;"><b><br></b></p><p>Перевод можно отправить из «Газпромбанк» (Акционерное общество) в ОАО «Белгазпромбанк» (пункт назначения указывается отправителем).</p><p>Перевод осуществляется в течение одного банковского дня</p><p>Валюта переводов – доллары США, евро, российские рубли</p><p>Получение перевода без уплаты комиссии</p><p><a href="https://belgazprombank.by/personal_banking/perevesti_dengi/prevody_gpb_express/" target="_blank">Подробнее</a></p><p><br></p><p><b>Банковские денежные переводы SWIFT</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/upload/iblock/574/swift_logo_2.jpg" style="width: 220px;"><b><br></b></p><p>ОАО«Белгазпромбанк» осуществляет банковские переводы физических лиц в иностранной валюте за пределы Республики Беларусь в адрес юридических и физических лиц по указанным отправителем перевода реквизитам. Срок доставки банковских переводов зависит от валюты перевода и, как правило, не превышает 2 банковских дней.</p><p><a href="https://belgazprombank.by/personal_banking/perevesti_dengi/perevodi_swift/" target="_blank">Подробнее</a></p>	<p><b>Transfers from the card of Belgazprombank to the card of other banks.</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/upload/iblock/2bd/mp_pscnc_1_.jpg" style="width: 160px;"><b><br></b></p><p>With" Mastercard MoneySend "and" Visa Payments and Transfers", money transfers become much easier and more convenient. Each cardholder of Belgazprombank can make money transfers to cardholders of VISA and Mastercard payment systems of other banks through ATMs of Belgazprombank. To do this, you need to know the recipient's bank card number.</p><p></p><p><a href="https://belgazprombank.by/personal_banking/perevesti_dengi/perevodi_s_kart_bgpb/" target="_blank">More detailed</a></p><p><br></p><p><b>"UNISTREAM" money transfers</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/upload/resize_cache/iblock/a01/220_170_2/unistream.jpg" style="width: 220px;"><b><br></b></p><p>Money transfers to individuals</p><p>Transfer delivery time: from 10 minutes after sending the transfer</p><p>Money transfers are made in Belarusian rubles, US dollars, euros, Russian rubles</p><p>The commission for sending the transfer is determined in accordance with the tariffs of the UNISTREAM system. The commission can be calculated on the website of the Unistream system</p><p>Receiving a transfer without paying a commission</p><p>Online-transfers from bank cards with the transfer being issued to the recipient in cash</p><p><a href="https://belgazprombank.by/personal_banking/perevesti_dengi/perevodi_unistream/" target="_blank">More detailed</a></p><p><br></p><p><b>Transfers of funds of individuals through the correspondent and branch network of Gazprombank (Joint-stock Company)</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/upload/iblock/b4e/gpb_logo.jpg" style="width: 220px;"><b><br></b></p><p>The transfer can be sent from Gazprombank (Joint-stock Company) to JSC Belgazprombank (the destination is specified by the sender).</p><p>The transfer is made within one banking day</p><p>Currency of transfers – US dollars, Euros, Russian rubles</p><p>Receiving a transfer without paying a commission</p><p><a href="https://belgazprombank.by/personal_banking/perevesti_dengi/prevody_gpb_express/" target="_blank">More detailed</a></p><p><br></p><p><b>Bank money transfers SWIFT</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/upload/iblock/574/swift_logo_2.jpg" style="width: 220px;"><b><br></b></p><p>JSC "Belgazprombank" makes bank transfers of individuals in foreign currency outside the Republic of Belarus to legal entities and individuals at the bank details specified by the sender of the transfer. The delivery time of bank transfers depends on the currency of the transfer and, as a rule, does not exceed 2 banking days.</p><p><a href="https://belgazprombank.by/personal_banking/perevesti_dengi/perevodi_swift/" target="_blank">More detailed</a></p>
19	Promotions in Priorbank	akcii-v-priorbanke	<ul><li>Advertising Games</li><li>Discounts from partners</li><li>Premium Card Privileges</li><li>Partner promotions</li></ul><p><a href="https://www.priorbank.by/promotions#notes" target="_blank">More detailed</a></p>	2020-05-12 14:11:14+03	2020-04-27 14:15:20.638989+03	2021-04-28 19:11:54.594949+03	published	1	Акции в Приорбанке	Promotions in Priorbank	<ul><li>Рекламные игры</li><li>Скидки от партнеров</li><li>Привилегии премиальных карт</li><li>Акции партнеров</li></ul><p><a href="https://www.priorbank.by/promotions#notes" target="_blank">Подробнее</a></p>	<ul><li>Advertising Games</li><li>Discounts from partners</li><li>Premium Card Privileges</li><li>Partner promotions</li></ul><p><a href="https://www.priorbank.by/promotions#notes" target="_blank">More detailed</a></p>
21	test	test	<p>test</p>	2020-05-12 10:13:52+03	2020-05-12 10:14:18.880904+03	2021-04-30 17:51:06.703297+03	draft	1	тест	test	<p>тест</p>	<p>test</p>
20	"Halva" from MTBank	halva-ot-mtbanka	<div style="display: flex; align-items: flex-end;">\r\n<img src="/media/django-summernote/2020-04-27/0ad8a428-3ba4-4382-85d5-cb42aed004a6.png" style="width: 146px; height: 423.391px;">\r\n<img src="/media/django-summernote/2020-04-27/5771fecd-4267-4a94-a06e-16cefb0feb02.png" style="width: 25%;">&nbsp;&nbsp;&nbsp;\r\n<img src="/media/django-summernote/2020-04-27/9d94a9d1-2161-49a6-a274-11afb880fb8a.png" style="width: 25%;">\r\n<img src="/media/django-summernote/2020-04-27/9e05dbb7-60ef-432e-ab59-6a61fe69ff59.png" style="width: 163.808px; height: 427.4px;"></div>\r\n<p>The New Halva is two installment cards at once: Halva MIX and Halva MAX, each with its own unique set of benefits.</p><p>Halva MAX is an installment card that gives maximum benefits to the holder. The expanded functionality of the card opens up new opportunities for the realization of all desires.</p><p>Halva MIX - a card that combines and "mixes" all the most necessary advantages of the installment card for optimal solution of daily tasks.</p><p><a href="https://www.mtbank.by/private/cards/mixmax-cards">More detailed</a></p>	2020-05-11 14:45:08+03	2020-04-27 14:46:17.953608+03	2021-04-28 19:06:15.28608+03	published	1	"Халва" от МТБанка	"Halva" from MTBank	<div style="display: flex; align-items: flex-end;">\r\n<img src="/media/django-summernote/2020-04-27/0ad8a428-3ba4-4382-85d5-cb42aed004a6.png" style="width: 146px; height: 423.391px;">\r\n<img src="/media/django-summernote/2020-04-27/5771fecd-4267-4a94-a06e-16cefb0feb02.png" style="width: 25%;">&nbsp;&nbsp;&nbsp;\r\n<img src="/media/django-summernote/2020-04-27/9d94a9d1-2161-49a6-a274-11afb880fb8a.png" style="width: 25%;">\r\n<img src="/media/django-summernote/2020-04-27/9e05dbb7-60ef-432e-ab59-6a61fe69ff59.png" style="width: 163.808px; height: 427.4px;"></div>\r\n<p>Новая Халва – это сразу две карты рассрочки: Халва MIX и Халва MAX , каждая со своим уникальным набором преимуществ.</p><p>Халва MAX – карта рассрочки, которая даёт максимум преимуществ для держателя. Расширенный функционал карты открывает новые возможности для воплощения всех желаний.</p><p>Халва MIX – карта, в которой сочетаются и «миксуются» все самые необходимые преимущества карты рассрочки для оптимального решения ежедневных задач.</p><p><a href="https://www.mtbank.by/private/cards/mixmax-cards">Подробнее</a></p>	<div style="display: flex; align-items: flex-end;">\r\n<img src="/media/django-summernote/2020-04-27/0ad8a428-3ba4-4382-85d5-cb42aed004a6.png" style="width: 146px; height: 423.391px;">\r\n<img src="/media/django-summernote/2020-04-27/5771fecd-4267-4a94-a06e-16cefb0feb02.png" style="width: 25%;">&nbsp;&nbsp;&nbsp;\r\n<img src="/media/django-summernote/2020-04-27/9d94a9d1-2161-49a6-a274-11afb880fb8a.png" style="width: 25%;">\r\n<img src="/media/django-summernote/2020-04-27/9e05dbb7-60ef-432e-ab59-6a61fe69ff59.png" style="width: 163.808px; height: 427.4px;"></div>\r\n<p>The New Halva is two installment cards at once: Halva MIX and Halva MAX, each with its own unique set of benefits.</p><p>Halva MAX is an installment card that gives maximum benefits to the holder. The expanded functionality of the card opens up new opportunities for the realization of all desires.</p><p>Halva MIX - a card that combines and "mixes" all the most necessary advantages of the installment card for optimal solution of daily tasks.</p><p><a href="https://www.mtbank.by/private/cards/mixmax-cards">More detailed</a></p>
2	Soon about BPS-Sberbank	bps	Individual bank safes\r\nDepersonalized metal accounts	2020-04-22 13:41:52+03	2020-04-22 13:41:56.225572+03	2021-04-28 12:54:38.02906+03	published	1	Скоро о БПС-Сбербанке	Soon about BPS-Sberbank	Индивидуальные банковские сейфы\r\nОбезличенные металлические счета	Individual bank safes\r\nDepersonalized metal accounts
3	Soon about Belarusbank	belarusbank	TaxFree\r\nCollection of foreign currency in cash	2020-04-22 13:46:20+03	2020-04-22 13:46:28.786048+03	2021-04-28 12:56:25.916841+03	published	1	Скоро о Беларусбанке	Soon about Belarusbank	TaxFree\r\nИнкассо наличной иностранной валюты	TaxFree\r\nCollection of foreign currency in cash
4	Soon about Priorbank	priorbank	"Your plans"\r\nPromotions	2020-04-23 15:51:09+03	2020-04-23 15:51:46.638674+03	2021-04-28 12:57:39.733903+03	published	1	Скоро о Приорбанке	Soon about Priorbank	"Ваши планы"\r\nАкции	"Your plans"\r\nPromotions
5	Soon about Alfa-Bank	alfa-bank	Solution packages\r\nOnline service\r\nSecurity service	2020-04-23 16:27:13+03	2020-04-23 16:28:12.330215+03	2021-04-28 13:00:26.877341+03	published	1	Скоро об Альфа-Банке	Soon about Alfa-Bank	Пакеты решений\r\nОнлайн-сервис\r\nСервис охраны	Solution packages\r\nOnline service\r\nSecurity service
10	"Unistream" online transfers from Visa and Mastercard bank cards with Belgazprombank	online-perevody-unistream-s-bankovskih-kartochek-visa-i-mastercard-s-belgazprombankom	<p style="text-align: center; box-sizing: inherit; margin-bottom: 1em; line-height: 1.4285em; color: rgb(51, 51, 51); font-family: Roboto, &quot;Helvetica Neue&quot;, Arial, Helvetica, sans-serif; font-size: 15.4px;"><img src="/media/django-summernote/2020-04-27/2a2da9b2-1a5f-4f0c-b7a3-6dd018fc92e2.png" style="width: 397.355px; height: 207.6px;"><br></p>\r\n\r\n<p style="box-sizing: inherit; margin-bottom: 1em; line-height: 1.4285em; color: rgb(51, 51, 51); font-family: Roboto, &quot;Helvetica Neue&quot;, Arial, Helvetica, sans-serif; font-size: 15.4px;">\r\nMoney transfers in Russia, to the CIS countries and abroad: Armenia, Kazakhstan, Moldova, Uzbekistan, Kyrgyzstan, Tajikistan, Belarus, Bulgaria, Great Britain, Vietnam, Germany, Greece, Georgia, Israel, Italy, Cyprus, Latvia, Lithuania, Mongolia, Serbia, Turkey, the Philippines, the Czech Republic, as well as many other countries in Europe and the world. More than 150,000 cash collection points around the world.\r\n</p>\r\n\r\n<a href="https://belgazprombank.by/personal_banking/perevesti_dengi/online-perevody-unistream/" target="_blank">https://belgazprombank.by/personal_banking/perevesti_dengi/online-perevody-unistream/</a>\r\n\r\n<p style="box-sizing: inherit; margin-bottom: 1em; line-height: 1.4285em; color: rgb(51, 51, 51); font-family: Roboto, &quot;Helvetica Neue&quot;, Arial, Helvetica, sans-serif; font-size: 15.4px;"><span style="box-sizing: inherit; font-weight: bolder;">Unistream is one of the largest money transfer systems in Russia.</span></p><p style="box-sizing: inherit; margin-bottom: 1em; line-height: 1.4285em; color: rgb(51, 51, 51); font-family: Roboto, &quot;Helvetica Neue&quot;, Arial, Helvetica, sans-serif; font-size: 15.4px;">\r\nThe money transfer division at Uniastrum Bank was created by Gagik Zakaryan and Georgy Piskov in 2001, and was named Unistream.<br><br>A large number of safe and conveniently located service points, low tariffs and a high level of customer service quickly made Unistream popular among migrants working in Russia who send money to their families.<br><br>Unistream became an independent bank in 2006.<br><br>Unistream customers are served in 150,000 locations in 90 countries.<br><br>Since 2016, Unistream also operates online money transfers, available both on the bank's website and in the mobile app.<br><br>Over 117,000 customers use the Unistream VISA card for mobile money transfers and other payments. 318 banks and retail chains provide their customers with money transfer services using the Unistream system.<br><br>In 2018, users made over 5.5 million money transfers totaling 227 billion rubles to Armenia, Uzbekistan, Moldova, Tajikistan, Kyrgyzstan, the Philippines and many other countries around the world.<br><br>In the last three years, more than 10 million customers have transferred money to their families using Unistream.<br><br>Unistream is constantly working to improve its tariff policy, developing and applying new technologies to make money transfers more accessible, secure and convenient.</p>	2020-04-26 16:21:41+03	2020-04-26 16:24:10.970637+03	2021-04-28 16:50:57.828072+03	published	1	Online-переводы Unistream с банковских карточек Visa и Mastercard с Белгазпромбанком	"Unistream" online transfers from Visa and Mastercard bank cards with Belgazprombank	<p style="text-align: center; box-sizing: inherit; margin-bottom: 1em; line-height: 1.4285em; color: rgb(51, 51, 51); font-family: Roboto, &quot;Helvetica Neue&quot;, Arial, Helvetica, sans-serif; font-size: 15.4px;"><img src="/media/django-summernote/2020-04-27/2a2da9b2-1a5f-4f0c-b7a3-6dd018fc92e2.png" style="width: 397.355px; height: 207.6px;"><br></p>\r\n\r\n<p style="box-sizing: inherit; margin-bottom: 1em; line-height: 1.4285em; color: rgb(51, 51, 51); font-family: Roboto, &quot;Helvetica Neue&quot;, Arial, Helvetica, sans-serif; font-size: 15.4px;">\r\nДенежные переводы по России, в страны СНГ и за рубеж: Армения, Казахстан, Молдова, Узбекистан, Кыргызстан, Таджикистан, Беларусь, Болгария, Великобритания, Вьетнам, Германия, Греция, Грузия, Израиль, Италия, Кипр, Латвия, Литва, Монголия, Сербия, Турция, Филиппины, Чехия, а также многие другие страны Европы и мира. Более 150 000 пунктов выдачи наличных по всему миру.\r\n</p>\r\n\r\n<a href="https://belgazprombank.by/personal_banking/perevesti_dengi/online-perevody-unistream/" target="_blank">https://belgazprombank.by/personal_banking/perevesti_dengi/online-perevody-unistream/</a>\r\n\r\n<p style="box-sizing: inherit; margin-bottom: 1em; line-height: 1.4285em; color: rgb(51, 51, 51); font-family: Roboto, &quot;Helvetica Neue&quot;, Arial, Helvetica, sans-serif; font-size: 15.4px;"><span style="box-sizing: inherit; font-weight: bolder;">Юнистрим - это одна из крупнейших в России систем денежных переводов.</span></p><p style="box-sizing: inherit; margin-bottom: 1em; line-height: 1.4285em; color: rgb(51, 51, 51); font-family: Roboto, &quot;Helvetica Neue&quot;, Arial, Helvetica, sans-serif; font-size: 15.4px;">\r\nДивизион денежных переводов в банке Юниаструм был создан Гагиком Закаряном и Георгием Писковым в 2001 году, и получил название Юнистрим.<br><br>Большое количество безопасных и удобно расположенных точек обслуживания, низкие тарифы и высокий уровень клиентского обслуживания быстро сделали Юнистрим популярным среди работающих в России мигрантов, посылающих деньги своим семьям.<br><br>Юнистрим стал самостоятельным банком в 2006 году.<br><br>Клиенты Юнистрим обслуживаются в 150 000 пунктов в 90 странах мира.<br><br>С 2016 года в Юнистриме также работают денежные переводы онлайн, доступные как на сайте банка, так и в мобильном приложении.<br><br>Свыше 117 000 клиентов пользуются для мобильных денежных переводов и других платежей картой Юнистрим VISA. 318 банков и розничных сетей предоставляют своим клиентам услуги денежных переводов с помощью системы Юнистрим.<br><br>В 2018 году, пользователи сделали свыше 5.5 миллионов денежных переводов на общую сумму 227 миллиардов рублей в Армению, Узбекистан, Молдову, Таджикистан, Кыргызстан, Филиппины и многие другие страны мира.<br><br>В последние три года более 10 миллионов клиентов перевели деньги своим семьям с помощью Юнистрим.<br><br>Юнистрим постоянно работает над улучшением своей тарифной политики, разрабатывает и применяет новые технологии, чтобы сделать денежные переводы более доступными, безопасными и удобными.</p>	<p style="text-align: center; box-sizing: inherit; margin-bottom: 1em; line-height: 1.4285em; color: rgb(51, 51, 51); font-family: Roboto, &quot;Helvetica Neue&quot;, Arial, Helvetica, sans-serif; font-size: 15.4px;"><img src="/media/django-summernote/2020-04-27/2a2da9b2-1a5f-4f0c-b7a3-6dd018fc92e2.png" style="width: 397.355px; height: 207.6px;"><br></p>\r\n\r\n<p style="box-sizing: inherit; margin-bottom: 1em; line-height: 1.4285em; color: rgb(51, 51, 51); font-family: Roboto, &quot;Helvetica Neue&quot;, Arial, Helvetica, sans-serif; font-size: 15.4px;">\r\nMoney transfers in Russia, to the CIS countries and abroad: Armenia, Kazakhstan, Moldova, Uzbekistan, Kyrgyzstan, Tajikistan, Belarus, Bulgaria, Great Britain, Vietnam, Germany, Greece, Georgia, Israel, Italy, Cyprus, Latvia, Lithuania, Mongolia, Serbia, Turkey, the Philippines, the Czech Republic, as well as many other countries in Europe and the world. More than 150,000 cash collection points around the world.\r\n</p>\r\n\r\n<a href="https://belgazprombank.by/personal_banking/perevesti_dengi/online-perevody-unistream/" target="_blank">https://belgazprombank.by/personal_banking/perevesti_dengi/online-perevody-unistream/</a>\r\n\r\n<p style="box-sizing: inherit; margin-bottom: 1em; line-height: 1.4285em; color: rgb(51, 51, 51); font-family: Roboto, &quot;Helvetica Neue&quot;, Arial, Helvetica, sans-serif; font-size: 15.4px;"><span style="box-sizing: inherit; font-weight: bolder;">Unistream is one of the largest money transfer systems in Russia.</span></p><p style="box-sizing: inherit; margin-bottom: 1em; line-height: 1.4285em; color: rgb(51, 51, 51); font-family: Roboto, &quot;Helvetica Neue&quot;, Arial, Helvetica, sans-serif; font-size: 15.4px;">\r\nThe money transfer division at Uniastrum Bank was created by Gagik Zakaryan and Georgy Piskov in 2001, and was named Unistream.<br><br>A large number of safe and conveniently located service points, low tariffs and a high level of customer service quickly made Unistream popular among migrants working in Russia who send money to their families.<br><br>Unistream became an independent bank in 2006.<br><br>Unistream customers are served in 150,000 locations in 90 countries.<br><br>Since 2016, Unistream also operates online money transfers, available both on the bank's website and in the mobile app.<br><br>Over 117,000 customers use the Unistream VISA card for mobile money transfers and other payments. 318 banks and retail chains provide their customers with money transfer services using the Unistream system.<br><br>In 2018, users made over 5.5 million money transfers totaling 227 billion rubles to Armenia, Uzbekistan, Moldova, Tajikistan, Kyrgyzstan, the Philippines and many other countries around the world.<br><br>In the last three years, more than 10 million customers have transferred money to their families using Unistream.<br><br>Unistream is constantly working to improve its tariff policy, developing and applying new technologies to make money transfers more accessible, secure and convenient.</p>
6	Soon about VTB Bank	vtb	Group of banks in the CIS	2020-04-23 16:30:50+03	2020-04-23 16:32:01.997293+03	2021-04-28 13:01:47.784286+03	published	1	Скоро о Банке ВТБ	Soon about VTB Bank	Группа банков по СНГ	Group of banks in the CIS
7	Soon about MTBank	mtbank	Halva\r\nMTB.tickets	2020-04-23 16:43:02+03	2020-04-23 16:43:57.472626+03	2021-04-28 13:03:28.00295+03	published	1	Скоро об МТБанке	Soon about MTBank	Халва\r\nMTB.tickets	Halva\r\nMTB.tickets
9	iPhone 11 Pro – for purchases on the "Onliner"! with Belgazprombank	iphone-11-pro-za-pokupki-na-onlajnere-s-belgazprombankom	<p style="text-align: center; "><img src="https://belgazprombank.by/upload/iblock/dc6/BGPB_Visa_600x464.jpg" style="width: 600px;"><br></p>\r\n<p>From April 25 to June 30, 2020, when you pay for your order in the Online catalog with a Visa card from Belgazprombank, you will be able to take part in the iPhone 11 Pro raffle every week.\r\nTo do this, it is necessary from April 25 to June 30, 2020:\r\n\r\n1. Register on the Internet resource onliner.by.\r\n\r\n2. Give your consent to participate in the advertising game.\r\n\r\n3. Link the Visa bank card of Belgazprombank.\r\n\r\n4. Make purchases in the section catalog.onliner.by.</p>	2020-04-26 16:16:34+03	2020-04-26 16:17:57.903722+03	2021-04-28 15:46:28.927378+03	published	1	iPhone 11 Pro – за покупки на «Онлайнере»! с Белгазпромбанком	iPhone 11 Pro – for purchases on the "Onliner"! with Belgazprombank	<p style="text-align: center; "><img src="https://belgazprombank.by/upload/iblock/dc6/BGPB_Visa_600x464.jpg" style="width: 600px;"><br></p>\r\n<p>С 25 апреля по 30 июня 2020 года при оплате вашего заказа в каталоге «Онлайнера» картой Visa Белгазпромбанка вы сможете каждую неделю принять участие в розыгрыше iPhone 11 Pro.\r\nДля этого необходимо с 25 апреля по 30 июня 2020 года:\r\n\r\n1. Зарегистрироваться на интернет-ресурсе onliner.by.\r\n\r\n2. Дать согласие на участие в рекламной игре.\r\n\r\n3. Привязать банковскую карту Visa Белгазпромбанка.\r\n\r\n4. Делать покупки в разделе catalog.onliner.by.</p>	<p style="text-align: center; "><img src="https://belgazprombank.by/upload/iblock/dc6/BGPB_Visa_600x464.jpg" style="width: 600px;"><br></p>\r\n<p>From April 25 to June 30, 2020, when you pay for your order in the Online catalog with a Visa card from Belgazprombank, you will be able to take part in the iPhone 11 Pro raffle every week.\r\nTo do this, it is necessary from April 25 to June 30, 2020:\r\n\r\n1. Register on the Internet resource onliner.by.\r\n\r\n2. Give your consent to participate in the advertising game.\r\n\r\n3. Link the Visa bank card of Belgazprombank.\r\n\r\n4. Make purchases in the section catalog.onliner.by.</p>
8	#BuyOnline with Mastercard! from Belgazprombank	pokupajtedoma-s-mastercard-ot-belgazprombanka	<p style="text-align: center; ">\r\n<img src="https://belgazprombank.by/upload/iblock/ce3/MC_PREMIUM_600x464_ALL_.jpg" style="width: 600px; float: none;" class=""><br></p>\r\n<p>Order dishes online with home delivery in the restaurants "Vasilki" and get a 15% discount when paying with a Mastercard (promo code "MASTERCARD") (promotion period: 16.04.2020-15.05.2020).\r\n\r\nOrder dishes online with home delivery at Pizza Tempo restaurants and get a 15% discount when paying with a Mastercard (promo code "MASTERCARD") (promotion period: 16.04.2020-15.05.2020).\r\n\r\nKeep a social distance when movement thanks to the "Eleven" electric scooter sharing and get a free ride start when paying with Mastercard (promotion period: 16.04.2020-30.04.2020).\r\n\r\nPay for trips with a taxi "Pyatniza" with a Mastercard and get a 7% discount (promotion period: until 31.12.2020).\r\n\r\nRefuel with Mastercard without going to the checkout: use the Drive and Pay contactless payment options at the Belorusneft gas station (promotion period: 16.04.2020-15.05.2020).\r\n\r\nConnect with Mastercard for free to the online project of the Yanka Kupala Theater, where leading actors read their favorite works (promotion period: 16.04.2020-29.04.2020).</p>	2020-04-26 15:53:51+03	2020-04-26 15:57:41.518709+03	2021-04-28 14:12:20.657771+03	published	1	#ПокупайтеДома с Mastercard! от Белгазпромбанка	#BuyOnline with Mastercard! from Belgazprombank	<p style="text-align: center; ">\r\n<img src="https://belgazprombank.by/upload/iblock/ce3/MC_PREMIUM_600x464_ALL_.jpg" style="width: 600px; float: none;" class=""><br></p>\r\n<p>Заказывайте блюда онлайн с доставкой на дом в ресторанах «Васильки» и получайте скидку 15% при оплате картой Mastercard (промокод «МАСТЕРКАРД») (период акции: 16.04.2020 – 15.05.2020).\r\n\r\nЗаказывайте блюда онлайн с доставкой на дом в ресторанах Пицца Темпо» и получайте скидку 15% при оплате картой Mastercard (промокод «МАСТЕРКАРД») (период акции: 16.04.2020 – 15.05.2020).\r\n\r\nСоблюдайте социальную дистанцию при передвижении благодаря шерингу электросамокатов Eleven и получайте бесплатный старт поездки при оплате картами Mastercard (период акции: 16.04.2020 – 30.04.2020).\r\n\r\nОплачивайте поездки с такси «Пятница» картой Mastercard и получите скидку 7% (период акции: по 31.12.2020).\r\n\r\nЗаправляйтесь с Mastercard, не подходя к кассе: используйте возможности бесконтактной оплаты Drive and Pay на АЗС «Белоруснефть» (период акции: 16.04.2020 – 15.05.2020).\r\n\r\nПодключитесь с Mastercard бесплатно к онлайн-проекту Театра Янки Купалы, в котором ведущие актёры читают свои любимые произведения (период акции: 16.04.2020 – 29.04.2020).</p>	<p style="text-align: center; ">\r\n<img src="https://belgazprombank.by/upload/iblock/ce3/MC_PREMIUM_600x464_ALL_.jpg" style="width: 600px; float: none;" class=""><br></p>\r\n<p>Order dishes online with home delivery in the restaurants "Vasilki" and get a 15% discount when paying with a Mastercard (promo code "MASTERCARD") (promotion period: 16.04.2020-15.05.2020).\r\n\r\nOrder dishes online with home delivery at Pizza Tempo restaurants and get a 15% discount when paying with a Mastercard (promo code "MASTERCARD") (promotion period: 16.04.2020-15.05.2020).\r\n\r\nKeep a social distance when movement thanks to the "Eleven" electric scooter sharing and get a free ride start when paying with Mastercard (promotion period: 16.04.2020-30.04.2020).\r\n\r\nPay for trips with a taxi "Pyatniza" with a Mastercard and get a 7% discount (promotion period: until 31.12.2020).\r\n\r\nRefuel with Mastercard without going to the checkout: use the Drive and Pay contactless payment options at the Belorusneft gas station (promotion period: 16.04.2020-15.05.2020).\r\n\r\nConnect with Mastercard for free to the online project of the Yanka Kupala Theater, where leading actors read their favorite works (promotion period: 16.04.2020-29.04.2020).</p>
18	"Your plans" with Priorbank	vashi-plany-s-priorbankom	<p>The bank offers to choose the optimal solution for the implementation of your plans.</p><p><span style="font-size: 1rem;"><a href="https://www.priorbank.by/your-plans" target="_blank">More detailed</a></span></p>	2020-04-27 14:05:59+03	2020-04-27 14:08:26.21067+03	2021-04-28 18:59:49.256639+03	published	1	"Ваши планы" с Приорбанком	"Your plans" with Priorbank	<p>Банк предлагает&nbsp;подобрать оптимальное решение&nbsp;<span style="font-size: 1rem;">для осуществления ваших планов.</span></p><p><span style="font-size: 1rem;"><a href="https://www.priorbank.by/your-plans" target="_blank">Подробнее</a></span></p>	<p>The bank offers to choose the optimal solution for the implementation of your plans.</p><p><span style="font-size: 1rem;"><a href="https://www.priorbank.by/your-plans" target="_blank">More detailed</a></span></p>
13	ApplePay, SamsungPay, GarminPay with Belgazprombank	applepay-samsungpay-garminpay	<p style="text-align: left;"><b style="font-size: 1rem;">&nbsp;SamsungPay</b></p><p style="text-align: center;"><img src="https://belgazprombank.by/local/images/samsung-pay/head-img-cashalot.jpg" style="width: 698px;"><b style="font-size: 1rem;"><br></b></p><p>In 2017, Samsung Electronics, Mastercard international payment system and Belgazprombank announced that Samsung Pay mobile payment service is available in Belarus. The service can be used by holders of Mastercard cards issued by Belgazprombank. Belarus has become the fifth country in Europe to launch the service in partnership with Mastercard, on its tokenization platform (MDES).<br></p><p>For holders of Visa cards issued by Belgazprombank, the Samsung Pay mobile payment service has been available since 2018.</p><p><a href="https://belgazprombank.by/samsung_pay/" target="_blank">More detailed</a></p><p><br></p><p><b>GarminPay</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/local/templates/garmin_pay/images/tmp/garmin-01_227x276.png" style="width: 227px;"><b><br></b></p><p></p><p>On March 22, 2019, a new contactless payment service – Garmin Pay-was launched in Belarus. Belgazprombank is the first bank in our country to provide this service. Garmin Pay is a contactless payment service in POS terminals using a Garmin watch.</p><p><a href="https://belgazprombank.by/garmin_pay/" target="_blank">More detailed</a></p><p><br></p><p><span style="font-weight: bolder;">ApplePay</span></p><p style="text-align: center; "><img src="https://belgazprombank.by/local/templates/apple_pay/assets/images/img-01.jpg" style="width: 522px;"><span style="font-weight: bolder;"><br></span></p><p>Starting from December 4, 2019, cardholders issued by Belgazprombank will be able to use Apple Pay – a lightweight and secure payment tool that completely changes the field of mobile payments, offering speed and convenience. Apple Pay now makes it easy for iPhone, Apple Watch, iPad, and Mac users to shop in stores, apps, and websites.</p><p><a href="https://belgazprombank.by/apple_pay/" target="_blank">More detailed</a></p>	2020-04-27 11:10:53+03	2020-04-27 11:30:04.975718+03	2021-04-28 17:54:07.610254+03	published	1	ApplePay, SamsungPay, GarminPay с Белгазпромбанком	ApplePay, SamsungPay, GarminPay with Belgazprombank	<p style="text-align: left;"><b style="font-size: 1rem;">&nbsp;SamsungPay</b></p><p style="text-align: center;"><img src="https://belgazprombank.by/local/images/samsung-pay/head-img-cashalot.jpg" style="width: 698px;"><b style="font-size: 1rem;"><br></b></p><p>В 2017 году компания Samsung Electronics, международная платежная система Mastercard и Белгазпромбанк объявили о том, что мобильный платежный сервис Samsung Pay доступен в Беларуси. Сервисом могут воспользоваться держатели карт Mastercard, выпущенных Белгазпромбанком. Беларусь стала пятой страной в Европе, где сервис запущен в партнерстве с Mastercard, на ее платформе токенизации (MDES).<br></p><p>Для держателей карточек Visa, выпущенных Белгазпромбанком мобильный платежный сервис Samsung Pay стал доступен с 2018 года.</p><p><a href="https://belgazprombank.by/samsung_pay/" target="_blank">Подробнее</a></p><p><br></p><p><b>GarminPay</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/local/templates/garmin_pay/images/tmp/garmin-01_227x276.png" style="width: 227px;"><b><br></b></p><p></p><p>22 марта 2019 года в Беларуси запущен новый сервис бесконтактных платежей – Garmin Pay. Белгазпромбанк является первым банком в нашей стране, кто предоставил данный сервис. Garmin Pay – это сервис бесконтактной оплаты в POS-терминалах с помощью часов Garmin.</p><p><a href="https://belgazprombank.by/garmin_pay/" target="_blank">Подробнее</a></p><p><br></p><p><span style="font-weight: bolder;">ApplePay</span></p><p style="text-align: center; "><img src="https://belgazprombank.by/local/templates/apple_pay/assets/images/img-01.jpg" style="width: 522px;"><span style="font-weight: bolder;"><br></span></p><p>С 4 декабря 2019 года держатели карт, выпущенных Белгазпромбанком, получили возможность пользоваться Apple Pay – лёгким и безопасным платёжным инструментом, который полностью меняет сферу мобильных платежей, предлагая скорость и удобство. Пользователи iPhone, Apple Watch, iPad и Mac теперь с лёгкостью могут совершать покупки как в магазинах, так и в приложениях и на вебсайтах благодаря Apple Pay.</p><p><a href="https://belgazprombank.by/apple_pay/" target="_blank">Подробнее</a></p>	<p style="text-align: left;"><b style="font-size: 1rem;">&nbsp;SamsungPay</b></p><p style="text-align: center;"><img src="https://belgazprombank.by/local/images/samsung-pay/head-img-cashalot.jpg" style="width: 698px;"><b style="font-size: 1rem;"><br></b></p><p>In 2017, Samsung Electronics, Mastercard international payment system and Belgazprombank announced that Samsung Pay mobile payment service is available in Belarus. The service can be used by holders of Mastercard cards issued by Belgazprombank. Belarus has become the fifth country in Europe to launch the service in partnership with Mastercard, on its tokenization platform (MDES).<br></p><p>For holders of Visa cards issued by Belgazprombank, the Samsung Pay mobile payment service has been available since 2018.</p><p><a href="https://belgazprombank.by/samsung_pay/" target="_blank">More detailed</a></p><p><br></p><p><b>GarminPay</b></p><p style="text-align: center; "><img src="https://belgazprombank.by/local/templates/garmin_pay/images/tmp/garmin-01_227x276.png" style="width: 227px;"><b><br></b></p><p></p><p>On March 22, 2019, a new contactless payment service – Garmin Pay-was launched in Belarus. Belgazprombank is the first bank in our country to provide this service. Garmin Pay is a contactless payment service in POS terminals using a Garmin watch.</p><p><a href="https://belgazprombank.by/garmin_pay/" target="_blank">More detailed</a></p><p><br></p><p><span style="font-weight: bolder;">ApplePay</span></p><p style="text-align: center; "><img src="https://belgazprombank.by/local/templates/apple_pay/assets/images/img-01.jpg" style="width: 522px;"><span style="font-weight: bolder;"><br></span></p><p>Starting from December 4, 2019, cardholders issued by Belgazprombank will be able to use Apple Pay – a lightweight and secure payment tool that completely changes the field of mobile payments, offering speed and convenience. Apple Pay now makes it easy for iPhone, Apple Watch, iPad, and Mac users to shop in stores, apps, and websites.</p><p><a href="https://belgazprombank.by/apple_pay/" target="_blank">More detailed</a></p>
14	Rent of safes from BPS-Sberbank	arenda-sejfov-ot-bps-sberbanka	<p>JSC "BPS-Sberbank" provides an individual bank safe for storing valuables and documents.</p><p><span style="font-size: 1rem;">Safe-deposit boxes are located in a specially equipped room-Depository and have safe-deposit boxes of different sizes, which allows the client to use the safe-deposit box in accordance with the dimensions of the valuables in need of storage.</span><br></p><p><span style="font-size: 1rem;">The main stages of the provision of Depository services:</span><br></p><p><span style="font-size: 1rem;">The Client applies to the Bank with an application for the provision of an individual bank safe for use.</span><br></p><p>The Client pays in advance for the entire period of use of the safe, as well as the amount of the deposit to the bank's cash desk, or transfers it by bank transfer to the appropriate bank account (payment term — 3 banking days).</p><p>The Bank enters into an Agreement with the client on the provision of a bank safe for use.</p><p>The Bank provides the client with a safe in good condition and provides the client with unhindered access to the safe in accordance with the working hours of the Depository.</p><p>The Bank provides the possibility of confidential work with the object of storage for no more than 10 minutes.</p><p>The Client regularly signs in the list of registration of visits to the Depository.</p><p>After the expiration of the Agreement on the provision of a bank safe for use, the Client hands over the key to the safe deposit box to the Bank and provides the safe deposit box to the employee of the Depository. If the Bank has no claims against the client, the Bank returns the amount of the deposit to the client.</p><p>Advantages of using the services of the Depository of JSC " BPS-Sberbank»:</p><ul><li><span style="font-size: 1rem;">ability to service persons by proxy;</span><br></li><li>acceptable rates for the provision of bank safes for use;</li><li>free access to the Depository regardless of the number of visits per day.</li></ul>	2020-04-27 11:45:05+03	2020-04-27 11:45:51.170215+03	2021-04-28 18:19:00.321263+03	published	1	Аренда сейфов от БПС-Сбербанка	Rent of safes from BPS-Sberbank	<p>ОАО «БПС-Сбербанк» предоставляет индивидуальный банковский сейф для хранения ценностей и документов.</p><p><span style="font-size: 1rem;">Сейфы-хранилища находятся в специально оборудованном помещении — Депозитарии и имеют ячейки-сейфы разных размеров, что позволяет клиенту воспользоваться ячейкой-сейфом в соответствии с габаритами нуждающихся в хранении ценностей.</span><br></p><p><span style="font-size: 1rem;">Основные этапы предоставления услуг Депозитария:</span><br></p><p><span style="font-size: 1rem;">Клиент обращается в Банк с заявкой на предоставление ему в пользование индивидуального банковского сейфа.</span><br></p><p>Клиент вносит плату авансом за весь период пользования сейфом, а также сумму залога в кассу банка, либо перечисляет по безналичному расчету на соответствующий счет банка (срок оплаты — 3 банковских дня).</p><p>Банк заключает с клиентом Договор о предоставлении банковского сейфа в пользование.</p><p>Банк предоставляет клиенту сейф в исправном состоянии и обеспечивает клиенту беспрепятственный доступ к сейфу в соответствии с режимом работы Депозитария.</p><p>Банк предоставляет возможность конфиденциальной работы с предметом хранения не более 10 минут.</p><p>Клиент регулярно расписывается в листе регистрации посещений Депозитария.</p><p>По истечении срока действия Договора о предоставлении банковского сейфа в пользование, клиент сдает Банку ключ от сейфа и предоставляет сейф работнику Депозитария. При отсутствии у Банка претензий к клиенту, Банк возвращает клиенту сумму залога.</p><p>Преимущества пользования услугами Депозитария ОАО «БПС-Сбербанк»:</p><ul><li><span style="font-size: 1rem;">возможность обслуживания лиц по доверенности;</span><br></li><li>приемлемые тарифы на предоставление банковских сейфов в пользование;</li><li>бесплатное посещение Депозитария независимо от количества посещений в день.</li></ul>	<p>JSC "BPS-Sberbank" provides an individual bank safe for storing valuables and documents.</p><p><span style="font-size: 1rem;">Safe-deposit boxes are located in a specially equipped room-Depository and have safe-deposit boxes of different sizes, which allows the client to use the safe-deposit box in accordance with the dimensions of the valuables in need of storage.</span><br></p><p><span style="font-size: 1rem;">The main stages of the provision of Depository services:</span><br></p><p><span style="font-size: 1rem;">The Client applies to the Bank with an application for the provision of an individual bank safe for use.</span><br></p><p>The Client pays in advance for the entire period of use of the safe, as well as the amount of the deposit to the bank's cash desk, or transfers it by bank transfer to the appropriate bank account (payment term — 3 banking days).</p><p>The Bank enters into an Agreement with the client on the provision of a bank safe for use.</p><p>The Bank provides the client with a safe in good condition and provides the client with unhindered access to the safe in accordance with the working hours of the Depository.</p><p>The Bank provides the possibility of confidential work with the object of storage for no more than 10 minutes.</p><p>The Client regularly signs in the list of registration of visits to the Depository.</p><p>After the expiration of the Agreement on the provision of a bank safe for use, the Client hands over the key to the safe deposit box to the Bank and provides the safe deposit box to the employee of the Depository. If the Bank has no claims against the client, the Bank returns the amount of the deposit to the client.</p><p>Advantages of using the services of the Depository of JSC " BPS-Sberbank»:</p><ul><li><span style="font-size: 1rem;">ability to service persons by proxy;</span><br></li><li>acceptable rates for the provision of bank safes for use;</li><li>free access to the Depository regardless of the number of visits per day.</li></ul>
15	Depersonalized metal accounts in BPS-Sberbank	obezlichennye-metallicheskie-scheta-v-bps-sberbanke	<p>Depersonalized metal accounts have the following advantages:</p><ul><li>The cost of depersonalized precious metal does not include the costs associated with the production of ingots, their storage and transportation;</li><li>The ability to diversify the investment portfolio with investments in precious metals, which reduces the risk of losses associated with negative changes in the financial markets;</li><li>The possibility of saving and multiplying funds due to the growth of the value of precious metals;</li><li>High liquidity — the sale of metal from the account in an impersonal form is carried out by the Bank on the day of the client's request.</li></ul><p><a href="https://www.bps-sberbank.by/page/invest-and-earn-omc" target="_blank">More detailed</a></p>	2020-04-27 11:49:45+03	2020-04-27 11:51:24.918108+03	2021-04-28 18:32:04.118406+03	published	1	Обезличенные металлические счета в БПС-Сбербанке	Depersonalized metal accounts in BPS-Sberbank	<p>Обезличенные металлические счета обладают следующими преимуществами:</p><ul><li>Стоимость обезличенного драгоценного металла не включает в себя издержки, связанные с изготовлением слитков, их хранением и транспортировкой;</li><li>Возможность диверсификации инвестиционного портфеля вложениями в драгоценные металлы, что снижает риски потерь, связанные с негативными изменениями на финансовых рынках;</li><li>Возможность сохранения и преумножения денежных средств за счет роста стоимости драгоценных металлов;</li><li>Высокая ликвидность — продажа металла со счета в обезличенном виде осуществляется Банком в день обращения клиента.</li></ul><p><a href="https://www.bps-sberbank.by/page/invest-and-earn-omc" target="_blank">Подробнее</a></p>	<p>Depersonalized metal accounts have the following advantages:</p><ul><li>The cost of depersonalized precious metal does not include the costs associated with the production of ingots, their storage and transportation;</li><li>The ability to diversify the investment portfolio with investments in precious metals, which reduces the risk of losses associated with negative changes in the financial markets;</li><li>The possibility of saving and multiplying funds due to the growth of the value of precious metals;</li><li>High liquidity — the sale of metal from the account in an impersonal form is carried out by the Bank on the day of the client's request.</li></ul><p><a href="https://www.bps-sberbank.by/page/invest-and-earn-omc" target="_blank">More detailed</a></p>
16	Collection of cash foreign currency in Belarusbank	inkasso-nalichnoj-inostrannoj-valyuty	<p><span style="color: rgb(37, 37, 37); font-family: &quot;Fira Sans&quot;, Roboto, Arial, Helvetica, sans-serif; font-size: 19px; text-align: justify;">Cash collection of foreign currency - a method for sending to the collection of cash foreign currency that raises doubts about its solvency, for sending to the study on solvency. The operation of cash collection of foreign currency is carried out with the collection of&nbsp;</span><a href="https://belarusbank.by/ru/deyatelnost/10373/15058" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); transition: all 0.2s ease 0s; color: rgb(20, 126, 75); cursor: pointer; border-bottom: 1px solid rgba(69, 167, 62, 0.6); outline: none; font-family: &quot;Fira Sans&quot;, Roboto, Arial, Helvetica, sans-serif; font-size: 19px; text-align: justify; background-color: rgb(255, 255, 255);">reward.</a></p><p><a href="https://belarusbank.by/ru/fizicheskim_licam/33359/33906" target="_blank">More detailed</a><br></p>	2020-04-27 13:50:27+03	2020-04-27 13:52:14.987567+03	2021-04-28 18:36:58.401864+03	published	1	Инкассо наличной иностранной валюты в Беларусбанке	Collection of cash foreign currency in Belarusbank	<p><span style="color: rgb(37, 37, 37); font-family: &quot;Fira Sans&quot;, Roboto, Arial, Helvetica, sans-serif; font-size: 19px; text-align: justify;">Инкассо наличной иностранной валюты - прием для направления на инкассо наличной иностранной валюты, вызывающей сомнение в ее платежности, для направления на исследование по платежности. Операция инкассо наличной иностранной валюты выполняется с взиманием&nbsp;</span><a href="https://belarusbank.by/ru/deyatelnost/10373/15058" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); transition: all 0.2s ease 0s; color: rgb(20, 126, 75); cursor: pointer; border-bottom: 1px solid rgba(69, 167, 62, 0.6); outline: none; font-family: &quot;Fira Sans&quot;, Roboto, Arial, Helvetica, sans-serif; font-size: 19px; text-align: justify; background-color: rgb(255, 255, 255);">вознаграждения.</a></p><p><a href="https://belarusbank.by/ru/fizicheskim_licam/33359/33906" target="_blank">Подробнее</a><br></p>	<p><span style="color: rgb(37, 37, 37); font-family: &quot;Fira Sans&quot;, Roboto, Arial, Helvetica, sans-serif; font-size: 19px; text-align: justify;">Cash collection of foreign currency - a method for sending to the collection of cash foreign currency that raises doubts about its solvency, for sending to the study on solvency. The operation of cash collection of foreign currency is carried out with the collection of&nbsp;</span><a href="https://belarusbank.by/ru/deyatelnost/10373/15058" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); transition: all 0.2s ease 0s; color: rgb(20, 126, 75); cursor: pointer; border-bottom: 1px solid rgba(69, 167, 62, 0.6); outline: none; font-family: &quot;Fira Sans&quot;, Roboto, Arial, Helvetica, sans-serif; font-size: 19px; text-align: justify; background-color: rgb(255, 255, 255);">reward.</a></p><p><a href="https://belarusbank.by/ru/fizicheskim_licam/33359/33906" target="_blank">More detailed</a><br></p>
17	Belarusbank - Tax Free	belarusbank-tax-free	<p style="text-align: center; "><img src="/media/django-summernote/2020-04-27/e45d84b7-5f03-4068-9681-68e9d1ea72cd.png" style="width: 25%;"><span style="text-align: justify; font-family: Arial, Helvetica; font-size: 13pt;"><br></span></p><p><span style="text-align: justify; font-family: Arial, Helvetica; font-size: 13pt;">The Tax Free system in Belarus has been available for more than 3 years and is actively enjoying interest among foreign citizens. More than 800 stores are connected to the Tax Free system, where you can buy various goods-starting from jewelry, clothing, shoes and ending with household appliances.<br><br>Tax Free is a VAT refund system for foreign citizens. Beltamozhservis is the only operator of the Tax Free system in our country.<br><br>In Belarus, the Tax Free system applies to all goods taxed at a rate of 20%. And provides for a refund of 15% of the purchase amount without VAT (or 12.5% of the purchase amount specified in the cash receipt).<br><br>The service is available for purchases of goods within one day in one store operating under the Tax Free system, for the amount of more than 80 Belarusian rubles (approximately 35 euros).&nbsp;</span></p><p><span style="text-align: justify; font-family: Arial, Helvetica; font-size: 13pt;"><a href="https://belarusbank.by/ru/fizicheskim_licam/33359/34919" target="_blank">More detailed</a></span><br></p>	2020-04-27 13:58:55+03	2020-04-27 14:03:33.905588+03	2021-04-28 18:55:39.102769+03	published	1	Беларусбанк - Tax Free	Belarusbank - Tax Free	<p style="text-align: center; "><img src="/media/django-summernote/2020-04-27/e45d84b7-5f03-4068-9681-68e9d1ea72cd.png" style="width: 25%;"><span style="text-align: justify; font-family: Arial, Helvetica; font-size: 13pt;"><br></span></p><p><span style="text-align: justify; font-family: Arial, Helvetica; font-size: 13pt;">Система Tax Free в Беларуси доступна более 3 лет и активно пользуется интересом среди иностранных граждан. К системе Tax Free подключены более 800 магазинов, где можно приобрести различные товары -&nbsp;начиная от ювелирных изделий, одежды, обуви и заканчивая бытовой техникой.<br><br>Tax Free&nbsp;– это система возврата НДС иностранным&nbsp;гражданам. «Белтаможсервис» является единственным оператором системы Tax Free в нашей стране.<br><br>В Беларуси система&nbsp;Tax Free распространяется на все товары, облагаемые поставке 20%. И предусматривает возврат 15% от суммы покупки без НДС (или 12,5% от суммы покупки указанной в кассовом чеке).<br><br>Услуга доступна при приобретении товаров в течение одного дня в одном&nbsp;магазине, работающем по системе Tax Free, на сумму более 80 белорусских рублей (примерно 35 евро).&nbsp;</span></p><p><span style="text-align: justify; font-family: Arial, Helvetica; font-size: 13pt;"><a href="https://belarusbank.by/ru/fizicheskim_licam/33359/34919" target="_blank">Подробнее</a></span><br></p>	<p style="text-align: center; "><img src="/media/django-summernote/2020-04-27/e45d84b7-5f03-4068-9681-68e9d1ea72cd.png" style="width: 25%;"><span style="text-align: justify; font-family: Arial, Helvetica; font-size: 13pt;"><br></span></p><p><span style="text-align: justify; font-family: Arial, Helvetica; font-size: 13pt;">The Tax Free system in Belarus has been available for more than 3 years and is actively enjoying interest among foreign citizens. More than 800 stores are connected to the Tax Free system, where you can buy various goods-starting from jewelry, clothing, shoes and ending with household appliances.<br><br>Tax Free is a VAT refund system for foreign citizens. Beltamozhservis is the only operator of the Tax Free system in our country.<br><br>In Belarus, the Tax Free system applies to all goods taxed at a rate of 20%. And provides for a refund of 15% of the purchase amount without VAT (or 12.5% of the purchase amount specified in the cash receipt).<br><br>The service is available for purchases of goods within one day in one store operating under the Tax Free system, for the amount of more than 80 Belarusian rubles (approximately 35 euros).&nbsp;</span></p><p><span style="text-align: justify; font-family: Arial, Helvetica; font-size: 13pt;"><a href="https://belarusbank.by/ru/fizicheskim_licam/33359/34919" target="_blank">More detailed</a></span><br></p>
\.


--
-- Data for Name: blog_profile; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.blog_profile (id, date_of_birth, photo, user_id) FROM stdin;
2	2021-04-04	users/2021/04/04/x_ea5305b5.jpg	7
1	1989-04-14	users/2021/04/03/uRHi5vpgBYc.jpg	1
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
7	2021-03-14 19:27:05.483351+03	20	"Халва" от МТБанка	2	[{"changed": {"fields": ["Body"]}}]	1	1
8	2021-03-14 19:36:41.281053+03	20	"Халва" от МТБанка	2	[{"changed": {"fields": ["Body"]}}]	1	1
9	2021-03-14 19:37:34.958834+03	20	"Халва" от МТБанка	2	[{"changed": {"fields": ["Body"]}}]	1	1
10	2021-03-14 19:38:19.431364+03	20	"Халва" от МТБанка	2	[{"changed": {"fields": ["Body"]}}]	1	1
11	2021-03-14 19:41:43.767969+03	20	"Халва" от МТБанка	2	[{"changed": {"fields": ["Body"]}}]	1	1
12	2021-03-14 19:53:34.917055+03	20	"Халва" от МТБанка	2	[{"changed": {"fields": ["Body"]}}]	1	1
13	2021-03-14 19:55:41.824075+03	20	"Халва" от МТБанка	2	[{"changed": {"fields": ["Body"]}}]	1	1
14	2021-03-14 19:56:59.745515+03	20	"Халва" от МТБанка	2	[{"changed": {"fields": ["Body"]}}]	1	1
15	2021-03-14 19:59:46.754178+03	20	"Халва" от МТБанка	2	[{"changed": {"fields": ["Body"]}}]	1	1
16	2021-03-15 17:05:14.823034+03	1	root	2	[{"changed": {"fields": ["password"]}}]	6	1
17	2021-03-30 13:40:18.51415+03	3	alexs	3		6	1
18	2021-03-30 13:42:30.333645+03	4	alexs	3		6	1
19	2021-03-30 13:45:24.716204+03	5	alexs	3		6	1
20	2021-03-30 22:37:45.503178+03	6	alexs	3		6	1
21	2021-04-03 13:42:45.43726+03	1	Profile for user root	1	[{"added": {}}]	11	1
22	2021-04-04 22:12:38.434531+03	2	Profile for user alexs	1	[{"added": {}}]	11	1
23	2021-04-04 22:57:02.68692+03	2	Comment by Алексей on Акции в Приорбанке	2	[{"changed": {"fields": ["Body"]}}]	2	1
24	2021-04-05 19:26:36.508001+03	22	test2	1	[{"added": {}}]	1	1
25	2021-04-20 12:42:23.602668+03	7	Comment by alex on Акции в Приорбанке	2	[{"changed": {"fields": ["Active"]}}]	2	1
26	2021-04-20 12:42:32.891925+03	8	Comment by Роман on Акции в Приорбанке	2	[{"changed": {"fields": ["Active"]}}]	2	1
27	2021-04-20 12:42:38.208411+03	9	Comment by alex on Акции в Приорбанке	2	[{"changed": {"fields": ["Active"]}}]	2	1
28	2021-04-20 12:42:42.525222+03	10	Comment by alex on Акции в Приорбанке	2	[{"changed": {"fields": ["Active"]}}]	2	1
29	2021-04-20 12:43:08.083533+03	7	Comment by alex on Акции в Приорбанке	2	[{"changed": {"fields": ["Active"]}}]	2	1
30	2021-04-23 00:35:48.136546+03	22	test2	2	[{"changed": {"fields": ["Status"]}}]	1	1
31	2021-04-23 00:59:57.63434+03	10	Online-переводы Unistream с банковских карточек Visa и Mastercard с Белгазпромбанком	2	[{"changed": {"fields": ["Post_body"]}}]	1	1
32	2021-04-27 19:12:49.01808+03	22	test2	3		1	1
33	2021-04-27 19:13:17.418214+03	23	test2	1	[{"added": {}}]	1	1
34	2021-04-27 19:13:47.465938+03	23	test2	2	[{"changed": {"fields": ["Status"]}}]	1	1
35	2021-04-28 00:43:23.658046+03	23	test2	3		1	1
36	2021-04-28 00:44:23.501403+03	24	test2	1	[{"added": {}}]	1	1
37	2021-04-28 12:50:34.99974+03	1	Soon about Belgazprombank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
38	2021-04-28 12:54:38.02995+03	2	Soon about BPS-Sberbank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
39	2021-04-28 12:56:25.918866+03	3	Soon about Belarusbank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
40	2021-04-28 12:57:39.73593+03	4	Soon about Priorbank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
41	2021-04-28 13:00:26.879362+03	5	Soon about Alfa-Bank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
42	2021-04-28 13:01:47.788243+03	6	Soon about VTB Bank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
43	2021-04-28 13:03:28.007399+03	7	Soon about MTBank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
44	2021-04-28 13:29:17.087103+03	8	#BuyOnline with Mastercard! from Belgazprombank	2	[{"changed": {"fields": ["Title [en]", "Post_body [ru]", "Post_body [en]"]}}]	1	1
45	2021-04-28 14:12:20.667804+03	8	#BuyOnline with Mastercard! from Belgazprombank	2	[{"changed": {"fields": ["Post_body [en]"]}}]	1	1
46	2021-04-28 15:46:28.932378+03	9	iPhone 11 Pro – for purchases on the "Onliner"! with Belgazprombank	2	[{"changed": {"fields": ["Title [en]", "Post_body [ru]", "Post_body [en]"]}}]	1	1
47	2021-04-28 16:19:58.369077+03	10	"Unistream" online transfers from Visa and Mastercard bank cards with Belgazprombank	2	[{"changed": {"fields": ["Title [en]", "Post_body [ru]", "Post_body [en]"]}}]	1	1
48	2021-04-28 16:21:23.140138+03	10	"Unistream" online transfers from Visa and Mastercard bank cards with Belgazprombank	2	[{"changed": {"fields": ["Post_body [ru]", "Post_body [en]"]}}]	1	1
49	2021-04-28 16:22:29.077132+03	10	"Unistream" online transfers from Visa and Mastercard bank cards with Belgazprombank	2	[{"changed": {"fields": ["Post_body [ru]", "Post_body [en]"]}}]	1	1
50	2021-04-28 16:24:44.367885+03	10	"Unistream" online transfers from Visa and Mastercard bank cards with Belgazprombank	2	[{"changed": {"fields": ["Post_body [en]"]}}]	1	1
51	2021-04-28 16:30:46.092896+03	10	"Unistream" online transfers from Visa and Mastercard bank cards with Belgazprombank	2	[{"changed": {"fields": ["Post_body [ru]"]}}]	1	1
52	2021-04-28 16:49:13.692248+03	10	"Unistream" online transfers from Visa and Mastercard bank cards with Belgazprombank	2	[{"changed": {"fields": ["Post_body [ru]", "Post_body [en]"]}}]	1	1
53	2021-04-28 16:50:57.830067+03	10	"Unistream" online transfers from Visa and Mastercard bank cards with Belgazprombank	2	[{"changed": {"fields": ["Post_body [ru]", "Post_body [en]"]}}]	1	1
54	2021-04-28 17:40:42.073949+03	12	Money transfers with Belgazprombank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
55	2021-04-28 17:54:07.613215+03	13	ApplePay, SamsungPay, GarminPay with Belgazprombank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
56	2021-04-28 18:19:00.323915+03	14	Rent of safes from BPS-Sberbank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
57	2021-04-28 18:32:04.121395+03	15	Depersonalized metal accounts in BPS-Sberbank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
58	2021-04-28 18:36:58.405123+03	16	Collection of cash foreign currency in Belarusbank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
59	2021-04-28 18:44:41.131179+03	17	Belarusbank - Tax Free	2	[{"changed": {"fields": ["Title [en]", "Post_body [ru]"]}}]	1	1
60	2021-04-28 18:46:31.801824+03	17	Belarusbank - Tax Free	2	[{"changed": {"fields": ["Post_body [ru]"]}}]	1	1
61	2021-04-28 18:54:36.53625+03	17	Belarusbank - Tax Free	2	[{"changed": {"fields": ["Post_body [en]"]}}]	1	1
62	2021-04-28 18:55:39.110577+03	17	Belarusbank - Tax Free	2	[{"changed": {"fields": ["Post_body [en]"]}}]	1	1
63	2021-04-28 18:59:28.989176+03	18	"Your plans" with Priorbank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
64	2021-04-28 18:59:49.258633+03	18	"Your plans" with Priorbank	2	[{"changed": {"fields": ["Post_body [en]"]}}]	1	1
65	2021-04-28 19:06:15.288463+03	20	"Halva" from MTBank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
66	2021-04-28 19:11:54.595632+03	19	Promotions in Priorbank	2	[{"changed": {"fields": ["Title [en]", "Post_body [en]"]}}]	1	1
67	2021-04-28 19:12:26.478706+03	24	test2	2	[{"changed": {"fields": ["Status"]}}]	1	1
68	2021-04-30 17:51:06.714271+03	21	test	2	[{"changed": {"fields": ["Title [ru]", "Title [en]", "Post_body [ru]", "Post_body [en]"]}}]	1	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	blog	post
2	blog	comment
3	admin	logentry
4	auth	permission
5	auth	group
6	auth	user
7	contenttypes	contenttype
8	sessions	session
9	sites	site
10	django_summernote	attachment
11	blog	profile
12	blog	posttranslation
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-03-14 15:01:43.902+03
2	auth	0001_initial	2021-03-14 15:01:43.951899+03
3	admin	0001_initial	2021-03-14 15:01:44.015697+03
4	admin	0002_logentry_remove_auto_add	2021-03-14 15:01:44.03265+03
5	admin	0003_logentry_add_action_flag_choices	2021-03-14 15:01:44.039663+03
6	contenttypes	0002_remove_content_type_name	2021-03-14 15:01:44.054592+03
7	auth	0002_alter_permission_name_max_length	2021-03-14 15:01:44.063593+03
8	auth	0003_alter_user_email_max_length	2021-03-14 15:01:44.071546+03
9	auth	0004_alter_user_username_opts	2021-03-14 15:01:44.079529+03
10	auth	0005_alter_user_last_login_null	2021-03-14 15:01:44.089498+03
11	auth	0006_require_contenttypes_0002	2021-03-14 15:01:44.091496+03
12	auth	0007_alter_validators_add_error_messages	2021-03-14 15:01:44.100494+03
13	auth	0008_alter_user_username_max_length	2021-03-14 15:01:44.118422+03
14	auth	0009_alter_user_last_name_max_length	2021-03-14 15:01:44.127397+03
15	auth	0010_alter_group_name_max_length	2021-03-14 15:01:44.135376+03
16	auth	0011_update_proxy_permissions	2021-03-14 15:01:44.143356+03
17	auth	0012_alter_user_first_name_max_length	2021-03-14 15:01:44.151334+03
18	blog	0001_initial	2021-03-14 15:01:44.167291+03
19	blog	0002_comment	2021-03-14 15:01:44.196242+03
20	django_summernote	0001_initial	2021-03-14 15:01:44.213169+03
21	django_summernote	0002_update-help_text	2021-03-14 15:01:44.216161+03
22	sessions	0001_initial	2021-03-14 15:01:44.225139+03
23	sites	0001_initial	2021-03-14 15:01:44.239098+03
24	sites	0002_alter_domain_unique	2021-03-14 15:01:44.248075+03
25	blog	0003_profile	2021-04-01 22:24:44.586837+03
26	blog	0004_add_translation_model	2021-04-26 22:20:12.007341+03
27	blog	0005_auto_20210427_1839	2021-04-27 19:07:48.369604+03
28	blog	0004_translation	2021-04-28 12:22:17.168498+03
29	blog	0005_after_Snyk_check	2021-05-21 13:18:31.40249+03
30	django_summernote	0003_auto_20210521_1249	2021-05-21 13:18:31.416521+03
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
whjj7kcm45nxj7mvr189mwnkv5utfffr	OWQ5NzlhODNlNjQxNDJkY2Q4YmJkYTY3YTU0ZDcwOWJiOGZjMDdlODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNDU1MWFkYjg1OTdjMTg1YzFjN2M1YmZiMDQ4NzhmYjI3ZjI3MThiIn0=	2020-05-06 13:13:55.391506+03
gnjq4a139i9c0upjguh04cblps3ccft8	OWQ5NzlhODNlNjQxNDJkY2Q4YmJkYTY3YTU0ZDcwOWJiOGZjMDdlODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNDU1MWFkYjg1OTdjMTg1YzFjN2M1YmZiMDQ4NzhmYjI3ZjI3MThiIn0=	2020-05-13 00:00:42.283093+03
rhiokc4uz6rw69s0zspgq0ecfz2uv5zm	ODhkMWMxZjU2ZWUwZTAwNjZmZDU4NGM3NGNkN2Q1ZGYwYjU2ZTgwZjp7fQ==	2020-05-13 20:37:56.829319+03
3l865kq269nejumyc1hqvft9nk29jjkc	ODhkMWMxZjU2ZWUwZTAwNjZmZDU4NGM3NGNkN2Q1ZGYwYjU2ZTgwZjp7fQ==	2020-05-13 20:45:34.20344+03
3zxfm6lcoies7kgfueulizoy5rtue4v5	ODhkMWMxZjU2ZWUwZTAwNjZmZDU4NGM3NGNkN2Q1ZGYwYjU2ZTgwZjp7fQ==	2020-05-13 20:56:30.928018+03
lqces35dlo4nvznkbkoimfmxuj57zs7s	ODhkMWMxZjU2ZWUwZTAwNjZmZDU4NGM3NGNkN2Q1ZGYwYjU2ZTgwZjp7fQ==	2020-05-13 21:32:29.454039+03
1kkui5nxl3sxp7i5ndj1q02i25rfp60s	OWQ5NzlhODNlNjQxNDJkY2Q4YmJkYTY3YTU0ZDcwOWJiOGZjMDdlODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNDU1MWFkYjg1OTdjMTg1YzFjN2M1YmZiMDQ4NzhmYjI3ZjI3MThiIn0=	2020-05-14 03:15:07.084167+03
ezincvki427r5by0i6et36v5s1jc6o5m	YjYxYTE4YjYzMTQwYmNkOTgzZWEwODg4MzY3ODU0Yjg0MDBjNTJjYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmMWRiZGY3ZDhhOTA3YzY0MTBhNDhkYjA2MzliNTQ0MTU1YzVmZGE2In0=	2020-05-14 03:33:21.854496+03
kn92sa6mppjmda6mfcty8jlb3vos7ylz	NTI4NzAzZTk2Yzc3NzQ3OTYyZjQyYzg4NTY0MTYzNjg1YWY1YWQ5Zjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjZmEwYzZlNDZhYTc5YWVmM2I3OTkyN2Y1ZWZkNDk3OWFkZDZkMjBhIn0=	2020-05-14 03:34:35.164013+03
4eoyliy9kh1w2car4rbpzs4glyl66vjo	ZTg2MTY4NDE4YjQxYTEzYjIwNjA1MjYxZWJlMGEzNmEzYmJiYTBkYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NzY0M2I3NDI4ZjdjZWMyZmZlNmVmNjg3Mzc0Njk1YWJmNDQwYjBiIn0=	2020-05-14 03:36:15.684299+03
aqx5qtea9inj6ujy3onvjavuywh6qtvg	M2ZiNzZjNjI4NmUxODkxZjYyZDQzNDhkZjZiMmViNTkwYTdhNTBjNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmMTExMjQxOTNkY2U3ZDZjZDI4NTU5YzNiYTRhZGYzZTgzZjZmODJhIn0=	2020-05-14 03:39:31.258019+03
xbj61aserfr96smbyfdvoy7dr8rm1v19	ODk3NzE3MDNkY2EwNDVlZjhmNWFkMDhiNzE4ODIyM2IzMDhiN2I0ZTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMTJiNDljMGU4MzU2YWRmN2QzMDJiNmE0ZmI4N2VkMzJlYTFlNDg2In0=	2020-05-16 12:46:29.6209+03
jzrgzmd0b0tjcichk9fadp6hqsz8ah1i	ODk3NzE3MDNkY2EwNDVlZjhmNWFkMDhiNzE4ODIyM2IzMDhiN2I0ZTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMTJiNDljMGU4MzU2YWRmN2QzMDJiNmE0ZmI4N2VkMzJlYTFlNDg2In0=	2020-05-27 23:45:49.817224+03
grkj86ofeusrjwnjytzw07kzms4skc7o	.eJxVjMsOwiAQRf-FtSEzCAVcuvcbyAwPqRqalHZl_HdD0oVu7znnvkWgfath73kNcxIXgeL0uzHFZ24DpAe1-yLj0rZ1ZjkUedAub0vKr-vh_h1U6nXUWkFSzhKhI33mXFLxxk4IiATOgonJA0eenPeFM2jjEUyOpApa68XnC93MN54:1lJJWd:h1rVJURHk8oR-1HjZvikrsz_FUyeCYSOjg3rtvxoXLw	2021-03-22 20:18:35.690636+03
dfq0pusvxv5qy803jpawg0xpwy5oz11f	.eJxVjEEOwiAQRe_C2hBgaKEu3fcMZGCmUjWQlHZlvLtt0oVu33v_v0XAbc1ha7yEmcRVaHH5ZRHTk8sh6IHlXmWqZV3mKI9EnrbJsRK_bmf7d5Cx5X2tmDx3QNEhGk7GW-OjS6CZe5yIdhjV5CCB1TrBoJQBo4g70-OgLIrPFwb4ODw:1lLntg:m3XELorzAavLEmo6x1c0rQh6hfNLQUpnjOyxXIqHGeg	2021-03-29 17:08:40.446684+03
wu20ppgdulaav20e2rskjgj559nem638	.eJxVjEEOwiAQRe_C2hBgaKEu3fcMZGCmUjWQlHZlvLtt0oVu33v_v0XAbc1ha7yEmcRVaHH5ZRHTk8sh6IHlXmWqZV3mKI9EnrbJsRK_bmf7d5Cx5X2tmDx3QNEhGk7GW-OjS6CZe5yIdhjV5CCB1TrBoJQBo4g70-OgLIrPFwb4ODw:1lPNqO:prS7V4jrKK2FLmg2mqzayuyFdv4-5rt0Q1mQ75hw9ws	2021-04-08 14:08:04.637177+03
b7g22urzarhx6tkyxtjj6w824xvykeqf	.eJxVjEEOwiAQRe_C2hBgaKEu3fcMZGCmUjWQlHZlvLtt0oVu33v_v0XAbc1ha7yEmcRVaHH5ZRHTk8sh6IHlXmWqZV3mKI9EnrbJsRK_bmf7d5Cx5X2tmDx3QNEhGk7GW-OjS6CZe5yIdhjV5CCB1TrBoJQBo4g70-OgLIrPFwb4ODw:1lPRKd:r6yNrJfTewcAO6pk-w_woqq17WBdbx6Z4jFGN8WXdVQ	2021-04-08 17:51:31.062076+03
j958g0se0nqzpcjfqq75nhmrc0g4am2y	.eJxVjEEOwiAQRe_C2hBgaKEu3fcMZGCmUjWQlHZlvLtt0oVu33v_v0XAbc1ha7yEmcRVaHH5ZRHTk8sh6IHlXmWqZV3mKI9EnrbJsRK_bmf7d5Cx5X2tmDx3QNEhGk7GW-OjS6CZe5yIdhjV5CCB1TrBoJQBo4g70-OgLIrPFwb4ODw:1lUUoJ:bRP5JHhUHhr4_VxINbn6KLU0U1z4Hvbwg6nZwbocGU8	2021-04-22 16:35:03.725888+03
yqhzd5loerlg1rca02ppqevgzvh1luzt	M2U3MTY0OGE4ZmYxZmFkNDNkZWZlOGI0YjBiOTA3NDE1MDUyODliYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YmExZjZlNzgyNzQzOGM2YmMwMTM3NmNkY2M3MGFkNzVmYWRiYjAxIn0=	2021-05-18 14:00:32.590707+03
mkuo33rj46u661w5frua9up1047n1yu7	.eJxVjDsOwjAQBe_iGlkm6y8lfc5gebNrHEC2FCcV4u4QKQW0b2beS8S0rSVunZc4k7gIJ06_G6bpwXUHdE_11uTU6rrMKHdFHrTLsRE_r4f7d1BSL986GxPAA4DVGAjYBa-zJq8R0mDBKQRtOVHGsxmQgmJvFLJThtAEq8X7A8nbN1o:1lRM1q:HcUvkmQzyAaD-uG4op0Hl1pWYpPy4QTOhPJ3yfbzsDM	2021-04-14 00:36:02.331657+03
z37sjc0rskx451uq2mypblk14eepxxoo	eyJfcGFzc3dvcmRfcmVzZXRfdG9rZW4iOiJhbGdoaTYtZjQzYmVhNDY1NzVlNTJkZjRkZDg2NTVlOGM3MDQ5YzMifQ:1lZ9fj:8WmkNNOBa_6NBpovl0hUwBccqgkIofQTX0zlLr1CLws	2021-05-05 13:01:27.568951+03
zpkowyo0tea5yt3pz7le2yh8d1hmjit2	M2U3MTY0OGE4ZmYxZmFkNDNkZWZlOGI0YjBiOTA3NDE1MDUyODliYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YmExZjZlNzgyNzQzOGM2YmMwMTM3NmNkY2M3MGFkNzVmYWRiYjAxIn0=	2021-06-04 13:19:06.69816+03
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.django_site (id, domain, name) FROM stdin;
1	localhost:8000	localhost:8000
\.


--
-- Data for Name: django_summernote_attachment; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.django_summernote_attachment (id, name, file, uploaded) FROM stdin;
1	yunistrim.png	django-summernote/2020-04-27/2a2da9b2-1a5f-4f0c-b7a3-6dd018fc92e2.png	2020-04-27 18:35:39.286953+03
2	TaxFree_лого.png	django-summernote/2020-04-27/e45d84b7-5f03-4068-9681-68e9d1ea72cd.png	2020-04-27 18:59:49.631807+03
4	blue-man.png	django-summernote/2020-04-27/0ad8a428-3ba4-4382-85d5-cb42aed004a6.png	2020-04-27 19:03:16.462174+03
7	banner-mix.png	django-summernote/2020-04-27/5771fecd-4267-4a94-a06e-16cefb0feb02.png	2020-04-27 19:03:42.578915+03
8	manner-max.png	django-summernote/2020-04-27/9d94a9d1-2161-49a6-a274-11afb880fb8a.png	2020-04-27 19:04:30.817894+03
9	orange-man.png	django-summernote/2020-04-27/9e05dbb7-60ef-432e-ab59-6a61fe69ff59.png	2020-04-27 19:05:06.237707+03
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 44, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 7, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: blog_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.blog_comment_id_seq', 13, true);


--
-- Name: blog_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.blog_post_id_seq', 24, true);


--
-- Name: blog_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.blog_profile_id_seq', 2, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 68, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 11, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 30, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);


--
-- Name: django_summernote_attachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.django_summernote_attachment_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: blog_comment blog_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.blog_comment
    ADD CONSTRAINT blog_comment_pkey PRIMARY KEY (id);


--
-- Name: blog_post blog_post_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.blog_post
    ADD CONSTRAINT blog_post_pkey PRIMARY KEY (id);


--
-- Name: blog_profile blog_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.blog_profile
    ADD CONSTRAINT blog_profile_pkey PRIMARY KEY (id);


--
-- Name: blog_profile blog_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.blog_profile
    ADD CONSTRAINT blog_profile_user_id_key UNIQUE (user_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: django_summernote_attachment django_summernote_attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_summernote_attachment
    ADD CONSTRAINT django_summernote_attachment_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: blog_comment_post_id_580e96ef; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX blog_comment_post_id_580e96ef ON public.blog_comment USING btree (post_id);


--
-- Name: blog_post_author_id_dd7a8485; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX blog_post_author_id_dd7a8485 ON public.blog_post USING btree (author_id);


--
-- Name: blog_post_slug_b95473f2; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX blog_post_slug_b95473f2 ON public.blog_post USING btree (slug);


--
-- Name: blog_post_slug_b95473f2_like; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX blog_post_slug_b95473f2_like ON public.blog_post USING btree (slug varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_comment blog_comment_post_id_580e96ef_fk_blog_post_id; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.blog_comment
    ADD CONSTRAINT blog_comment_post_id_580e96ef_fk_blog_post_id FOREIGN KEY (post_id) REFERENCES public.blog_post(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_post blog_post_author_id_dd7a8485_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.blog_post
    ADD CONSTRAINT blog_post_author_id_dd7a8485_fk_auth_user_id FOREIGN KEY (author_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_profile blog_profile_user_id_2bc46caa_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.blog_profile
    ADD CONSTRAINT blog_profile_user_id_2bc46caa_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

