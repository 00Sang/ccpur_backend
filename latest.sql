PGDMP      :                }            ccpur_college    17.2    17.2 K    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16786    ccpur_college    DATABASE     �   CREATE DATABASE ccpur_college WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
    DROP DATABASE ccpur_college;
                     postgres    false            �            1259    17303    alumini_semester_records    TABLE     ?  CREATE TABLE public.alumini_semester_records (
    history_id uuid DEFAULT gen_random_uuid() NOT NULL,
    student_id uuid NOT NULL,
    semester_id integer NOT NULL,
    semester_name character varying(50),
    course_name character varying(100),
    grade character(2),
    recorded_at timestamp without time zone
);
 ,   DROP TABLE public.alumini_semester_records;
       public         heap r       postgres    false            �            1259    17090 
   attendance    TABLE     j  CREATE TABLE public.attendance (
    attendance_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    student_id uuid,
    date date NOT NULL,
    subject_code character varying(50),
    status character varying(150),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.attendance;
       public         heap r       postgres    false            �            1259    16990 
   department    TABLE       CREATE TABLE public.department (
    department_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    department_name character varying(255) NOT NULL,
    department_code character varying(50),
    head_of_department uuid,
    number_of_faculty integer
);
    DROP TABLE public.department;
       public         heap r       postgres    false            �            1259    16981    faculty    TABLE       CREATE TABLE public.faculty (
    faculty_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(150) NOT NULL,
    department character varying(100),
    designation character varying(255),
    nature_of_appointment character varying(200),
    role character varying(100) DEFAULT 'staff'::character varying NOT NULL,
    type character varying(100),
    phone_number character varying(20),
    profile_picture text,
    department_id uuid,
    password character varying(300),
    email character varying(250)
);
    DROP TABLE public.faculty;
       public         heap r       postgres    false            �            1259    17192    file_uploads    TABLE     �  CREATE TABLE public.file_uploads (
    file_id uuid DEFAULT gen_random_uuid() NOT NULL,
    student_id uuid,
    applicant_id uuid,
    faculty_id uuid,
    user_id uuid,
    uploaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    passport_path character varying(255),
    signature_path character varying(255),
    CONSTRAINT file_uploads_check CHECK (((student_id IS NOT NULL) OR (applicant_id IS NOT NULL) OR (faculty_id IS NOT NULL) OR (user_id IS NOT NULL)))
);
     DROP TABLE public.file_uploads;
       public         heap r       postgres    false            �            1259    17103    library    TABLE     �  CREATE TABLE public.library (
    borrow_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    student_id uuid,
    book_id character varying(50) NOT NULL,
    book_title character varying(255) NOT NULL,
    borrow_date date NOT NULL,
    return_date date,
    due_date date NOT NULL,
    fine numeric(5,2) DEFAULT 0.00,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.library;
       public         heap r       postgres    false            �            1259    16918    new_applications    TABLE     �  CREATE TABLE public.new_applications (
    application_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    session character varying(50),
    full_name character varying(100),
    date_of_birth date,
    aadhaar_no character varying(12) NOT NULL,
    sex character varying(10),
    category character varying(50),
    nationality character varying(50),
    religion character varying(50),
    name_of_community character varying(50),
    contact_no character varying(15),
    blood_group character varying(5),
    email character varying(100),
    fathers_name character varying(100),
    fathers_occupation character varying(100),
    mothers_name character varying(100),
    mothers_occupation character varying(100),
    permanent_address text,
    present_address text,
    guardian_name character varying(100),
    guardian_address text,
    hslc_board character varying(50),
    hslc_rollno character varying(20),
    hslc_year integer,
    hslc_div character varying(10),
    hslc_tmarks integer,
    hslc_inst character varying(100),
    classxii_board character varying(50),
    classxii_rollno character varying(20),
    classxii_year integer,
    classxii_div character varying(10),
    classxii_tmarks integer,
    classxii_inst character varying(100),
    course character varying(100),
    mil character varying(50),
    subject character varying(100),
    user_id uuid,
    status character varying(20) DEFAULT 'pending'::character varying,
    agree boolean DEFAULT false,
    pincode character varying(10)
);
 $   DROP TABLE public.new_applications;
       public         heap r       postgres    false            �            1259    17056    payments    TABLE     �  CREATE TABLE public.payments (
    payment_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    student_id uuid,
    application_id uuid,
    amount numeric(10,2) NOT NULL,
    payment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    payment_method character varying(50),
    payment_status character varying(50) DEFAULT 'Pending'::character varying,
    transaction_id character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT payments_check CHECK ((((student_id IS NOT NULL) AND (application_id IS NULL)) OR ((application_id IS NOT NULL) AND (student_id IS NULL))))
);
    DROP TABLE public.payments;
       public         heap r       postgres    false            �            1259    17077    results    TABLE     n  CREATE TABLE public.results (
    result_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    student_id uuid,
    exam_id character varying(50) NOT NULL,
    subject_code character varying(50),
    marks_obtained numeric(5,2),
    total_marks numeric(5,2),
    grade character varying(5),
    result_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.results;
       public         heap r       postgres    false            �            1259    17276    semester_records    TABLE     9  CREATE TABLE public.semester_records (
    record_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    student_id uuid,
    semester_id integer,
    course_name character varying(100),
    grade character(2),
    marks_obtained integer,
    recorded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 $   DROP TABLE public.semester_records;
       public         heap r       postgres    false            �            1259    17263 	   semesters    TABLE     v   CREATE TABLE public.semesters (
    semester_id integer NOT NULL,
    semester_name character varying(20) NOT NULL
);
    DROP TABLE public.semesters;
       public         heap r       postgres    false            �            1259    17262    semesters_semester_id_seq    SEQUENCE     �   CREATE SEQUENCE public.semesters_semester_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.semesters_semester_id_seq;
       public               postgres    false    230            �           0    0    semesters_semester_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.semesters_semester_id_seq OWNED BY public.semesters.semester_id;
          public               postgres    false    229            �            1259    16899    student_details    TABLE     #  CREATE TABLE public.student_details (
    student_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    session character varying(50),
    full_name character varying(100),
    date_of_birth date,
    aadhaar_no character varying(12),
    sex character varying(10),
    category character varying(50),
    nationality character varying(50),
    religion character varying(50),
    name_of_community character varying(50),
    contact_no character varying(15),
    blood_group character varying(5),
    email character varying(100),
    fathers_name character varying(100),
    fathers_occupation character varying(100),
    mothers_name character varying(100),
    mothers_occupation character varying(100),
    permanent_address text,
    present_address text,
    guardian_name character varying(100),
    guardian_address text,
    hslc_board character varying(50),
    hslc_rollno character varying(20),
    hslc_year integer,
    hslc_div character varying(10),
    hslc_tmarks integer,
    hslc_inst character varying(100),
    classxii_board character varying(50),
    classxii_rollno character varying(20),
    classxii_year integer,
    classxii_div character varying(10),
    classxii_tmarks integer,
    classxii_inst character varying(100),
    course character varying(100),
    mil character varying(50),
    subject character varying(100),
    exampassed1 character varying(50),
    exampassed2 character varying(50),
    exampassed3 character varying(50),
    exampassed4 character varying(50),
    exampassed5 character varying(50),
    exampassed6 character varying(50),
    board1 character varying(25),
    board2 character varying(25),
    board3 character varying(25),
    board4 character varying(25),
    board5 character varying(25),
    board6 character varying(25),
    year1 integer,
    year2 integer,
    year3 integer,
    year4 integer,
    year5 integer,
    year6 integer,
    roll_no1 integer,
    roll_no2 integer,
    roll_no3 integer,
    roll_no4 integer,
    roll_no5 integer,
    roll_no6 integer,
    division1 character varying(10),
    division2 character varying(10),
    division3 character varying(10),
    division4 character varying(10),
    division5 character varying(10),
    division6 character varying(10),
    subject_taken1 character varying(250),
    subject_taken2 character varying(250),
    subject_taken3 character varying(250),
    subject_taken4 character varying(250),
    subject_taken5 character varying(250),
    subject_taken6 character varying(250),
    abc_id character varying(50),
    registration_no character varying(100),
    course_code character varying(50),
    current_semester character varying(50),
    roll_no character varying(20),
    user_id uuid,
    agree boolean,
    admission_date date DEFAULT CURRENT_TIMESTAMP,
    pincode integer,
    graduated boolean
);
 #   DROP TABLE public.student_details;
       public         heap r       postgres    false            �            1259    17117    student_examinations    TABLE     l	  CREATE TABLE public.student_examinations (
    examination_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    student_id uuid,
    application_for character varying(100),
    examination_session character varying(50),
    abc_id character varying(50),
    registration_no character varying(100),
    of_year character varying(50),
    roll_no character varying(50),
    dept_code character varying(50),
    fathers_name character varying(255),
    guardian_name character varying(255),
    permanent_address text,
    course_code character varying(50),
    year_semester character varying(50),
    sex character varying(10),
    category character varying(50),
    papercode_a character varying(50),
    paperno_a character varying(50),
    papercode_b character varying(50),
    paperno_b character varying(50),
    papercode_c character varying(50),
    paperno_c character varying(50),
    papercode_d character varying(50),
    paperno_d character varying(50),
    papercode_e character varying(50),
    paperno_e character varying(50),
    papercode_f character varying(50),
    paperno_f character varying(50),
    papercode_g character varying(50),
    paperno_g character varying(50),
    papercode_h character varying(50),
    paperno_h character varying(50),
    papercode_i character varying(50),
    paperno_i character varying(50),
    papercode_j character varying(50),
    paperno_j character varying(50),
    exampassed1 character varying(100),
    board1 character varying(100),
    year1 character varying(10),
    roll_no1 character varying(50),
    division1 character varying(50),
    subject_taken1 text,
    exampassed2 character varying(100),
    board2 character varying(100),
    year2 character varying(10),
    roll_no2 character varying(50),
    division2 character varying(50),
    subject_taken2 text,
    exampassed3 character varying(100),
    board3 character varying(100),
    year3 character varying(10),
    roll_no3 character varying(50),
    division3 character varying(50),
    subject_taken3 text,
    exampassed4 character varying(100),
    board4 character varying(100),
    year4 character varying(10),
    roll_no4 character varying(50),
    division4 character varying(50),
    subject_taken4 text,
    debarred_exam_name character varying(200),
    debarred_year integer,
    debarred_rollno character varying(80),
    debarred_board character varying(100)
);
 (   DROP TABLE public.student_examinations;
       public         heap r       postgres    false            �            1259    16839    users    TABLE     P  CREATE TABLE public.users (
    name character varying(300) NOT NULL,
    email character varying(200) NOT NULL,
    program character varying(150),
    password character varying(250) NOT NULL,
    role character varying(50) DEFAULT 'student'::character varying NOT NULL,
    user_id uuid DEFAULT public.uuid_generate_v4() NOT NULL
);
    DROP TABLE public.users;
       public         heap r       postgres    false            �           2604    17266    semesters semester_id    DEFAULT     ~   ALTER TABLE ONLY public.semesters ALTER COLUMN semester_id SET DEFAULT nextval('public.semesters_semester_id_seq'::regclass);
 D   ALTER TABLE public.semesters ALTER COLUMN semester_id DROP DEFAULT;
       public               postgres    false    229    230    230            �          0    17303    alumini_semester_records 
   TABLE DATA           �   COPY public.alumini_semester_records (history_id, student_id, semester_id, semester_name, course_name, grade, recorded_at) FROM stdin;
    public               postgres    false    232   ��                 0    17090 
   attendance 
   TABLE DATA           s   COPY public.attendance (attendance_id, student_id, date, subject_code, status, created_at, updated_at) FROM stdin;
    public               postgres    false    225   Ӑ       |          0    16990 
   department 
   TABLE DATA           |   COPY public.department (department_id, department_name, department_code, head_of_department, number_of_faculty) FROM stdin;
    public               postgres    false    222   �       {          0    16981    faculty 
   TABLE DATA           �   COPY public.faculty (faculty_id, name, department, designation, nature_of_appointment, role, type, phone_number, profile_picture, department_id, password, email) FROM stdin;
    public               postgres    false    221   ��       �          0    17192    file_uploads 
   TABLE DATA           �   COPY public.file_uploads (file_id, student_id, applicant_id, faculty_id, user_id, uploaded_at, passport_path, signature_path) FROM stdin;
    public               postgres    false    228   $�       �          0    17103    library 
   TABLE DATA           �   COPY public.library (borrow_id, student_id, book_id, book_title, borrow_date, return_date, due_date, fine, created_at, updated_at) FROM stdin;
    public               postgres    false    226   Ț       z          0    16918    new_applications 
   TABLE DATA           &  COPY public.new_applications (application_id, session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion, name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation, mothers_name, mothers_occupation, permanent_address, present_address, guardian_name, guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst, classxii_board, classxii_rollno, classxii_year, classxii_div, classxii_tmarks, classxii_inst, course, mil, subject, user_id, status, agree, pincode) FROM stdin;
    public               postgres    false    220   �       }          0    17056    payments 
   TABLE DATA           �   COPY public.payments (payment_id, student_id, application_id, amount, payment_date, payment_method, payment_status, transaction_id, created_at, updated_at) FROM stdin;
    public               postgres    false    223   ��       ~          0    17077    results 
   TABLE DATA           �   COPY public.results (result_id, student_id, exam_id, subject_code, marks_obtained, total_marks, grade, result_date) FROM stdin;
    public               postgres    false    224   ��       �          0    17276    semester_records 
   TABLE DATA              COPY public.semester_records (record_id, student_id, semester_id, course_name, grade, marks_obtained, recorded_at) FROM stdin;
    public               postgres    false    231   ݜ       �          0    17263 	   semesters 
   TABLE DATA           ?   COPY public.semesters (semester_id, semester_name) FROM stdin;
    public               postgres    false    230   ��       y          0    16899    student_details 
   TABLE DATA           �  COPY public.student_details (student_id, session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion, name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation, mothers_name, mothers_occupation, permanent_address, present_address, guardian_name, guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst, classxii_board, classxii_rollno, classxii_year, classxii_div, classxii_tmarks, classxii_inst, course, mil, subject, exampassed1, exampassed2, exampassed3, exampassed4, exampassed5, exampassed6, board1, board2, board3, board4, board5, board6, year1, year2, year3, year4, year5, year6, roll_no1, roll_no2, roll_no3, roll_no4, roll_no5, roll_no6, division1, division2, division3, division4, division5, division6, subject_taken1, subject_taken2, subject_taken3, subject_taken4, subject_taken5, subject_taken6, abc_id, registration_no, course_code, current_semester, roll_no, user_id, agree, admission_date, pincode, graduated) FROM stdin;
    public               postgres    false    219   ;�       �          0    17117    student_examinations 
   TABLE DATA           9  COPY public.student_examinations (examination_id, student_id, application_for, examination_session, abc_id, registration_no, of_year, roll_no, dept_code, fathers_name, guardian_name, permanent_address, course_code, year_semester, sex, category, papercode_a, paperno_a, papercode_b, paperno_b, papercode_c, paperno_c, papercode_d, paperno_d, papercode_e, paperno_e, papercode_f, paperno_f, papercode_g, paperno_g, papercode_h, paperno_h, papercode_i, paperno_i, papercode_j, paperno_j, exampassed1, board1, year1, roll_no1, division1, subject_taken1, exampassed2, board2, year2, roll_no2, division2, subject_taken2, exampassed3, board3, year3, roll_no3, division3, subject_taken3, exampassed4, board4, year4, roll_no4, division4, subject_taken4, debarred_exam_name, debarred_year, debarred_rollno, debarred_board) FROM stdin;
    public               postgres    false    227   ��       x          0    16839    users 
   TABLE DATA           N   COPY public.users (name, email, program, password, role, user_id) FROM stdin;
    public               postgres    false    218   Ƨ       �           0    0    semesters_semester_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.semesters_semester_id_seq', 6, true);
          public               postgres    false    229            �           2606    17308 6   alumini_semester_records alumini_semester_records_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.alumini_semester_records
    ADD CONSTRAINT alumini_semester_records_pkey PRIMARY KEY (history_id);
 `   ALTER TABLE ONLY public.alumini_semester_records DROP CONSTRAINT alumini_semester_records_pkey;
       public                 postgres    false    232            �           2606    17097    attendance attendance_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (attendance_id);
 D   ALTER TABLE ONLY public.attendance DROP CONSTRAINT attendance_pkey;
       public                 postgres    false    225            �           2606    16997 )   department department_department_code_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_department_code_key UNIQUE (department_code);
 S   ALTER TABLE ONLY public.department DROP CONSTRAINT department_department_code_key;
       public                 postgres    false    222            �           2606    16995    department department_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);
 D   ALTER TABLE ONLY public.department DROP CONSTRAINT department_pkey;
       public                 postgres    false    222            �           2606    16989    faculty faculty_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_pkey PRIMARY KEY (faculty_id);
 >   ALTER TABLE ONLY public.faculty DROP CONSTRAINT faculty_pkey;
       public                 postgres    false    221            �           2606    17201    file_uploads file_uploads_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.file_uploads
    ADD CONSTRAINT file_uploads_pkey PRIMARY KEY (file_id);
 H   ALTER TABLE ONLY public.file_uploads DROP CONSTRAINT file_uploads_pkey;
       public                 postgres    false    228            �           2606    17111    library library_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.library
    ADD CONSTRAINT library_pkey PRIMARY KEY (borrow_id);
 >   ALTER TABLE ONLY public.library DROP CONSTRAINT library_pkey;
       public                 postgres    false    226            �           2606    16928 0   new_applications new_applications_aadhaar_no_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.new_applications
    ADD CONSTRAINT new_applications_aadhaar_no_key UNIQUE (aadhaar_no);
 Z   ALTER TABLE ONLY public.new_applications DROP CONSTRAINT new_applications_aadhaar_no_key;
       public                 postgres    false    220            �           2606    16926 &   new_applications new_applications_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.new_applications
    ADD CONSTRAINT new_applications_pkey PRIMARY KEY (application_id);
 P   ALTER TABLE ONLY public.new_applications DROP CONSTRAINT new_applications_pkey;
       public                 postgres    false    220            �           2606    17066    payments payments_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);
 @   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_pkey;
       public                 postgres    false    223            �           2606    17083    results results_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_pkey PRIMARY KEY (result_id);
 >   ALTER TABLE ONLY public.results DROP CONSTRAINT results_pkey;
       public                 postgres    false    224            �           2606    17282 &   semester_records semester_records_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.semester_records
    ADD CONSTRAINT semester_records_pkey PRIMARY KEY (record_id);
 P   ALTER TABLE ONLY public.semester_records DROP CONSTRAINT semester_records_pkey;
       public                 postgres    false    231            �           2606    17268    semesters semesters_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.semesters
    ADD CONSTRAINT semesters_pkey PRIMARY KEY (semester_id);
 B   ALTER TABLE ONLY public.semesters DROP CONSTRAINT semesters_pkey;
       public                 postgres    false    230            �           2606    16908 .   student_details student_details_aadhaar_no_key 
   CONSTRAINT     o   ALTER TABLE ONLY public.student_details
    ADD CONSTRAINT student_details_aadhaar_no_key UNIQUE (aadhaar_no);
 X   ALTER TABLE ONLY public.student_details DROP CONSTRAINT student_details_aadhaar_no_key;
       public                 postgres    false    219            �           2606    16910 )   student_details student_details_email_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.student_details
    ADD CONSTRAINT student_details_email_key UNIQUE (email);
 S   ALTER TABLE ONLY public.student_details DROP CONSTRAINT student_details_email_key;
       public                 postgres    false    219            �           2606    16906 $   student_details student_details_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.student_details
    ADD CONSTRAINT student_details_pkey PRIMARY KEY (student_id);
 N   ALTER TABLE ONLY public.student_details DROP CONSTRAINT student_details_pkey;
       public                 postgres    false    219            �           2606    16912 +   student_details student_details_roll_no_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.student_details
    ADD CONSTRAINT student_details_roll_no_key UNIQUE (roll_no);
 U   ALTER TABLE ONLY public.student_details DROP CONSTRAINT student_details_roll_no_key;
       public                 postgres    false    219            �           2606    17126 4   student_examinations student_examinations_abc_id_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.student_examinations
    ADD CONSTRAINT student_examinations_abc_id_key UNIQUE (abc_id);
 ^   ALTER TABLE ONLY public.student_examinations DROP CONSTRAINT student_examinations_abc_id_key;
       public                 postgres    false    227            �           2606    17124 .   student_examinations student_examinations_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.student_examinations
    ADD CONSTRAINT student_examinations_pkey PRIMARY KEY (examination_id);
 X   ALTER TABLE ONLY public.student_examinations DROP CONSTRAINT student_examinations_pkey;
       public                 postgres    false    227            �           2606    17128 =   student_examinations student_examinations_registration_no_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.student_examinations
    ADD CONSTRAINT student_examinations_registration_no_key UNIQUE (registration_no);
 g   ALTER TABLE ONLY public.student_examinations DROP CONSTRAINT student_examinations_registration_no_key;
       public                 postgres    false    227            �           2606    17130 5   student_examinations student_examinations_roll_no_key 
   CONSTRAINT     s   ALTER TABLE ONLY public.student_examinations
    ADD CONSTRAINT student_examinations_roll_no_key UNIQUE (roll_no);
 _   ALTER TABLE ONLY public.student_examinations DROP CONSTRAINT student_examinations_roll_no_key;
       public                 postgres    false    227            �           2606    16849    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 postgres    false    218            �           2606    16891    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 postgres    false    218            �           2606    17098 %   attendance attendance_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student_details(student_id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.attendance DROP CONSTRAINT attendance_student_id_fkey;
       public               postgres    false    4786    219    225            �           2606    16998 -   department department_head_of_department_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_head_of_department_fkey FOREIGN KEY (head_of_department) REFERENCES public.faculty(faculty_id) ON DELETE SET NULL;
 W   ALTER TABLE ONLY public.department DROP CONSTRAINT department_head_of_department_fkey;
       public               postgres    false    4794    222    221            �           2606    17003 "   faculty faculty_department_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(department_id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.faculty DROP CONSTRAINT faculty_department_id_fkey;
       public               postgres    false    222    221    4798            �           2606    17209 +   file_uploads file_uploads_applicant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.file_uploads
    ADD CONSTRAINT file_uploads_applicant_id_fkey FOREIGN KEY (applicant_id) REFERENCES public.new_applications(application_id) ON UPDATE CASCADE ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.file_uploads DROP CONSTRAINT file_uploads_applicant_id_fkey;
       public               postgres    false    228    220    4792            �           2606    17214 )   file_uploads file_uploads_faculty_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.file_uploads
    ADD CONSTRAINT file_uploads_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculty(faculty_id) ON UPDATE CASCADE ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.file_uploads DROP CONSTRAINT file_uploads_faculty_id_fkey;
       public               postgres    false    4794    228    221            �           2606    17204 )   file_uploads file_uploads_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.file_uploads
    ADD CONSTRAINT file_uploads_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student_details(student_id) ON UPDATE CASCADE ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.file_uploads DROP CONSTRAINT file_uploads_student_id_fkey;
       public               postgres    false    4786    228    219            �           2606    17219 &   file_uploads file_uploads_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.file_uploads
    ADD CONSTRAINT file_uploads_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.file_uploads DROP CONSTRAINT file_uploads_user_id_fkey;
       public               postgres    false    218    4780    228            �           2606    17112    library library_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.library
    ADD CONSTRAINT library_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student_details(student_id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.library DROP CONSTRAINT library_student_id_fkey;
       public               postgres    false    226    4786    219            �           2606    16929 .   new_applications new_applications_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.new_applications
    ADD CONSTRAINT new_applications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;
 X   ALTER TABLE ONLY public.new_applications DROP CONSTRAINT new_applications_user_id_fkey;
       public               postgres    false    220    218    4780            �           2606    17072 %   payments payments_application_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.new_applications(application_id) ON DELETE SET NULL;
 O   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_application_id_fkey;
       public               postgres    false    223    4792    220            �           2606    17067 !   payments payments_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student_details(student_id) ON DELETE SET NULL;
 K   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_student_id_fkey;
       public               postgres    false    223    4786    219            �           2606    17084    results results_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student_details(student_id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.results DROP CONSTRAINT results_student_id_fkey;
       public               postgres    false    224    219    4786            �           2606    17288 2   semester_records semester_records_semester_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.semester_records
    ADD CONSTRAINT semester_records_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.semester_records DROP CONSTRAINT semester_records_semester_id_fkey;
       public               postgres    false    231    230    4818            �           2606    17283 1   semester_records semester_records_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.semester_records
    ADD CONSTRAINT semester_records_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student_details(student_id) ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.semester_records DROP CONSTRAINT semester_records_student_id_fkey;
       public               postgres    false    231    219    4786            �           2606    16913 ,   student_details student_details_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_details
    ADD CONSTRAINT student_details_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;
 V   ALTER TABLE ONLY public.student_details DROP CONSTRAINT student_details_user_id_fkey;
       public               postgres    false    218    219    4780            �           2606    17131 9   student_examinations student_examinations_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_examinations
    ADD CONSTRAINT student_examinations_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student_details(student_id) ON DELETE CASCADE;
 c   ALTER TABLE ONLY public.student_examinations DROP CONSTRAINT student_examinations_student_id_fkey;
       public               postgres    false    219    227    4786            �      x������ � �            x������ � �      |   �  x�e��n9E��W�8Ѓz-� 3�H�fC����v���F�Y��jQ�pt�{�ԛ��9J���h�����IGr���痳�>|�EWV��۟���0U,2��ڠ�1`�����Ot^x#=�PJ.���e %U΢������u����[��&]���P&D��"1ǚ��e;n��oT,i΁�L�BeX�1��e��>Y��~>]q-՘h��F��8��r�������x\�Õ�L�YM�W��|�¹�8����7��Z+���j����@#�La�Y�Q�g����Ƒ��^�%ejءsW`���%������t�;A2�j�8�ts�*$�{�ɺp�7~�iMbL�6]����6PS���=���p�U�b�0��YлV�jn}�!�r_�۾݀&iD� 2�Ho~��KNL�a�ûJ�0x�ب[�9N�GΣ�����|8m��Pﳯ���=Z��=�^ca��ؓ����/�M,s�a�4�%\�J�"Ϧ�:����/����65� ���Nh�P�O�Cm�}|ٗU��ý<-�e\m����ឦ� c{E�j�uי���-�駞��NmzH�Ӹ�:my�F�G�8�=���ނe��14�Z�>���/c�A��w�.+�Lݏ���~L�<X      {   �  x��W�r�<��?Ј~?n�Di�]j�^*�_������ )s�~�A��w���B�Aeeee�qL�'���ukd1���d��L�q�_�.�S�Տ�f>,�x���_�ԉ���z�t>������f���p��ő�n��V��w�h%��IrMzӲt&*Y��2�J슷\�4j���/�o��m�qٽѽ[��Μ�S���
�J���Z�ڈO@�v)���t܈Ot����S=�+���=���|�S�s�Z� �Ά*�*]hEf�L���.�ڂe)k|���!�Rl	/�t�Ȃ�������yX���~ٮ.�a:����a��8&�����k�PN�|�̕P6I����9��:QG���S�3ج"�)�U聸��� �R��1�RNz��y���Y����r�(>�r� 1WG����u�4h��u��p�5�M�S�Ta]��a� �QE��۵$S,�9q�6->����z��������WL�	a���8/m�}����d.݀�B��� \(p���KVx�Yt���2)�QO��|�=�_V�LG����t����dz!���Rσ� ]�@�|��5W�����Κ��s�V�5wg�AɄ͓�gW]й@-����>��B�.��G"}�W�q>j+]�^US�B�!��[F_���z�T�5a���:����f%�2��dTU'�~�y��z�_���}]�e7v�5aU6hc��O~���b	�.��X�ڌRkF�s��C�N��ej�ʜB66U��=�ׇG��<��e;��h�o�~�B��jUk�� ]p���g��	*��`l����n��ZWZ�i�J���`/�_.��������~Y]4���R���+d�FX���������࡬\�BB��ևQ���� fb��m"��j8^}��O��y�a9 ���@Tp=��2���P�nN �q;���m�HZ�}0:�J��ɅOvq�R$ėQw}���Ս�T��#l3���Wڵo�^M�[}��σ�ʹ]˟�~�����#�M��S�����9��#���)�mQ�0m�U����,Ii4nǧ�ܐoS*�X8���2C��_�ޓ�><��k�ab�3Xf�o�i��"h��
�Vp�;[ߍ*gpsW��+��X��h�cvO��m�G y\���~�{���3�N!����R*��,,��.5tZ}	�܄�O����s��tSGL�G�ar��6��Z�'��e;=L[X�Gq�0ǳ��evkJ�;;,!gz*��lU��M��?6=-�b���,2p �S��0Y�� ��2�G����'r�y܇i�W�����{��L� � V���
VSv�[��܍
�-}=�����<23@`�,c�]�a�I����W����0���n�ǭ�kw�+�E�� �/H"_�i�p<%�`2����bBs�uׅ�]�>���<l;g/��`���s\Q���h��.����>�O.���l;%ܣ(���ʨ�7��a��Sܵ�j�Ed��;�
qW\uĚ��a��z�����j����E���|��eZi
IFM�۹p4�MN�H����+_0.1�瑆����̊��&�v��NX-��:��y�iu9�o�>������=y���8Qr�7d.ҫP�-i�.hݟʝ����͛7����      �   �   x�m�1� F�9��p���'�T�*5R��7ٻ��{&!���P�g���7H-� ��v����ƍ4v��T���M�P\��#Z򝸎�k-S�C:G���#�ˍӊ���
��i��w�?����$-��x�����6;�~��1�      �      x������ � �      z   �  x��Mo�0�ϓ_�;8���vn�.���p�zq�I֐8�$���e[.尢=�d��;�����&N��B3��f�ȳ�J%����%����i����DI�q�����V\��(�����"\����+kt�J
_���T�h'��_n<T�i��\��q���$,G�+9�OBj��\�y��ͷa����T�yd���]�{�ü���÷���u��y���4S�~R�S��p���5�0���Sl�|����vw+%����rY�H����g8PS�ac�"#D/��Ct�@VUY����%M�>Ƀ�3��#i�:�I2�ibH�e�h�\�xk;�vҜ��3��@�u���0l�S�����6�[%V�iH*~F�*H<)��0S�`�uŜR��
��čR�$���C��sq��.�х�LEd�E�e��?�      }      x������ � �      ~      x������ � �      �      x������ � �      �   1   x�3�N�M-.I-R0�2Bp���c.Ǆ��1�2Cp̸b���� ��      y   g	  x��Ks�8��ȯ�>�"��H���ر;ʣg�7  ZLD2ERq{~�\��DJt�N�Ը*�� �����s��Q�Ib*��<V1�!�Gc�Jj��������ń��$�G�`��<�k�B��4}��~��ѡy�������1�!!Q�Y�B��b8zS��ɋ��P 	L"�qFR��K�v��]���unS��ŪL�����{�(�l���R2
g���9�SOm������׵��"C�ؕu��Y~��Ε��]3��i����ɥN�ɲ�m��\]���3];�69[g�kXu;�!7k7y���O�aꣷ,�˳����yZV5A�f��diVE�F�['�B�5���K��r4��{�|�4�s��j��WwUj�G��#ў�ǂ:!��Xr�0��ŒEk�Hbb�"k�X�#Yfi��`�8��`�J�s�y4��-���n���#��4$`�i�@q���v�n�����e���z�)��\���Q*`	@&<:��&�����L�iiVG�y� 0��l�X:S�q�g���n�	�&�����=�f#Rx��sܝ�Yx8�L���(��M�R��,d�D.4���uj�͵ʫ"�HpL(��+l��rG��Z����]�C��H����ۙT���R�[�B��AiX�R�v���L�q_��r�8�ɬ:>����m�'�ZSu�_ˍ9fh�&l���/_��аD��Ԁ�0@o�y����]~��mEvb������SF4��a�.#k��@R��*����Y;�I�)0�P�#����\\����c%���9�{z��=`�S�^�:�.;�TP��*��fy�����=,m�(��z�_'.���R��J�x�i�D[v�����y��a�#�|{5�1���`�N��B)c�
N��N��`Y%�QJa�p�w�ؠGʶ��K��Nh��CE�:�Vj��cGJ��0�ڹ���{�Jcy�%g i�L�.�Jw�}��s!K���Hk��a�5�h�d_k|!�*"����ך�Ϋ/eZ��b�֩� �&u�q����{��,бR��(h��#�)�8�)�2�!�,��R=�ZPu�C��� ��g�Ev|4èjf�Z?����[q�Q����:�5e�&����4��U7Vu([�INs;�	�_'�����>~�c(9J�o�����ԝ��xN��$6�&�G�&������pSE�H�G�ES���^v"�Ш�IԖ��a��#�1�2�m&�1�r�WC]����ϊM[I�ُĦ�����cb�
��q�i�륮Alt}b���6�F3��S 1">b�$*�s�44�Xk��-�A�e��t����Q��J�;i�H���!�@Ѝ��%ܨP=$�_	�O1�Qh���X���Xc�l5��XE&����P�0��c.�ɘۦܧ�{J��3�e:���A,Ü@��� N¸6.���+~%����pO�}��"&�a'B[�$Ld̰$L:�����7�����ۧt��|��-�TY�L���@\p��0��*����m���vj���	Q�O�*�&�ÎkH.*�X{��`��H�d+:�>��ӀckUB��&�".x�$V�*,&�XS�D�Av�N���E�����:��vhHv�0�n��~�f����,t�.����麨}9���l#������+6�1jG�v���t��p9���K���\5H@G2O�uqsR~ģE�d"8�C���X\�1��6�
4�`Y���հ/uiRݕ�Y�z�3��0�>��)k7�if>�7pAݚ[�ұ[��v|�H��|Z�͸;��=<��3���/����8����� 勊8����3�CAI��*nJ�uuR�xJ����@&ā؀O��3g�B�#�)�C0f}_����pE�H�CD�s�������}W��������G�ܹ.3�[k�C𧢰�d�2������֚x�i�o��2�~
n��A�94'���0��d�5'/7�=()�Ӕ�ܜ)��P��*0m��8�@<������RGc�?�8�A���J��[WM�fo��I���F�Ǜ�t���]�īa:u�����Yϋ�U���x�Ӏ��U���O������>V�ć�3�=��k��������ĉԘF����X�	T� &<&���>g�
��ܞU+<v�Mx��#�ړ^gr��N?���ST����Y�mmG�������R�d�}b�4��9�f�����a�uS�~�q?MM�	�\=�m�2��@k.���+�8l"��:b��K�K�]��5�D��mz�Vqo�uhF�]4���&ƛ;�[��1�d��֬��p�Y��`ܬ�Y����bp�%����m�9�>=��?�i�-4Oǟ�gϞ�r�9�      �     x�m�Qk�0ǟ�O��#����\��[�/�%�c	h1����
�����~������P�HT�d�)�U�i�0/KT�*���8yt���p�3x�T��Y.�To��������_US�nԖ<�;iqMH�X�x��cR?�{����������t1^��8�a���è�G�����?�����K�I�A�	�8e%�W�d���v�cҴm�1��[o&�`9��(�{��=�y2��h̴��7�'��EQ�Vce�      x   R  x��λN�0@�9y
��vl��Fz%��Z$@,���4Nh�ޞ�
3�љ�i���ac��Yc��vk��ޠ���`wwKSXg���Gp/�O��*��d����xQU�a!����VmLi!���l;rN��?Go�2��a4��!&G��,��-�ڟ�������d)L�43q]�~u��/�Ӵ;���R�.���t��9_:�Rݢ/2���%�
bf���0 8��~	nS�Ͷs^���mF65�o]���{u�\�U4��ϐ��K?Tq���=&��')�I�Gi��,2�h-��D�E�1�o��H�`��%�`�#�}�]��     