--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4 (Debian 13.4-4.pgdg110+1)
-- Dumped by pg_dump version 13.4 (Debian 13.4-4.pgdg110+1)

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
-- Name: data_fetched; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_fetched (
    id integer NOT NULL,
    match_id integer,
    division text,
    country text,
    co2 integer,
    mix_1 text,
    mix_2 text,
    mix_3 text,
    created_at_utc timestamp without time zone,
    has_been_tweeted boolean,
    tweeted_at_utc timestamp without time zone,
    mix_1_mwh integer,
    mix_2_mwh integer,
    mix_3_mwh integer,
    mix_1_pct integer,
    mix_2_pct integer,
    mix_3_pct integer
);


ALTER TABLE public.data_fetched OWNER TO postgres;

--
-- Name: data_fetched_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_fetched_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_fetched_id_seq OWNER TO postgres;

--
-- Name: data_fetched_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_fetched_id_seq OWNED BY public.data_fetched.id;


--
-- Name: zone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zone (
    zone_id text NOT NULL,
    zone_name text,
    country text,
    emoji text,
    last_query_dt timestamp without time zone,
    last_publish_dt timestamp without time zone,
    division text,
    probability numeric
);


ALTER TABLE public.zone OWNER TO postgres;

--
-- Name: data_fetched id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_fetched ALTER COLUMN id SET DEFAULT nextval('public.data_fetched_id_seq'::regclass);


