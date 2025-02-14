CREATE TABLE users (
user_id SERIAL PRIMARY KEY,
name VARCHAR(300) NOT NULL,
email VARCHAR(200) UNIQUE NOT NULL,
program varchar(150),
password varchar(250) NOT NULL,
role VARCHAR(50) NOT NULL DEFAULT 'student'
);



CREATE TABLE student_examinations (
    examination_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    student_id UUID REFERENCES student_details(student_id) ON DELETE CASCADE, -- Linking with students
    application_for VARCHAR(100),
    examination_session VARCHAR(50),
    abc_id VARCHAR(50) UNIQUE,
    registration_no VARCHAR(100) UNIQUE,
    of_year VARCHAR(50),
    roll_no VARCHAR(50) UNIQUE,
    dept_code VARCHAR(50),
    fathers_name VARCHAR(255),
    guardian_name VARCHAR(255),
    permanent_address TEXT,
    course_code VARCHAR(50),
    year_semester VARCHAR(50),
    sex VARCHAR(10),
    category VARCHAR(50),
    papercode_a VARCHAR(50), paperno_a VARCHAR(50),
    papercode_b VARCHAR(50), paperno_b VARCHAR(50),
    papercode_c VARCHAR(50), paperno_c VARCHAR(50),
    papercode_d VARCHAR(50), paperno_d VARCHAR(50),
    papercode_e VARCHAR(50), paperno_e VARCHAR(50),
    papercode_f VARCHAR(50), paperno_f VARCHAR(50),
    papercode_g VARCHAR(50), paperno_g VARCHAR(50),
    papercode_h VARCHAR(50), paperno_h VARCHAR(50),
    papercode_i VARCHAR(50), paperno_i VARCHAR(50),
    papercode_j VARCHAR(50), paperno_j VARCHAR(50),
    exampassed1 VARCHAR(100), board1 VARCHAR(100), year1 INT, roll_no1 VARCHAR(50), division1 VARCHAR(50), subject_taken1 TEXT,
    exampassed2 VARCHAR(100), board2 VARCHAR(100), year2 INT, roll_no2 VARCHAR(50), division2 VARCHAR(50), subject_taken2 TEXT,
    exampassed3 VARCHAR(100), board3 VARCHAR(100), year3 INT, roll_no3 VARCHAR(50), division3 VARCHAR(50), subject_taken3 TEXT,
    exampassed4 VARCHAR(100), board4 VARCHAR(100), year4 INT, roll_no4 VARCHAR(50), division4 VARCHAR(50), subject_taken4 TEXT,
    debarred_exam_name varchar(200),
    debarred_year INT,
    debarred_rollno VARCHAR(80),
    debarred_board VARCHAR(100)
);


// table schema for student_details

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE student_details (
    student_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session VARCHAR(50),
    full_name VARCHAR(100),
    date_of_birth DATE,
    aadhaar_no VARCHAR(12) NOT NULL UNIQUE,
    sex VARCHAR(10),
    category VARCHAR(50),
    nationality VARCHAR(50),
    religion VARCHAR(50),
    name_of_community VARCHAR(50),
    contact_no VARCHAR(15),
    blood_group VARCHAR(5),
    email VARCHAR(100) UNIQUE,
    fathers_name VARCHAR(100),
    fathers_occupation VARCHAR(100),
    mothers_name VARCHAR(100),
    mothers_occupation VARCHAR(100),
    permanent_address TEXT,
    present_address TEXT,
    guardian_name VARCHAR(100),
    guardian_address TEXT,
    hslc_board VARCHAR(50),
    hslc_rollno VARCHAR(20),
    hslc_year INTEGER,
    hslc_div VARCHAR(10),
    hslc_tmarks INTEGER,
    hslc_inst VARCHAR(100),
    classxii_board VARCHAR(50),
    classxii_rollno VARCHAR(20),
    classxii_year INTEGER,
    classxii_div VARCHAR(10),
    classxii_tmarks INTEGER,
    classxii_inst VARCHAR(100),
    course VARCHAR(100),
    mil VARCHAR(50),
    subject VARCHAR(100),
    exampassed1 VARCHAR(50),
    exampassed2 VARCHAR(50),
    exampassed3 VARCHAR(50),
    exampassed4 VARCHAR(50),
    exampassed5 VARCHAR(50),
    exampassed6 VARCHAR(50),
    board1 VARCHAR(25),
    board2 VARCHAR(25),
    board3 VARCHAR(25),
    board4 VARCHAR(25),
    board5 VARCHAR(25),
    board6 VARCHAR(25),
    year1 INTEGER,
    year2 INTEGER,
    year3 INTEGER,
    year4 INTEGER,
    year5 INTEGER,
    year6 INTEGER,
    roll_no1 INTEGER,
    roll_no2 INTEGER,
    roll_no3 INTEGER,
    roll_no4 INTEGER,
    roll_no5 INTEGER,
    roll_no6 INTEGER,
    division1 VARCHAR(10),
    division2 VARCHAR(10),
    division3 VARCHAR(10),
    division4 VARCHAR(10),
    division5 VARCHAR(10),
    division6 VARCHAR(10),
    subject_taken1 VARCHAR(250),
    subject_taken2 VARCHAR(250),
    subject_taken3 VARCHAR(250),
    subject_taken4 VARCHAR(250),
    subject_taken5 VARCHAR(250),
    subject_taken6 VARCHAR(250),
    abc_id VARCHAR(50),
    registration_no VARCHAR(100),
    course_code VARCHAR(50),
    current_semester VARCHAR(50),
    roll_no VARCHAR(20) UNIQUE,
    user_id UUID,
    agree BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

// New students application_for

CREATE TABLE new_applications (
    application_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session VARCHAR(50),
    full_name VARCHAR(100),
    date_of_birth DATE,
    aadhaar_no VARCHAR(12) NOT NULL UNIQUE,
    sex VARCHAR(10),
    category VARCHAR(50),
    nationality VARCHAR(50),
    religion VARCHAR(50),
    name_of_community VARCHAR(50),
    contact_no VARCHAR(15),
    blood_group VARCHAR(5),
    email VARCHAR(100),
    fathers_name VARCHAR(100),
    fathers_occupation VARCHAR(100),
    mothers_name VARCHAR(100),
    mothers_occupation VARCHAR(100),
    permanent_address TEXT,
    present_address TEXT,
    guardian_name VARCHAR(100),
    guardian_address TEXT,
    hslc_board VARCHAR(50),
    hslc_rollno VARCHAR(20),
    hslc_year INTEGER,
    hslc_div VARCHAR(10),
    hslc_tmarks INTEGER,
    hslc_inst VARCHAR(100),
    classxii_board VARCHAR(50),
    classxii_rollno VARCHAR(20),
    classxii_year INTEGER,
    classxii_div VARCHAR(10),
    classxii_tmarks INTEGER,
    classxii_inst VARCHAR(100),
    course VARCHAR(100),
    mil VARCHAR(50),
    subject VARCHAR(100),
    user_id UUID,
    status VARCHAR(20) DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);


//file upload  table
CREATE TABLE file_uploads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NULL,
    applicant_id UUID NULL,
    faculty_id UUID NULL,
    user_id UUID NULL,
    file_name VARCHAR(255) NOT NULL,
    file_path TEXT NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (
        student_id IS NOT NULL OR
        applicant_id IS NOT NULL OR
        faculty_id IS NOT NULL OR
        user_id IS NOT NULL
    ),
    CONSTRAINT file_uploads_student_id_fkey
        FOREIGN KEY (student_id) REFERENCES student_details(student_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT file_uploads_applicant_id_fkey
        FOREIGN KEY (applicant_id) REFERENCES new_applications(application_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT file_uploads_faculty_id_fkey
        FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT file_uploads_user_id_fkey
        FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT unique_file_per_user UNIQUE (file_name)
);

// Faculty table

CREATE TABLE faculty (
faculty_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),                
name VARCHAR(150) NOT NULL,               
department VARCHAR(100),
designation varchar(255),
nature_of_apppointment varchar(200),           
role VARCHAR(100)NOT NULL DEFAULT 'staff',                                                                                
type varchar(100),
phone_number VARCHAR(20),
profile_picture TEXT,
department_id UUID REFERENCES department(department_id) ON DELETE SET NULL        
);

CREATE TABLE department (
    department_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),           
    department_name VARCHAR(255) NOT NULL, 
    department_code VARCHAR(50) UNIQUE NOT NULL, 
    head_of_department UUID REFERENCES faculty(faculty_id) ON DELETE SET NULL, 
    number_of_faculty INT                                          
);



//PAYMENTS TABLE
CREATE TABLE payments (
    payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),                        
    student_id UUID REFERENCES student_details(student_id) ON DELETE SET NULL, 
    application_id UUID REFERENCES new_applications(application_id) ON DELETE SET NULL, 
    amount DECIMAL(10, 2) NOT NULL,            
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    payment_method VARCHAR(50),                
    payment_status VARCHAR(50) DEFAULT 'Pending', 
    transaction_id VARCHAR(255),               
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    CHECK (
        (student_id IS NOT NULL AND application_id IS NULL) OR
        (application_id IS NOT NULL AND student_id IS NULL)
    )
);



CREATE TABLE results (
    result_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),              
    student_id UUID REFERENCES student_details(student_id) ON DELETE CASCADE, 
    exam_id VARCHAR(50) NOT NULL,              
    subject_code VARCHAR(50),                  
    marks_obtained DECIMAL(5, 2),              
    total_marks DECIMAL(5, 2),                  
    grade VARCHAR(5),                          
    result_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE attendance (
    attendance_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),         
    student_id UUID REFERENCES student_details(student_id) ON DELETE CASCADE,           
    date DATE NOT NULL,                        
    subject_code VARCHAR(50),                  
    status VARCHAR(150), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE library (
    borrow_id SERIAL PRIMARY KEY,              
    aadhaar_no VARCHAR(12) NOT NULL,            
    book_id VARCHAR(50) NOT NULL,               
    book_title VARCHAR(255) NOT NULL,           
    borrow_date DATE NOT NULL,                  
    return_date DATE,                           
    due_date DATE NOT NULL,                     
    fine DECIMAL(5, 2) DEFAULT 0.00,            
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (aadhaar_no) REFERENCES student_details(aadhaar_no) 
);