--
-- Data for Name: data_fetched; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_fetched (id, match_id, division, country, co2, mix_1, mix_2, mix_3, created_at_utc, has_been_tweeted, tweeted_at_utc, mix_1_mwh, mix_2_mwh, mix_3_mwh, mix_1_pct, mix_2_pct, mix_3_pct) FROM stdin;
9	1	Southern Europe	Spain	130	wind	nuclear	gas	2022-02-16 11:18:13.925805	f	\N	12528	7098	6192	38	21	19
10	1	Southern Europe	Portugal	228	gas	wind	hydro_discharge	2022-02-16 11:18:13.925805	f	\N	2293	1949	563	40	34	10
11	2	Central Europe	UK	157	wind	gas	nuclear	2022-02-16 11:18:14.334313	f	\N	13109	7230	4767	45	25	16
12	2	Central Europe	Germany	228	wind	coal	gas	2022-02-16 11:18:14.334313	f	\N	45197	16088	6724	53	19	8
13	3	Northern Europe	Finland	188	nuclear	hydro	coal	2022-02-16 11:18:14.732399	f	\N	2801	2022	1211	33	24	14
14	3	Northern Europe	Sweden	41	hydro	nuclear	wind	2022-02-16 11:18:14.732399	f	\N	10967	6983	3883	46	29	16
15	4	Southern Europe	Portugal	200	wind	gas	biomass	2022-02-16 12:57:55.88795	f	\N	1806	1022	383	55	31	12
16	4	Southern Europe	Italy	365	gas	solar	unknown	2022-02-16 12:57:55.88795	f	\N	20973	6976	2764	54	18	7
17	5	Central Europe	Germany	226	wind	coal	gas	2022-02-16 12:57:56.502689	f	\N	44695	16043	6389	53	19	8
18	5	Central Europe	Hungary	253	nuclear	gas	solar	2022-02-16 12:57:56.502689	f	\N	1452	1128	828	35	27	20
19	6	Northern Europe	Norway	28	hydro	wind	hydro_discharge	2022-02-16 12:57:57.943769	f	\N	18411	1662	225	90	8	1
20	6	Northern Europe	Finland	189	nuclear	hydro	coal	2022-02-16 12:57:57.943769	f	\N	2801	2030	1198	34	24	14
21	7	Southern Europe	Portugal	200	wind	gas	biomass	2022-02-16 13:00:32.735124	f	\N	1806	1022	383	55	31	12
22	7	Southern Europe	Spain	113	wind	solar	nuclear	2022-02-16 13:00:32.735124	f	\N	12478	8504	7106	35	24	20
23	8	Central Europe	France	44	nuclear	wind	hydro	2022-02-16 13:00:33.482013	f	\N	44972	13376	5602	63	19	8
24	8	Central Europe	UK	153	wind	gas	nuclear	2022-02-16 13:00:33.482013	f	\N	12247	7155	4766	41	24	16
25	9	Northern Europe	Denmark	167	wind	biomass	coal	2022-02-16 13:00:35.18744	f	\N	3130	768	522	65	16	11
26	9	Northern Europe	Norway	28	hydro	wind	hydro_discharge	2022-02-16 13:00:35.18744	f	\N	18411	1662	225	90	8	1
27	10	Southern Europe	Spain	113	wind	solar	nuclear	2022-02-16 13:03:52.343392	f	\N	12478	8504	7106	35	24	20
28	10	Southern Europe	Portugal	200	wind	gas	biomass	2022-02-16 13:03:52.343392	f	\N	1806	1022	383	55	31	12
29	11	Central Europe	Hungary	235	nuclear	gas	solar	2022-02-16 13:03:53.010828	f	\N	1452	1128	828	35	27	20
30	11	Central Europe	Germany	226	wind	coal	gas	2022-02-16 13:03:53.010828	f	\N	44695	16043	6389	53	19	8
31	12	Northern Europe	Sweden	41	hydro	nuclear	wind	2022-02-16 13:03:53.824597	f	\N	10758	6991	3615	46	30	15
32	12	Northern Europe	Denmark	167	wind	biomass	coal	2022-02-16 13:03:53.824597	f	\N	3130	768	522	65	16	11
33	13	Southern Europe	Portugal	200	wind	gas	biomass	2022-02-16 13:04:23.228958	f	\N	1806	1022	383	55	31	12
34	13	Southern Europe	Italy	365	gas	solar	unknown	2022-02-16 13:04:23.228958	f	\N	20973	6976	2764	54	18	7
35	14	Central Europe	UK	153	wind	gas	nuclear	2022-02-16 13:04:23.982438	f	\N	12247	7155	4766	41	24	16
36	14	Central Europe	France	44	nuclear	wind	hydro	2022-02-16 13:04:23.982438	f	\N	44972	13376	5602	63	19	8
37	15	Northern Europe	Denmark	167	wind	biomass	coal	2022-02-16 13:04:25.651065	f	\N	3130	768	522	65	16	11
38	15	Northern Europe	Norway	28	hydro	wind	hydro_discharge	2022-02-16 13:04:25.651065	f	\N	18411	1662	225	90	8	1
39	16	Southern Europe	Portugal	200	wind	gas	biomass	2022-02-16 13:12:37.661429	f	\N	1806	1022	383	55	31	12
40	16	Southern Europe	Italy	365	gas	solar	unknown	2022-02-16 13:12:37.661429	f	\N	20973	6976	2764	54	18	7
41	17	Central Europe	UK	153	wind	gas	nuclear	2022-02-16 13:12:38.342905	f	\N	12247	7155	4766	41	24	16
42	17	Central Europe	France	44	nuclear	wind	hydro	2022-02-16 13:12:38.342905	f	\N	44972	13376	5602	63	19	8
43	18	Southern Europe	Italy	365	gas	solar	unknown	2022-02-16 13:12:57.340119	f	\N	20973	6976	2764	54	18	7
44	18	Southern Europe	Spain	113	wind	solar	nuclear	2022-02-16 13:12:57.340119	f	\N	12478	8504	7106	35	24	20
45	19	Southern Europe	Italy	365	gas	solar	unknown	2022-02-16 13:15:03.868371	f	\N	20973	6976	2764	54	18	7
46	19	Southern Europe	Spain	113	wind	solar	nuclear	2022-02-16 13:15:03.868371	f	\N	12478	8504	7106	35	24	20
47	20	Central Europe	Germany	226	wind	coal	gas	2022-02-16 13:15:04.70467	f	\N	44695	16043	6389	53	19	8
48	20	Central Europe	Hungary	235	nuclear	gas	solar	2022-02-16 13:15:04.70467	f	\N	1452	1128	828	35	27	20
49	21	Northern Europe	Norway	28	hydro	wind	hydro_discharge	2022-02-16 13:15:06.214895	f	\N	18411	1662	225	90	8	1
50	21	Northern Europe	Finland	189	nuclear	hydro	coal	2022-02-16 13:15:06.214895	f	\N	2801	2030	1198	34	24	14
51	22	Southern Europe	Italy	365	gas	solar	unknown	2022-02-16 13:16:34.328144	f	\N	20973	6976	2764	54	18	7
52	22	Southern Europe	Portugal	200	wind	gas	biomass	2022-02-16 13:16:34.328144	f	\N	1806	1022	383	55	31	12
53	23	Central Europe	UK	153	wind	gas	nuclear	2022-02-16 13:16:34.980798	f	\N	12247	7155	4766	41	24	16
54	23	Central Europe	Germany	226	wind	coal	gas	2022-02-16 13:16:34.980798	f	\N	44695	16043	6389	53	19	8
55	24	Northern Europe	Finland	189	nuclear	hydro	coal	2022-02-16 13:16:35.610392	f	\N	2801	2030	1198	34	24	14
56	24	Northern Europe	Sweden	41	hydro	nuclear	wind	2022-02-16 13:16:35.610392	f	\N	10758	6991	3615	46	30	15
57	25	Southern Europe	Portugal	200	wind	gas	biomass	2022-02-16 13:17:39.824408	f	\N	1806	1022	383	55	31	12
58	25	Southern Europe	Spain	113	wind	solar	nuclear	2022-02-16 13:17:39.824408	f	\N	12478	8504	7106	35	24	20
59	26	Central Europe	Germany	226	wind	coal	gas	2022-02-16 13:17:40.466265	f	\N	44695	16043	6389	53	19	8
60	26	Central Europe	UK	153	wind	gas	nuclear	2022-02-16 13:17:40.466265	f	\N	12247	7155	4766	41	24	16
61	27	Northern Europe	Norway	28	hydro	wind	hydro_discharge	2022-02-16 13:17:41.897259	f	\N	18411	1662	225	90	8	1
62	27	Northern Europe	Finland	189	nuclear	hydro	coal	2022-02-16 13:17:41.897259	f	\N	2801	2030	1198	34	24	14
63	28	Southern Europe	Portugal	200	wind	gas	biomass	2022-02-16 13:19:49.897478	f	\N	1806	1022	383	55	31	12
64	28	Southern Europe	Spain	113	wind	solar	nuclear	2022-02-16 13:19:49.897478	f	\N	12478	8504	7106	35	24	20
65	29	Central Europe	France	44	nuclear	wind	hydro	2022-02-16 13:19:50.53988	f	\N	44972	13376	5602	63	19	8
66	29	Central Europe	Hungary	235	nuclear	gas	solar	2022-02-16 13:19:50.53988	f	\N	1452	1128	828	35	27	20
67	30	Northern Europe	Denmark	167	wind	biomass	coal	2022-02-16 13:19:51.324494	f	\N	3130	768	522	65	16	11
68	30	Northern Europe	Finland	189	nuclear	hydro	coal	2022-02-16 13:19:51.324494	f	\N	2801	2030	1198	34	24	14
69	31	Southern Europe	Spain	113	wind	solar	nuclear	2022-02-16 13:24:48.362955	f	\N	12478	8504	7106	35	24	20
70	31	Southern Europe	Portugal	200	wind	gas	biomass	2022-02-16 13:24:48.362955	f	\N	1806	1022	383	55	31	12
71	32	Central Europe	Hungary	235	nuclear	gas	solar	2022-02-16 13:24:49.030945	f	\N	1452	1128	828	35	27	20
72	32	Central Europe	Germany	226	wind	coal	gas	2022-02-16 13:24:49.030945	f	\N	44695	16043	6389	53	19	8
73	33	Northern Europe	Norway	28	hydro	wind	hydro_discharge	2022-02-16 13:24:50.381729	f	\N	18411	1662	225	90	8	1
74	33	Northern Europe	Sweden	41	hydro	nuclear	wind	2022-02-16 13:24:50.381729	f	\N	10758	6991	3615	46	30	15
75	34	Southern Europe	Portugal	195	wind	gas	biomass	2022-02-16 14:30:34.862142	f	\N	1829	889	386	57	28	12
76	34	Southern Europe	Italy	360	gas	solar	coal	2022-02-16 14:30:34.862142	f	\N	20808	7303	2723	54	19	7
77	35	Central Europe	France	43	nuclear	wind	hydro	2022-02-16 14:30:35.511813	f	\N	44900	13649	5743	63	19	8
78	35	Central Europe	UK	160	wind	gas	nuclear	2022-02-16 14:30:35.511813	f	\N	11780	7361	4797	39	25	16
79	36	Northern Europe	Sweden	42	hydro	nuclear	wind	2022-02-16 14:30:36.133066	f	\N	10571	6991	3688	45	30	16
80	36	Northern Europe	Finland	188	nuclear	hydro	wind	2022-02-16 14:30:36.133066	f	\N	2800	2010	1381	33	24	16
81	37	Southern Europe	Spain	110	wind	solar	nuclear	2022-02-16 14:40:17.703358	f	\N	12630	9289	7105	34	25	19
82	37	Southern Europe	Italy	360	gas	solar	coal	2022-02-16 14:40:17.703358	f	\N	20808	7303	2723	54	19	7
83	38	Central Europe	Germany	229	wind	coal	gas	2022-02-16 14:40:21.892538	f	\N	44843	16685	6515	53	20	8
84	38	Central Europe	Hungary	234	nuclear	gas	solar	2022-02-16 14:40:21.892538	f	\N	1453	1153	779	35	28	19
85	39	Northern Europe	Norway	28	hydro	wind	hydro_discharge	2022-02-16 14:40:23.31673	f	\N	17693	1855	225	89	9	1
86	39	Northern Europe	Sweden	42	hydro	nuclear	wind	2022-02-16 14:40:23.31673	f	\N	10571	6991	3688	45	30	16
87	40	Southern Europe	Greece	340	gas	solar	wind	2022-02-16 14:42:12.154957	f	\N	2862	1312	1177	48	22	20
88	40	Southern Europe	Spain	108	wind	solar	nuclear	2022-02-16 14:42:12.154957	f	\N	13002	9159	7103	35	24	19
89	41	Central Europe	Germany	230	wind	coal	gas	2022-02-16 14:42:12.828075	f	\N	44832	16588	6481	53	20	8
90	41	Central Europe	France	48	nuclear	wind	hydro	2022-02-16 14:42:12.828075	f	\N	44589	13827	5218	63	20	7
91	42	Northern Europe	Denmark	133	wind	biomass	coal	2022-02-16 14:42:13.647513	f	\N	3975	773	444	72	14	8
92	42	Northern Europe	Sweden	42	hydro	nuclear	wind	2022-02-16 14:42:13.647513	f	\N	10571	6991	3688	45	30	16
93	43	Southern Europe	Italy	394	gas	hydro	coal	2022-02-17 09:10:43.54163	f	\N	20608	3234	2987	63	10	9
94	43	Southern Europe	Spain	179	wind	gas	nuclear	2022-02-17 09:10:43.54163	f	\N	9670	8935	7093	32	30	24
95	44	Central Europe	UK	98	wind	nuclear	gas	2022-02-17 09:10:44.173388	f	\N	14366	5319	3510	56	21	14
96	44	Central Europe	France	47	nuclear	wind	hydro	2022-02-17 09:10:44.173388	f	\N	45046	12813	6929	63	18	10
97	45	Northern Europe	Sweden	41	hydro	nuclear	wind	2022-02-17 09:10:44.775925	f	\N	10686	6990	4181	45	29	18
98	45	Northern Europe	Finland	179	nuclear	hydro	wind	2022-02-17 09:10:44.775925	f	\N	2798	1993	1378	33	24	16
99	46	Southern Europe	Portugal	237	wind	gas	hydro_discharge	2022-02-17 11:40:44.077523	f	\N	1709	1692	390	39	39	9
100	46	Southern Europe	Spain	171	gas	wind	nuclear	2022-02-17 11:40:44.077523	f	\N	9116	8257	7093	28	25	21
101	47	Southern Europe	Greece	409	gas	solar	coal	2022-02-17 11:44:25.783591	f	\N	3411	769	621	62	14	11
102	47	Southern Europe	Italy	340	gas	solar	coal	2022-02-17 11:44:25.783591	f	\N	19837	7130	2947	51	18	8
103	48	Southern Europe	Portugal	208	wind	gas	hydro_discharge	2022-02-17 11:44:49.180931	f	\N	1709	1692	390	39	39	9
104	48	Southern Europe	Greece	409	gas	solar	coal	2022-02-17 11:44:49.180931	f	\N	3411	769	621	62	14	11
105	49	Central Europe	UK	112	wind	nuclear	gas	2022-02-17 11:44:51.747932	f	\N	14715	5322	4478	49	18	15
106	49	Central Europe	Hungary	186	nuclear	solar	gas	2022-02-17 11:44:51.747932	f	\N	1453	1066	647	37	27	16
107	50	Northern Europe	Denmark	150	wind	coal	biomass	2022-02-17 11:44:53.50746	f	\N	4207	750	646	67	12	10
108	50	Northern Europe	Norway	39	hydro	wind	hydro_discharge	2022-02-17 11:44:53.50746	f	\N	17408	853	151	94	5	1
109	51	Southern Europe	Portugal	208	wind	gas	hydro_discharge	2022-02-17 11:46:48.819787	f	\N	1709	1692	390	39	39	9
110	51	Southern Europe	Spain	170	gas	solar	wind	2022-02-17 11:46:48.819787	f	\N	9027	7573	7276	26	22	21
111	52	Central Europe	UK	112	wind	nuclear	gas	2022-02-17 11:46:49.49327	f	\N	14715	5322	4478	49	18	15
112	52	Central Europe	France	47	nuclear	wind	hydro	2022-02-17 11:46:49.49327	f	\N	45267	11964	6292	63	17	9
113	53	Northern Europe	Denmark	150	wind	coal	biomass	2022-02-17 11:46:50.318898	f	\N	4207	750	646	67	12	10
114	53	Northern Europe	Finland	174	nuclear	hydro	wind	2022-02-17 11:46:50.318898	f	\N	2801	2076	1450	33	24	17
115	54	Southern Europe	Spain	170	gas	solar	wind	2022-02-17 11:47:14.376145	f	\N	9027	7573	7276	26	22	21
116	54	Southern Europe	Portugal	208	wind	gas	hydro_discharge	2022-02-17 11:47:14.376145	f	\N	1709	1692	390	39	39	9
117	55	Central Europe	France	47	nuclear	wind	hydro	2022-02-17 11:47:15.073475	f	\N	45267	11964	6292	63	17	9
118	55	Central Europe	UK	112	wind	nuclear	gas	2022-02-17 11:47:15.073475	f	\N	14715	5322	4478	49	18	15
119	56	Northern Europe	Norway	39	hydro	wind	hydro_discharge	2022-02-17 11:47:16.558038	f	\N	17408	853	151	94	5	1
120	56	Northern Europe	Finland	174	nuclear	hydro	wind	2022-02-17 11:47:16.558038	f	\N	2801	2076	1450	33	24	17
121	57	Southern Europe	Portugal	208	wind	gas	hydro_discharge	2022-02-17 11:47:59.926078	f	\N	1709	1692	390	39	39	9
122	57	Southern Europe	Italy	340	gas	solar	coal	2022-02-17 11:47:59.926078	f	\N	19837	7130	2947	51	18	8
123	58	Central Europe	France	47	nuclear	wind	hydro	2022-02-17 11:48:00.65955	f	\N	45267	11964	6292	63	17	9
124	58	Central Europe	Germany	120	wind	solar	coal	2022-02-17 11:48:00.65955	f	\N	46371	10395	5076	61	14	7
125	59	Northern Europe	Denmark	150	wind	coal	biomass	2022-02-17 11:48:02.372701	f	\N	4207	750	646	67	12	10
126	59	Northern Europe	Norway	39	hydro	wind	hydro_discharge	2022-02-17 11:48:02.372701	f	\N	17408	853	151	94	5	1
127	60	Southern Europe	Italy	324	gas	solar	wind	2022-02-17 14:08:10.477494	f	\N	18290	7858	2943	50	22	8
128	60	Southern Europe	Portugal	162	wind	gas	biomass	2022-02-17 14:08:10.477494	f	\N	2269	933	383	62	25	10
129	61	Central Europe	France	47	nuclear	wind	hydro	2022-02-17 14:08:11.209006	f	\N	42560	12089	5678	62	17	8
130	61	Central Europe	UK	102	wind	nuclear	solar	2022-02-17 14:08:11.209006	f	\N	14682	5523	4270	47	18	14
131	62	Northern Europe	Finland	170	nuclear	wind	hydro	2022-02-17 14:08:12.070392	f	\N	2797	1739	1222	36	22	16
132	62	Northern Europe	Denmark	124	wind	coal	biomass	2022-02-17 14:08:12.070392	f	\N	5300	696	462	74	10	6
133	63	Southern Europe	Spain	159	solar	gas	nuclear	2022-02-17 15:02:43.922056	f	\N	10469	8400	7086	30	24	20
134	63	Southern Europe	Portugal	205	wind	gas	biomass	2022-02-17 15:02:43.922056	f	\N	1753	1064	381	54	33	12
135	64	Central Europe	Germany	151	wind	solar	coal	2022-02-17 15:02:44.706263	f	\N	46389	11563	9333	56	14	11
136	64	Central Europe	Hungary	228	nuclear	gas	solar	2022-02-17 15:02:44.706263	f	\N	1452	1024	580	37	26	15
137	65	Northern Europe	Denmark	124	wind	coal	biomass	2022-02-17 15:02:46.490709	f	\N	5170	699	395	75	10	6
138	65	Northern Europe	Norway	45	hydro	wind	hydro_discharge	2022-02-17 15:02:46.490709	f	\N	15452	1503	149	89	9	1
139	66	Southern Europe	Italy	400	gas	coal	unknown	2022-02-18 08:17:23.005097	f	\N	15748	3139	2388	60	12	9
140	66	Southern Europe	Spain	176	gas	nuclear	wind	2022-02-18 08:17:23.005097	f	\N	7267	7102	6224	28	28	24
141	67	Central Europe	Germany	296	wind	coal	gas	2022-02-18 08:17:23.703536	f	\N	24859	15721	5192	40	26	8
142	67	Central Europe	France	46	nuclear	wind	hydro	2022-02-18 08:17:23.703536	f	\N	43914	12497	7976	61	17	11
143	68	Northern Europe	Denmark	151	wind	coal	biomass	2022-02-18 08:17:25.653876	f	\N	4313	776	576	72	13	10
144	68	Northern Europe	Norway	28	hydro	wind	hydro_discharge	2022-02-18 08:17:25.653876	f	\N	18452	1286	319	91	6	2
145	69	Southern Europe	Italy	345	gas	solar	coal	2022-02-18 12:59:27.626372	f	\N	18122	6837	3099	51	19	9
146	69	Southern Europe	Spain	151	solar	nuclear	gas	2022-02-18 12:59:27.626372	f	\N	9235	7105	6849	29	22	22
147	70	Central Europe	UK	167	wind	gas	nuclear	2022-02-18 12:59:28.339387	f	\N	12155	8635	5780	38	27	18
148	70	Central Europe	Germany	225	wind	coal	gas	2022-02-18 12:59:28.339387	f	\N	37963	14361	5961	49	19	8
149	71	Northern Europe	Sweden	42	hydro	nuclear	wind	2022-02-18 12:59:28.996531	f	\N	9851	6988	4854	41	29	20
150	71	Northern Europe	Finland	173	nuclear	wind	hydro	2022-02-18 12:59:28.996531	f	\N	2799	1885	1664	33	22	19
151	72	Southern Europe	Spain	151	solar	nuclear	gas	2022-02-18 13:14:05.889874	f	\N	9235	7105	6849	29	22	22
152	72	Southern Europe	Italy	345	gas	solar	coal	2022-02-18 13:14:05.889874	f	\N	18122	6837	3099	51	19	9
153	73	Southern Europe	Italy	345	gas	solar	coal	2022-02-18 13:15:10.030095	f	\N	18122	6837	3099	51	19	9
154	73	Southern Europe	Spain	151	solar	nuclear	gas	2022-02-18 13:15:10.030095	f	\N	9235	7105	6849	29	22	22
155	74	Southern Europe	Italy	345	gas	solar	coal	2022-02-18 13:16:14.177164	f	\N	18122	6837	3099	51	19	9
156	74	Southern Europe	Spain	151	solar	nuclear	gas	2022-02-18 13:16:14.177164	f	\N	9235	7105	6849	29	22	22
157	75	Central Europe	France	45	nuclear	wind	hydro	2022-02-18 13:16:14.988411	f	\N	44120	13475	6479	60	18	9
158	75	Central Europe	UK	167	wind	gas	nuclear	2022-02-18 13:16:14.988411	f	\N	12155	8635	5780	38	27	18
159	76	Northern Europe	Denmark	242	wind	coal	biomass	2022-02-18 13:16:15.79284	f	\N	2375	1294	770	47	26	15
160	76	Northern Europe	Finland	173	nuclear	wind	hydro	2022-02-18 13:16:15.79284	f	\N	2799	1885	1664	33	22	19
161	77	Southern Europe	Italy	392	gas	coal	unknown	2022-02-18 18:00:05.934345	f	\N	20299	3050	2652	60	9	8
162	77	Southern Europe	Spain	140	solar	nuclear	gas	2022-02-18 18:00:05.934345	f	\N	9094	7084	5390	31	24	18
163	78	Central Europe	Germany	213	wind	coal	gas	2022-02-18 18:00:06.617854	f	\N	45219	13838	5206	59	18	7
164	78	Central Europe	France	44	nuclear	wind	hydro	2022-02-18 18:00:06.617854	f	\N	44163	11411	5577	66	17	8
165	79	Northern Europe	Finland	176	nuclear	wind	hydro	2022-02-18 18:00:08.18032	f	\N	2798	1938	1836	32	22	21
166	79	Northern Europe	Norway	33	hydro	wind	hydro_discharge	2022-02-18 18:00:08.18032	f	\N	17507	1266	335	91	7	2
167	80	Southern Europe	Spain	153	nuclear	gas	wind	2022-02-18 19:55:43.422422	f	\N	7085	6118	5999	27	23	23
168	80	Southern Europe	Portugal	236	gas	wind	hydro	2022-02-18 19:55:43.422422	f	\N	2636	1919	584	43	32	10
169	81	Central Europe	France	47	nuclear	wind	hydro	2022-02-18 19:55:44.146887	f	\N	44277	11956	7745	61	17	11
170	81	Central Europe	UK	245	gas	wind	nuclear	2022-02-18 19:55:44.146887	f	\N	12032	9183	5242	36	27	15
171	82	Northern Europe	Denmark	165	wind	coal	biomass	2022-02-18 19:55:45.045801	f	\N	3994	764	716	69	13	12
172	82	Northern Europe	Finland	179	nuclear	hydro	wind	2022-02-18 19:55:45.045801	f	\N	2800	2194	1997	30	23	21
173	83	Southern Europe	Italy	389	gas	hydro	coal	2022-02-18 20:23:05.150508	f	\N	21095	3904	3196	58	11	9
174	83	Southern Europe	Portugal	236	gas	wind	hydro	2022-02-18 20:23:05.150508	f	\N	2636	1919	584	43	32	10
175	84	Southern Europe	Spain	149	wind	nuclear	gas	2022-02-18 20:44:04.262083	f	\N	7786	7091	6459	27	25	23
176	84	Southern Europe	Italy	384	gas	hydro	coal	2022-02-18 20:44:04.262083	f	\N	20041	4115	3291	56	12	9
177	85	Southern Europe	Spain	149	wind	nuclear	gas	2022-02-18 20:44:17.339628	f	\N	7786	7091	6459	27	25	23
178	85	Southern Europe	Portugal	236	gas	wind	hydro	2022-02-18 20:44:17.339628	f	\N	2636	1919	584	43	32	10
179	86	Southern Europe	Portugal	236	gas	wind	hydro	2022-02-18 20:46:22.931972	f	\N	2636	1919	584	43	32	10
180	86	Southern Europe	Greece	377	gas	wind	hydro	2022-02-18 20:46:22.931972	f	\N	2896	926	894	54	17	17
181	87	Southern Europe	Italy	384	gas	hydro	coal	2022-02-18 20:47:02.389173	f	\N	20041	4115	3291	56	12	9
182	87	Southern Europe	Portugal	236	gas	wind	hydro	2022-02-18 20:47:02.389173	f	\N	2636	1919	584	43	32	10
183	88	Northern Europe	Finland	182	nuclear	wind	hydro	2022-02-18 20:47:04.081694	f	\N	2800	1796	1780	32	21	20
184	88	Northern Europe	Norway	30	hydro	wind	hydro_discharge	2022-02-18 20:47:04.081694	f	\N	19467	1476	352	91	7	2
185	89	Central Europe	Hungary	267	nuclear	gas	coal	2022-02-18 20:47:04.818562	f	\N	1456	1452	320	39	39	9
186	89	Central Europe	France	47	nuclear	wind	hydro	2022-02-18 20:47:04.818562	f	\N	42870	11596	7413	63	17	11
187	90	Southern Europe	Spain	154	wind	nuclear	gas	2022-02-19 00:00:05.596176	f	\N	10685	7104	6270	38	25	22
188	90	Southern Europe	Portugal	184	wind	gas	biomass	2022-02-19 00:00:05.596176	f	\N	3309	1683	398	60	30	7
189	91	Northern Europe	Sweden	42	hydro	nuclear	wind	2022-02-19 00:00:07.119091	f	\N	10037	5931	4182	45	27	19
190	91	Northern Europe	Norway	39	hydro	wind	hydro_discharge	2022-02-19 00:00:07.119091	f	\N	17569	1414	343	90	7	2
191	92	Central Europe	UK	152	wind	gas	nuclear	2022-02-19 00:00:07.764373	f	\N	10895	5987	5242	43	23	21
192	92	Central Europe	Germany	195	wind	coal	biomass	2022-02-19 00:00:07.764373	f	\N	36980	9641	5155	59	15	8
193	93	Southern Europe	Italy	358	gas	wind	coal	2022-02-19 06:00:06.821548	f	\N	8401	3756	3073	43	19	16
194	93	Southern Europe	Spain	131	wind	nuclear	gas	2022-02-19 06:00:06.821548	f	\N	10667	7099	5050	42	28	20
195	94	Southern Europe	Spain	131	wind	nuclear	gas	2022-02-19 06:00:09.043075	f	\N	10667	7099	5050	42	28	20
196	94	Southern Europe	Portugal	85	wind	biomass	gas	2022-02-19 06:00:09.043075	f	\N	3563	403	280	80	9	6
197	95	Southern Europe	Spain	131	wind	nuclear	gas	2022-02-19 06:00:11.536265	f	\N	10667	7099	5050	42	28	20
198	95	Southern Europe	Italy	358	gas	wind	coal	2022-02-19 06:00:11.536265	f	\N	8401	3756	3073	43	19	16
199	96	Southern Europe	Italy	358	gas	wind	coal	2022-02-19 06:00:13.9259	f	\N	8401	3756	3073	43	19	16
200	96	Southern Europe	Portugal	85	wind	biomass	gas	2022-02-19 06:00:13.9259	f	\N	3563	403	280	80	9	6
201	97	Southern Europe	Italy	358	gas	wind	coal	2022-02-19 06:00:17.482694	f	\N	8401	3756	3073	43	19	16
202	97	Southern Europe	Spain	131	wind	nuclear	gas	2022-02-19 06:00:17.482694	f	\N	10667	7099	5050	42	28	20
203	98	Southern Europe	Portugal	85	wind	biomass	gas	2022-02-19 06:01:21.995495	f	\N	3563	403	280	80	9	6
204	98	Southern Europe	Italy	358	gas	wind	coal	2022-02-19 06:01:21.995495	f	\N	8401	3756	3073	43	19	16
205	99	Northern Europe	Denmark	125	wind	coal	biomass	2022-02-19 06:01:22.891766	f	\N	4473	464	366	80	8	7
206	99	Northern Europe	Sweden	45	hydro	nuclear	wind	2022-02-19 06:01:22.891766	f	\N	8115	5582	4338	42	29	22
207	100	Central Europe	France	43	nuclear	wind	hydro	2022-02-19 06:01:23.505851	f	\N	41103	8114	5141	70	14	9
208	100	Central Europe	UK	98	wind	nuclear	gas	2022-02-19 06:01:23.505851	f	\N	12470	5256	2871	56	24	13
209	101	Southern Europe	Spain	152	wind	nuclear	gas	2022-02-19 09:52:35.495482	f	\N	9870	7100	5755	38	27	22
210	101	Southern Europe	Greece	444	gas	coal	wind	2022-02-19 09:52:35.495482	f	\N	2037	393	300	65	13	10
211	102	Northern Europe	Denmark	121	wind	biomass	coal	2022-02-19 09:52:36.464542	f	\N	4652	630	417	78	11	7
212	102	Northern Europe	Finland	184	nuclear	hydro	coal	2022-02-19 09:52:36.464542	f	\N	2799	1221	1169	41	18	17
213	103	Central Europe	France	48	nuclear	hydro	wind	2022-02-19 09:52:37.082801	f	\N	41297	7485	6617	66	12	11
214	103	Central Europe	Germany	153	wind	coal	solar	2022-02-19 09:52:37.082801	f	\N	43931	8268	5790	60	11	8
215	104	Southern Europe	Spain	152	wind	nuclear	gas	2022-02-19 09:54:28.55472	f	\N	9870	7100	5755	38	27	22
216	104	Southern Europe	Italy	336	gas	coal	wind	2022-02-19 09:54:28.55472	f	\N	11076	2945	2937	43	11	11
217	105	Northern Europe	Finland	184	nuclear	hydro	coal	2022-02-19 09:54:29.228854	f	\N	2799	1221	1169	41	18	17
218	105	Northern Europe	Sweden	50	hydro	nuclear	wind	2022-02-19 09:54:29.228854	f	\N	9700	5580	4418	45	26	21
219	106	Central Europe	UK	110	wind	nuclear	gas	2022-02-19 09:54:29.871917	f	\N	11410	5266	3435	51	23	15
220	106	Central Europe	Hungary	227	nuclear	gas	coal	2022-02-19 09:54:29.871917	f	\N	1457	1004	320	44	30	10
221	107	Southern Europe	Italy	336	gas	coal	wind	2022-02-19 09:54:34.499948	f	\N	11076	2945	2937	43	11	11
222	107	Southern Europe	Portugal	113	wind	gas	hydro_discharge	2022-02-19 09:54:34.499948	f	\N	3135	599	419	66	13	9
223	108	Northern Europe	Denmark	121	wind	biomass	coal	2022-02-19 09:54:35.380593	f	\N	4652	630	417	78	11	7
224	108	Northern Europe	Sweden	50	hydro	nuclear	wind	2022-02-19 09:54:35.380593	f	\N	9700	5580	4418	45	26	21
225	109	Central Europe	Germany	153	wind	coal	solar	2022-02-19 09:54:36.017481	f	\N	43931	8268	5790	60	11	8
226	109	Central Europe	France	48	nuclear	hydro	wind	2022-02-19 09:54:36.017481	f	\N	41297	7485	6617	66	12	11
227	110	Southern Europe	Italy	336	gas	coal	wind	2022-02-19 09:54:42.59372	f	\N	11076	2945	2937	43	11	11
228	110	Southern Europe	Spain	152	wind	nuclear	gas	2022-02-19 09:54:42.59372	f	\N	9870	7100	5755	38	27	22
229	111	Northern Europe	Finland	184	nuclear	hydro	coal	2022-02-19 09:54:43.273219	f	\N	2799	1221	1169	41	18	17
230	111	Northern Europe	Sweden	50	hydro	nuclear	wind	2022-02-19 09:54:43.273219	f	\N	9700	5580	4418	45	26	21
231	112	Southern Europe	Italy	314	gas	solar	coal	2022-02-19 12:00:07.936125	f	\N	12308	5763	2881	42	20	10
232	112	Southern Europe	Portugal	119	wind	hydro_discharge	gas	2022-02-19 12:00:07.936125	f	\N	3038	1011	610	55	18	11
233	113	Southern Europe	Italy	314	gas	solar	coal	2022-02-19 12:00:10.416342	f	\N	12308	5763	2881	42	20	10
234	113	Southern Europe	Spain	116	wind	nuclear	solar	2022-02-19 12:00:10.416342	f	\N	9763	7099	4580	34	24	16
235	114	Northern Europe	Denmark	108	wind	biomass	solar	2022-02-19 12:00:12.423894	f	\N	4462	561	404	76	10	7
236	114	Northern Europe	Norway	44	hydro	wind	hydro_discharge	2022-02-19 12:00:12.423894	f	\N	14510	1120	250	90	7	2
237	115	Central Europe	UK	219	gas	wind	nuclear	2022-02-19 12:00:13.059199	f	\N	9554	7819	5277	34	28	19
238	115	Central Europe	France	47	nuclear	hydro	wind	2022-02-19 12:00:13.059199	f	\N	41933	7528	5782	65	12	9
239	116	Southern Europe	Spain	113	wind	nuclear	solar	2022-02-19 18:00:05.779292	f	\N	8234	7103	5488	30	25	20
240	116	Southern Europe	Portugal	114	wind	solar	gas	2022-02-19 18:00:05.779292	f	\N	2495	793	663	56	18	15
241	117	Northern Europe	Sweden	43	hydro	nuclear	wind	2022-02-19 18:00:06.50942	f	\N	9363	5585	4697	43	26	22
242	117	Northern Europe	Finland	188	nuclear	hydro	coal	2022-02-19 18:00:06.50942	f	\N	2800	1600	1247	37	21	16
243	118	Central Europe	Germany	184	wind	coal	biomass	2022-02-19 18:00:07.172949	f	\N	37444	8673	5228	57	13	8
244	118	Central Europe	UK	263	gas	nuclear	wind	2022-02-19 18:00:07.172949	f	\N	13414	5274	4617	46	18	16
245	119	Southern Europe	Spain	154	nuclear	wind	gas	2022-02-20 00:00:06.485874	f	\N	7104	7073	5712	28	28	23
246	119	Southern Europe	Italy	407	gas	coal	wind	2022-02-20 00:00:06.485874	f	\N	13967	3183	2256	58	13	9
247	120	Northern Europe	Sweden	42	hydro	nuclear	wind	2022-02-20 00:00:07.354695	f	\N	8781	5589	4737	42	27	23
248	120	Northern Europe	Denmark	143	wind	biomass	coal	2022-02-20 00:00:07.354695	f	\N	4488	932	681	70	15	11
249	121	Central Europe	UK	186	wind	gas	nuclear	2022-02-20 00:00:07.978283	f	\N	9690	7437	4779	38	29	19
250	121	Central Europe	France	45	nuclear	wind	hydro	2022-02-20 00:00:07.978283	f	\N	39808	11594	7251	63	18	11
251	122	Southern Europe	Portugal	177	wind	gas	biomass	2022-02-20 06:00:06.262475	f	\N	1524	575	365	57	22	14
252	122	Southern Europe	Italy	363	gas	wind	coal	2022-02-20 06:00:06.262475	f	\N	7280	3034	2988	42	17	17
253	123	Northern Europe	Finland	188	nuclear	hydro	coal	2022-02-20 06:00:07.145155	f	\N	2800	1309	1112	39	18	16
254	123	Northern Europe	Denmark	207	wind	biomass	coal	2022-02-20 06:00:07.145155	f	\N	1764	979	754	46	25	20
255	124	Central Europe	Germany	202	wind	coal	biomass	2022-02-20 06:00:07.868649	f	\N	26657	7875	5115	55	16	11
256	124	Central Europe	France	48	nuclear	wind	hydro	2022-02-20 06:00:07.868649	f	\N	39232	10274	4918	67	18	8
257	125	Southern Europe	Italy	308	gas	solar	coal	2022-02-20 12:00:07.022919	f	\N	8619	5935	3084	36	25	13
258	125	Southern Europe	Spain	126	solar	nuclear	wind	2022-02-20 12:00:07.022919	f	\N	8186	7103	4751	30	26	17
259	126	Northern Europe	Finland	193	nuclear	hydro	coal	2022-02-20 12:00:07.705539	f	\N	2798	1695	1233	39	24	17
260	126	Northern Europe	Sweden	52	hydro	nuclear	unknown	2022-02-20 12:00:07.705539	f	\N	11434	5584	2046	55	27	10
261	127	Central Europe	UK	117	wind	nuclear	gas	2022-02-20 12:00:08.383656	f	\N	12610	4782	2463	53	20	10
262	127	Central Europe	France	42	nuclear	wind	hydro	2022-02-20 12:00:08.383656	f	\N	38849	12662	5363	60	20	8
263	128	Southern Europe	Italy	365	gas	hydro	coal	2022-02-20 20:12:27.412619	f	\N	12156	3234	3153	49	13	13
264	128	Southern Europe	Portugal	186	hydro_discharge	hydro	gas	2022-02-20 20:12:27.412619	f	\N	1372	1157	663	33	28	16
265	129	Southern Europe	Spain	164	nuclear	gas	wind	2022-02-20 20:12:29.108765	f	\N	7103	6499	4496	29	27	18
266	129	Southern Europe	Portugal	186	hydro_discharge	hydro	gas	2022-02-20 20:12:29.108765	f	\N	1372	1157	663	33	28	16
267	130	Southern Europe	Spain	164	nuclear	gas	wind	2022-02-20 20:12:32.022926	f	\N	7103	6499	4496	29	27	18
268	130	Southern Europe	Italy	365	gas	hydro	coal	2022-02-20 20:12:32.022926	f	\N	12156	3234	3153	49	13	13
269	131	Southern Europe	Spain	164	nuclear	gas	wind	2022-02-20 20:12:33.559868	f	\N	7103	6499	4496	29	27	18
270	131	Southern Europe	Portugal	186	hydro_discharge	hydro	gas	2022-02-20 20:12:33.559868	f	\N	1372	1157	663	33	28	16
271	132	Southern Europe	Spain	164	nuclear	gas	wind	2022-02-20 20:14:48.520527	f	\N	7103	6499	4496	29	27	18
272	132	Southern Europe	Italy	365	gas	hydro	coal	2022-02-20 20:14:48.520527	f	\N	12156	3234	3153	49	13	13
273	133	Southern Europe	Portugal	186	hydro_discharge	hydro	gas	2022-02-20 20:14:50.68072	f	\N	1372	1157	663	33	28	16
274	133	Southern Europe	Spain	164	nuclear	gas	wind	2022-02-20 20:14:50.68072	f	\N	7103	6499	4496	29	27	18
275	134	Southern Europe	Italy	365	gas	hydro	coal	2022-02-20 20:14:53.949096	f	\N	12156	3234	3153	49	13	13
276	134	Southern Europe	Spain	164	nuclear	gas	wind	2022-02-20 20:14:53.949096	f	\N	7103	6499	4496	29	27	18
277	135	Southern Europe	Portugal	186	hydro_discharge	hydro	gas	2022-02-20 20:14:57.692551	f	\N	1372	1157	663	33	28	16
278	135	Southern Europe	Italy	365	gas	hydro	coal	2022-02-20 20:14:57.692551	f	\N	12156	3234	3153	49	13	13
279	136	Southern Europe	Spain	164	nuclear	gas	wind	2022-02-20 20:16:24.143219	f	\N	7103	6499	4496	29	27	18
280	136	Southern Europe	Italy	365	gas	hydro	coal	2022-02-20 20:16:24.143219	f	\N	12156	3234	3153	49	13	13
281	137	Northern Europe	Norway	38	hydro	wind	hydro_discharge	2022-02-20 20:16:25.64991	f	\N	15886	1978	274	87	11	1
282	137	Northern Europe	Sweden	50	hydro	nuclear	wind	2022-02-20 20:16:25.64991	f	\N	10963	5578	3460	50	26	16
283	138	Central Europe	Germany	152	wind	coal	biomass	2022-02-20 20:16:26.286504	f	\N	48206	7971	5304	67	11	7
284	138	Central Europe	UK	201	wind	gas	nuclear	2022-02-20 20:16:26.286504	f	\N	12711	7731	4782	40	24	15
285	139	Southern Europe	Portugal	186	hydro_discharge	hydro	gas	2022-02-20 20:23:47.017646	f	\N	1372	1157	663	33	28	16
286	139	Southern Europe	Italy	365	gas	hydro	coal	2022-02-20 20:23:47.017646	f	\N	12156	3234	3153	49	13	13
287	140	Northern Europe	Denmark	132	wind	biomass	coal	2022-02-20 20:23:48.697013	f	\N	5245	845	561	75	12	8
288	140	Northern Europe	Norway	38	hydro	wind	hydro_discharge	2022-02-20 20:23:48.697013	f	\N	15886	1978	274	87	11	1
289	141	Central Europe	France	40	nuclear	wind	hydro	2022-02-20 20:23:49.344005	f	\N	39496	14262	7244	60	22	11
290	141	Central Europe	UK	201	wind	gas	nuclear	2022-02-20 20:23:49.344005	f	\N	12711	7731	4782	40	24	15
291	142	Southern Europe	Spain	183	gas	nuclear	wind	2022-02-21 00:00:07.09317	f	\N	8539	7102	6336	31	26	23
292	142	Southern Europe	Italy	386	gas	coal	hydro	2022-02-21 00:00:07.09317	f	\N	12100	3046	2782	54	14	12
293	143	Northern Europe	Finland	196	nuclear	coal	hydro	2022-02-21 00:00:07.809216	f	\N	2799	1166	1106	43	18	17
294	143	Northern Europe	Sweden	52	hydro	nuclear	wind	2022-02-21 00:00:07.809216	f	\N	9542	5573	3948	46	27	19
295	144	Central Europe	Germany	163	wind	coal	biomass	2022-02-21 00:00:08.457292	f	\N	45557	8717	5298	66	13	8
296	144	Central Europe	France	41	nuclear	wind	hydro	2022-02-21 00:00:08.457292	f	\N	38933	14062	5472	62	22	9
297	145	Southern Europe	Portugal	187	wind	gas	biomass	2022-02-21 06:00:07.267974	f	\N	1542	572	397	60	22	15
298	145	Southern Europe	Italy	326	gas	wind	coal	2022-02-21 06:00:07.267974	f	\N	7785	4158	2151	43	23	12
299	146	Southern Europe	Italy	326	gas	wind	coal	2022-02-21 06:00:09.548652	f	\N	7785	4158	2151	43	23	12
300	146	Southern Europe	Spain	174	wind	nuclear	gas	2022-02-21 06:00:09.548652	f	\N	7195	7101	6639	30	30	28
301	147	Southern Europe	Italy	326	gas	wind	coal	2022-02-21 06:00:11.985065	f	\N	7785	4158	2151	43	23	12
302	147	Southern Europe	Portugal	187	wind	gas	biomass	2022-02-21 06:00:11.985065	f	\N	1542	572	397	60	22	15
303	148	Northern Europe	Sweden	41	hydro	nuclear	wind	2022-02-21 06:00:13.201632	f	\N	9809	5587	5234	43	25	23
304	148	Northern Europe	Denmark	108	wind	biomass	coal	2022-02-21 06:00:13.201632	f	\N	5186	558	458	81	9	7
305	149	Central Europe	UK	122	wind	nuclear	gas	2022-02-21 06:00:13.826325	f	\N	10843	4768	2964	51	23	14
306	149	Central Europe	Germany	167	wind	coal	biomass	2022-02-21 06:00:13.826325	f	\N	43810	8892	5211	65	13	8
307	150	Southern Europe	Spain	175	wind	nuclear	gas	2022-02-21 07:14:49.624355	f	\N	7475	7100	6978	30	29	28
308	150	Southern Europe	Portugal	186	wind	gas	biomass	2022-02-21 07:14:49.624355	f	\N	1578	730	399	55	25	14
309	151	Northern Europe	Denmark	112	wind	biomass	coal	2022-02-21 07:14:51.315164	f	\N	5493	626	488	80	9	7
310	151	Northern Europe	Norway	41	hydro	wind	hydro_discharge	2022-02-21 07:14:51.315164	f	\N	13019	2151	243	84	14	2
311	152	Central Europe	France	47	nuclear	wind	hydro	2022-02-21 07:14:51.935835	f	\N	41057	13176	6948	62	20	11
312	152	Central Europe	UK	124	wind	nuclear	gas	2022-02-21 07:14:51.935835	f	\N	11625	4764	3230	52	21	14
313	153	Southern Europe	Portugal	186	wind	gas	biomass	2022-02-21 07:15:31.458504	f	\N	1578	730	399	55	25	14
314	153	Southern Europe	Italy	334	gas	wind	coal	2022-02-21 07:15:31.458504	f	\N	8694	4478	2343	44	23	12
315	154	Northern Europe	Finland	186	nuclear	hydro	coal	2022-02-21 07:15:32.321435	f	\N	2799	1942	1305	36	25	17
316	154	Northern Europe	Denmark	112	wind	biomass	coal	2022-02-21 07:15:32.321435	f	\N	5493	626	488	80	9	7
317	155	Central Europe	France	47	nuclear	wind	hydro	2022-02-21 07:15:32.918397	f	\N	41057	13176	6948	62	20	11
318	155	Central Europe	Germany	171	wind	coal	biomass	2022-02-21 07:15:32.918397	f	\N	46118	9656	5218	65	14	7
319	156	Southern Europe	Italy	294	gas	solar	wind	2022-02-21 12:00:06.985827	f	\N	16402	6580	6184	43	17	16
320	156	Southern Europe	Spain	135	solar	wind	nuclear	2022-02-21 12:00:06.985827	f	\N	9347	7234	7095	28	22	21
321	157	Northern Europe	Sweden	45	hydro	nuclear	wind	2022-02-21 12:00:08.626768	f	\N	10462	5580	5448	44	24	23
322	157	Northern Europe	Norway	40	hydro	wind	hydro_discharge	2022-02-21 12:00:08.626768	f	\N	17238	2287	382	86	11	2
323	158	Central Europe	Germany	170	wind	solar	coal	2022-02-21 12:00:09.256536	f	\N	44946	10992	10730	54	13	13
324	158	Central Europe	UK	199	wind	gas	nuclear	2022-02-21 12:00:09.256536	f	\N	12497	8420	4778	38	26	15
325	159	Southern Europe	Portugal	177	gas	solar	wind	2022-02-21 18:00:07.83138	f	\N	1252	738	576	41	24	19
326	159	Southern Europe	Italy	334	gas	wind	coal	2022-02-21 18:00:07.83138	f	\N	17972	6902	3121	50	19	9
327	160	Southern Europe	Spain	121	solar	wind	nuclear	2022-02-21 18:00:10.198507	f	\N	10599	8675	7085	31	25	20
328	160	Southern Europe	Italy	334	gas	wind	coal	2022-02-21 18:00:10.198507	f	\N	17972	6902	3121	50	19	9
329	161	Southern Europe	Italy	334	gas	wind	coal	2022-02-21 18:00:13.307457	f	\N	17972	6902	3121	50	19	9
330	161	Southern Europe	Portugal	177	gas	solar	wind	2022-02-21 18:00:13.307457	f	\N	1252	738	576	41	24	19
331	162	Southern Europe	Italy	334	gas	wind	coal	2022-02-21 18:00:15.615086	f	\N	17972	6902	3121	50	19	9
332	162	Southern Europe	Spain	121	solar	wind	nuclear	2022-02-21 18:00:15.615086	f	\N	10599	8675	7085	31	25	20
333	163	Southern Europe	Italy	334	gas	wind	coal	2022-02-21 18:00:17.510051	f	\N	17972	6902	3121	50	19	9
334	163	Southern Europe	Portugal	177	gas	solar	wind	2022-02-21 18:00:17.510051	f	\N	1252	738	576	41	24	19
335	164	Southern Europe	Spain	121	solar	wind	nuclear	2022-02-21 18:01:21.465109	f	\N	10599	8675	7085	31	25	20
336	164	Southern Europe	Italy	334	gas	wind	coal	2022-02-21 18:01:21.465109	f	\N	17972	6902	3121	50	19	9
337	165	Northern Europe	Sweden	42	hydro	wind	nuclear	2022-02-21 18:01:22.166622	f	\N	10665	6206	5580	43	25	23
338	165	Northern Europe	Finland	183	nuclear	hydro	coal	2022-02-21 18:01:22.166622	f	\N	2799	2176	1414	32	25	16
339	166	Central Europe	UK	177	wind	gas	nuclear	2022-02-21 18:01:22.840083	f	\N	12783	7949	4793	39	24	15
340	166	Central Europe	France	54	nuclear	wind	hydro	2022-02-21 18:01:22.840083	f	\N	42527	14015	5935	61	20	8
341	167	Southern Europe	Spain	121	solar	wind	nuclear	2022-02-21 18:30:29.207891	f	\N	10599	8675	7085	31	25	20
342	167	Southern Europe	Portugal	177	gas	solar	wind	2022-02-21 18:30:29.207891	f	\N	1252	738	576	41	24	19
343	168	Northern Europe	Denmark	136	wind	coal	biomass	2022-02-21 18:30:30.946425	f	\N	5053	629	574	75	9	8
344	168	Northern Europe	Norway	30	hydro	wind	hydro_discharge	2022-02-21 18:30:30.946425	f	\N	18858	2001	395	88	9	2
345	169	Central Europe	Germany	212	wind	coal	biomass	2022-02-21 18:30:31.594552	f	\N	41903	13462	5316	56	18	7
346	169	Central Europe	UK	177	wind	gas	nuclear	2022-02-21 18:30:31.594552	f	\N	12783	7949	4793	39	24	15
347	170	Southern Europe	Italy	353	gas	wind	coal	2022-02-21 19:50:16.098788	f	\N	19175	6648	3053	54	19	9
348	170	Southern Europe	Spain	167	wind	gas	nuclear	2022-02-21 19:50:16.098788	f	\N	9208	8090	7089	30	26	23
349	171	Northern Europe	Norway	32	hydro	wind	hydro_discharge	2022-02-21 19:50:17.575461	f	\N	19750	1937	402	89	9	2
350	171	Northern Europe	Sweden	42	hydro	wind	nuclear	2022-02-21 19:50:17.575461	f	\N	10622	6141	5586	43	25	23
351	172	Central Europe	France	66	nuclear	wind	hydro	2022-02-21 19:50:18.452957	f	\N	42765	12628	7670	59	18	11
352	172	Central Europe	Germany	212	wind	coal	biomass	2022-02-21 19:50:18.452957	f	\N	41903	13462	5316	56	18	7
353	173	Southern Europe	Portugal	186	wind	gas	biomass	2022-02-22 00:00:07.431653	f	\N	1844	1246	406	44	29	10
354	173	Southern Europe	Spain	173	wind	gas	nuclear	2022-02-22 00:00:07.431653	f	\N	10074	8666	7099	33	28	23
355	174	Southern Europe	Spain	173	wind	gas	nuclear	2022-02-22 00:00:09.528515	f	\N	10074	8666	7099	33	28	23
356	174	Southern Europe	Italy	380	gas	wind	coal	2022-02-22 00:00:09.528515	f	\N	15648	5950	3409	52	20	11
357	175	Northern Europe	Sweden	40	hydro	wind	nuclear	2022-02-22 00:00:10.179873	f	\N	9791	5679	5586	43	25	24
358	175	Northern Europe	Finland	168	nuclear	hydro	wind	2022-02-22 00:00:10.179873	f	\N	2799	1209	1187	38	17	16
359	176	Central Europe	UK	288	gas	wind	nuclear	2022-02-22 00:00:12.068097	f	\N	13455	5558	4712	46	19	16
360	176	Central Europe	France	61	nuclear	wind	hydro	2022-02-22 00:00:12.068097	f	\N	42612	9240	7332	64	14	11
361	177	Southern Europe	Portugal	169	wind	gas	biomass	2022-02-22 06:00:05.744995	f	\N	2588	1099	404	60	26	9
362	177	Southern Europe	Italy	290	gas	wind	coal	2022-02-22 06:00:05.744995	f	\N	8220	6230	2238	39	30	11
363	178	Northern Europe	Finland	193	nuclear	hydro	coal	2022-02-22 06:00:06.624469	f	\N	2799	1702	1313	35	21	16
364	178	Northern Europe	Denmark	168	wind	biomass	coal	2022-02-22 06:00:06.624469	f	\N	2513	730	505	63	18	13
365	179	Central Europe	Germany	243	wind	coal	biomass	2022-02-22 06:00:07.325428	f	\N	37003	14729	5179	55	22	8
366	179	Central Europe	France	70	nuclear	hydro	wind	2022-02-22 06:00:07.325428	f	\N	42463	5989	5381	70	10	9
367	180	Southern Europe	Italy	289	gas	solar	wind	2022-02-22 12:00:05.899389	f	\N	15111	7154	6565	40	19	17
368	180	Southern Europe	Spain	153	solar	gas	nuclear	2022-02-22 12:00:05.899389	f	\N	10241	7258	7096	30	21	21
369	181	Southern Europe	Portugal	225	gas	wind	solar	2022-02-22 12:00:07.772528	f	\N	1607	1018	948	40	25	24
370	181	Southern Europe	Italy	289	gas	solar	wind	2022-02-22 12:00:07.772528	f	\N	15111	7154	6565	40	19	17
371	182	Northern Europe	Norway	28	hydro	wind	hydro_discharge	2022-02-22 12:00:09.257904	f	\N	24326	1146	486	93	4	2
372	182	Northern Europe	Finland	220	nuclear	hydro	coal	2022-02-22 12:00:09.257904	f	\N	2799	2031	1561	34	24	19
373	183	Central Europe	Germany	281	wind	coal	solar	2022-02-22 12:00:09.912213	f	\N	28198	19342	12283	36	24	15
374	183	Central Europe	UK	180	wind	gas	nuclear	2022-02-22 12:00:09.912213	f	\N	13373	6961	4700	41	21	14
375	184	Southern Europe	Italy	308	gas	wind	solar	2022-02-22 18:00:07.00255	f	\N	15619	7090	2716	46	21	8
376	184	Southern Europe	Spain	135	solar	nuclear	wind	2022-02-22 18:00:07.00255	f	\N	10683	7088	6754	31	21	20
377	185	Northern Europe	Sweden	59	hydro	nuclear	unknown	2022-02-22 18:00:07.936314	f	\N	12394	5576	2278	59	26	11
378	185	Northern Europe	Denmark	176	wind	biomass	coal	2022-02-22 18:00:07.936314	f	\N	3617	793	677	64	14	12
379	186	Central Europe	UK	159	wind	gas	nuclear	2022-02-22 18:00:08.767372	f	\N	12825	5950	4681	42	19	15
380	186	Central Europe	France	66	nuclear	wind	hydro	2022-02-22 18:00:08.767372	f	\N	43475	10175	5549	64	15	8
381	187	Southern Europe	Portugal	214	wind	gas	biomass	2022-02-23 00:00:05.605087	f	\N	1539	1410	400	42	38	11
382	187	Southern Europe	Spain	197	gas	wind	nuclear	2022-02-23 00:00:05.605087	f	\N	10248	7980	7103	33	26	23
383	188	Northern Europe	Sweden	57	hydro	nuclear	wind	2022-02-23 00:00:07.280175	f	\N	11399	5584	2714	52	26	12
384	188	Northern Europe	Norway	41	hydro	wind	hydro_discharge	2022-02-23 00:00:07.280175	f	\N	16385	2474	379	84	13	2
385	189	Central Europe	France	85	nuclear	hydro	wind	2022-02-23 00:00:07.97425	f	\N	43710	6725	6557	65	10	10
386	189	Central Europe	Germany	224	wind	coal	biomass	2022-02-23 00:00:07.97425	f	\N	43228	14998	5272	59	20	7
387	190	Southern Europe	Spain	202	gas	nuclear	wind	2022-02-23 06:00:05.940711	f	\N	8116	7102	6029	33	29	25
388	190	Southern Europe	Italy	328	gas	wind	coal	2022-02-23 06:00:05.940711	f	\N	9528	5211	2499	45	24	12
389	191	Northern Europe	Sweden	44	hydro	nuclear	wind	2022-02-23 06:00:06.656746	f	\N	10951	5582	4028	48	25	18
390	191	Northern Europe	Finland	217	nuclear	hydro	coal	2022-02-23 06:00:06.656746	f	\N	2797	1969	1522	37	26	20
391	192	Central Europe	UK	149	wind	nuclear	gas	2022-02-23 06:00:07.297559	f	\N	9851	4699	3284	43	21	14
392	192	Central Europe	Germany	287	wind	coal	biomass	2022-02-23 06:00:07.297559	f	\N	33028	18153	5175	49	27	8
393	193	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:00:08.509224	f	\N	2261	1050	869	48	22	19
394	193	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:00:08.509224	f	\N	13984	8829	5478	37	23	14
395	194	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:00:09.36152	f	\N	10243	7100	6977	32	23	22
396	194	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:00:09.36152	f	\N	2261	1050	869	48	22	19
397	195	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:00:11.533215	f	\N	10243	7100	6977	32	23	22
398	195	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:00:11.533215	f	\N	13984	8829	5478	37	23	14
399	196	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:00:12.666527	f	\N	2261	1050	869	48	22	19
400	196	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:00:12.666527	f	\N	10243	7100	6977	32	23	22
401	197	Northern Europe	Sweden	52	hydro	nuclear	wind	2022-02-23 12:00:13.522572	f	\N	10960	5582	4290	48	24	19
402	197	Northern Europe	Denmark	183	wind	biomass	coal	2022-02-23 12:00:13.522572	f	\N	3880	757	610	63	12	10
403	198	Central Europe	France	89	nuclear	hydro	gas	2022-02-23 12:00:14.161255	f	\N	43816	6577	6235	66	10	9
404	198	Central Europe	Germany	257	wind	solar	coal	2022-02-23 12:00:14.161255	f	\N	24550	22323	18504	30	27	23
405	199	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:15:45.973931	f	\N	10243	7100	6977	32	23	22
406	199	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:15:45.973931	f	\N	13984	8829	5478	37	23	14
407	200	Northern Europe	Sweden	52	hydro	nuclear	wind	2022-02-23 12:15:47.204548	f	\N	10960	5582	4290	48	24	19
408	200	Northern Europe	Norway	40	hydro	wind	hydro_discharge	2022-02-23 12:15:47.204548	f	\N	18403	2718	349	85	13	2
409	201	Central Europe	France	89	nuclear	hydro	gas	2022-02-23 12:15:47.602578	f	\N	43816	6577	6235	66	10	9
410	201	Central Europe	UK	201	wind	gas	nuclear	2022-02-23 12:15:47.602578	f	\N	11958	7697	4759	36	23	14
411	202	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:15:55.261775	f	\N	10243	7100	6977	32	23	22
412	202	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:15:55.261775	f	\N	2261	1050	869	48	22	19
413	203	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:15:57.165863	f	\N	13984	8829	5478	37	23	14
414	203	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:15:57.165863	f	\N	2261	1050	869	48	22	19
415	204	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:15:59.019259	f	\N	13984	8829	5478	37	23	14
416	204	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:15:59.019259	f	\N	10243	7100	6977	32	23	22
417	205	Northern Europe	Sweden	52	hydro	nuclear	wind	2022-02-23 12:15:59.578806	f	\N	10960	5582	4290	48	24	19
418	205	Northern Europe	Denmark	183	wind	biomass	coal	2022-02-23 12:15:59.578806	f	\N	3880	757	610	63	12	10
419	206	Central Europe	France	89	nuclear	hydro	gas	2022-02-23 12:15:59.990892	f	\N	43816	6577	6235	66	10	9
420	206	Central Europe	Germany	257	wind	solar	coal	2022-02-23 12:15:59.990892	f	\N	24550	22323	18504	30	27	23
421	207	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:17:11.275021	f	\N	2261	1050	869	48	22	19
422	207	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:17:11.275021	f	\N	13984	8829	5478	37	23	14
423	208	Northern Europe	Sweden	52	hydro	nuclear	wind	2022-02-23 12:17:11.702614	f	\N	10960	5582	4290	48	24	19
424	208	Northern Europe	Finland	205	nuclear	hydro	coal	2022-02-23 12:17:11.702614	f	\N	2797	2154	1534	34	27	19
425	209	Central Europe	France	89	nuclear	hydro	gas	2022-02-23 12:17:12.105126	f	\N	43816	6577	6235	66	10	9
426	209	Central Europe	UK	201	wind	gas	nuclear	2022-02-23 12:17:12.105126	f	\N	11958	7697	4759	36	23	14
427	210	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:17:19.66228	f	\N	2261	1050	869	48	22	19
428	210	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:17:19.66228	f	\N	10243	7100	6977	32	23	22
429	211	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:17:22.850016	f	\N	13984	8829	5478	37	23	14
430	211	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:17:22.850016	f	\N	2261	1050	869	48	22	19
431	212	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:17:24.694906	f	\N	13984	8829	5478	37	23	14
432	212	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:17:24.694906	f	\N	10243	7100	6977	32	23	22
433	213	Northern Europe	Sweden	52	hydro	nuclear	wind	2022-02-23 12:17:25.721275	f	\N	10960	5582	4290	48	24	19
434	213	Northern Europe	Denmark	183	wind	biomass	coal	2022-02-23 12:17:25.721275	f	\N	3880	757	610	63	12	10
435	214	Central Europe	Germany	257	wind	solar	coal	2022-02-23 12:17:26.112436	f	\N	24550	22323	18504	30	27	23
436	214	Central Europe	France	89	nuclear	hydro	gas	2022-02-23 12:17:26.112436	f	\N	43816	6577	6235	66	10	9
437	215	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:22:29.232554	f	\N	13984	8829	5478	37	23	14
438	215	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:22:29.232554	f	\N	2261	1050	869	48	22	19
439	216	Northern Europe	Norway	40	hydro	wind	hydro_discharge	2022-02-23 12:22:30.437012	f	\N	18403	2718	349	85	13	2
440	216	Northern Europe	Finland	205	nuclear	hydro	coal	2022-02-23 12:22:30.437012	f	\N	2797	2154	1534	34	27	19
441	217	Central Europe	Germany	257	wind	solar	coal	2022-02-23 12:22:30.849518	f	\N	24550	22323	18504	30	27	23
442	217	Central Europe	UK	201	wind	gas	nuclear	2022-02-23 12:22:30.849518	f	\N	11958	7697	4759	36	23	14
443	218	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:22:43.457676	f	\N	10243	7100	6977	32	23	22
444	218	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:22:43.457676	f	\N	13984	8829	5478	37	23	14
445	219	Northern Europe	Finland	205	nuclear	hydro	coal	2022-02-23 12:22:43.900545	f	\N	2797	2154	1534	34	27	19
446	219	Northern Europe	Sweden	52	hydro	nuclear	wind	2022-02-23 12:22:43.900545	f	\N	10960	5582	4290	48	24	19
447	220	Central Europe	Germany	257	wind	solar	coal	2022-02-23 12:22:44.327661	f	\N	24550	22323	18504	30	27	23
448	220	Central Europe	France	89	nuclear	hydro	gas	2022-02-23 12:22:44.327661	f	\N	43816	6577	6235	66	10	9
449	221	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:22:50.542222	f	\N	2261	1050	869	48	22	19
450	221	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:22:50.542222	f	\N	13984	8829	5478	37	23	14
451	222	Northern Europe	Denmark	183	wind	biomass	coal	2022-02-23 12:22:51.178653	f	\N	3880	757	610	63	12	10
452	222	Northern Europe	Sweden	52	hydro	nuclear	wind	2022-02-23 12:22:51.178653	f	\N	10960	5582	4290	48	24	19
453	223	Central Europe	UK	201	wind	gas	nuclear	2022-02-23 12:22:51.580744	f	\N	11958	7697	4759	36	23	14
454	223	Central Europe	Germany	257	wind	solar	coal	2022-02-23 12:22:51.580744	f	\N	24550	22323	18504	30	27	23
455	224	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:22:54.269112	f	\N	10243	7100	6977	32	23	22
456	224	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:22:54.269112	f	\N	2261	1050	869	48	22	19
457	225	Northern Europe	Denmark	183	wind	biomass	coal	2022-02-23 12:22:55.685306	f	\N	3880	757	610	63	12	10
458	225	Northern Europe	Norway	40	hydro	wind	hydro_discharge	2022-02-23 12:22:55.685306	f	\N	18403	2718	349	85	13	2
459	226	Central Europe	Germany	257	wind	solar	coal	2022-02-23 12:22:56.099684	f	\N	24550	22323	18504	30	27	23
460	226	Central Europe	France	89	nuclear	hydro	gas	2022-02-23 12:22:56.099684	f	\N	43816	6577	6235	66	10	9
461	227	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:23:02.246299	f	\N	10243	7100	6977	32	23	22
462	227	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:23:02.246299	f	\N	13984	8829	5478	37	23	14
463	228	Northern Europe	Norway	40	hydro	wind	hydro_discharge	2022-02-23 12:23:03.506192	f	\N	18403	2718	349	85	13	2
464	228	Northern Europe	Sweden	52	hydro	nuclear	wind	2022-02-23 12:23:03.506192	f	\N	10960	5582	4290	48	24	19
465	229	Central Europe	UK	201	wind	gas	nuclear	2022-02-23 12:23:03.934491	f	\N	11958	7697	4759	36	23	14
466	229	Central Europe	Germany	257	wind	solar	coal	2022-02-23 12:23:03.934491	f	\N	24550	22323	18504	30	27	23
467	230	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:23:13.980372	f	\N	2261	1050	869	48	22	19
468	230	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:23:13.980372	f	\N	13984	8829	5478	37	23	14
469	231	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:23:17.199026	f	\N	10243	7100	6977	32	23	22
470	231	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:23:17.199026	f	\N	13984	8829	5478	37	23	14
471	232	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:23:18.950273	f	\N	2261	1050	869	48	22	19
472	232	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:23:18.950273	f	\N	10243	7100	6977	32	23	22
473	233	Southern Europe	Italy	268	gas	solar	wind	2022-02-23 12:23:20.764431	f	\N	13984	8829	5478	37	23	14
474	233	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:23:20.764431	f	\N	10243	7100	6977	32	23	22
475	234	Northern Europe	Sweden	52	hydro	nuclear	wind	2022-02-23 12:23:21.545451	f	\N	10960	5582	4290	48	24	19
476	234	Northern Europe	Finland	205	nuclear	hydro	coal	2022-02-23 12:23:21.545451	f	\N	2797	2154	1534	34	27	19
477	235	Central Europe	UK	201	wind	gas	nuclear	2022-02-23 12:23:21.961877	f	\N	11958	7697	4759	36	23	14
478	235	Central Europe	France	89	nuclear	hydro	gas	2022-02-23 12:23:21.961877	f	\N	43816	6577	6235	66	10	9
479	236	Southern Europe	Spain	199	gas	nuclear	solar	2022-02-23 12:25:58.265084	f	\N	10243	7100	6977	32	23	22
480	236	Southern Europe	Portugal	273	gas	wind	solar	2022-02-23 12:25:58.265084	f	\N	2261	1050	869	48	22	19
481	237	Northern Europe	Sweden	52	hydro	nuclear	wind	2022-02-23 12:25:59.526235	f	\N	10960	5582	4290	48	24	19
482	237	Northern Europe	Norway	40	hydro	wind	hydro_discharge	2022-02-23 12:25:59.526235	f	\N	18403	2718	349	85	13	2
483	238	Central Europe	Germany	257	wind	solar	coal	2022-02-23 12:25:59.94475	f	\N	24550	22323	18504	30	27	23
484	238	Central Europe	France	89	nuclear	hydro	gas	2022-02-23 12:25:59.94475	f	\N	43816	6577	6235	66	10	9
\.


--
-- Data for Name: zone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.zone (zone_id, zone_name, country, emoji, last_query_dt, last_publish_dt, division, probability) FROM stdin;
GB	UK	UK	\N	\N	\N	Central Europe	0.295342706502636
FR	France	France	\N	\N	\N	Central Europe	0.296089630931459
DE	Germany	Germany	\N	\N	\N	Central Europe	0.36572934973638
HU	Hungary	Hungary	\N	\N	\N	Central Europe	0.042838312829526
FI	Finland	Finland	\N	\N	\N	Northern Europe	0.204134366925065
SE	Sweden	Sweden	\N	\N	\N	Northern Europe	0.382059800664452
NO-NO1	Norway-1	Norway	\N	\N	\N	Northern Europe	0.19859726836471
NO-NO2	Norway-2	Norway	\N	\N	\N	Northern Europe	0.19859726836471
NO-NO3	Norway-3	Norway	\N	\N	\N	Northern Europe	0.19859726836471
NO-NO4	Norway-4	Norway	\N	\N	\N	Northern Europe	0.19859726836471
NO-NO5	Norway-5	Norway	\N	\N	\N	Northern Europe	0.19859726836471
DK-DK1	Danemark-1	Denmark	\N	\N	\N	Northern Europe	0.215208564045773
DK-DK2	Danemark-2	Denmark	\N	\N	\N	Northern Europe	0.215208564045773
IT-CNO	Italy-Central-North	Italy	\N	\N	\N	Southern Europe	0.46548893926366
IT-CSO	Italy-Central-South	Italy	\N	\N	\N	Southern Europe	0.46548893926366
IT-NO	Italy-North	Italy	\N	\N	\N	Southern Europe	0.46548893926366
IT-SAR	Italy-Sardinia	Italy	\N	\N	\N	Southern Europe	0.46548893926366
IT-SIC	Italy-Sicily	Italy	\N	\N	\N	Southern Europe	0.46548893926366
IT-SO	Italy-South	Italy	\N	\N	\N	Southern Europe	0.46548893926366
PT	Portugal	Portugal	\N	\N	\N	Southern Europe	0.080590948174783
ES	Spain	Spain	\N	\N	\N	Southern Europe	0.3701242867193
GR	Greece	Greece	\N	\N	\N	Southern Europe	0.083795825842258
\.


--
-- Name: data_fetched_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.data_fetched_id_seq', 484, true);


--
-- Name: zone zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zone
    ADD CONSTRAINT zone_pkey PRIMARY KEY (zone_id);


--
-- PostgreSQL database dump complete
--

