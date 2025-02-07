CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    program varchar(150),
    password TEXT NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'student'
);



CREATE TABLE student_examinations (
    id SERIAL,
    application_for VARCHAR(100),
    examination_session VARCHAR(50),
    ABC_id VARCHAR(50) UNIQUE,
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
    debarred_exam_name varchar(100),
    debarred_year INT,
    debarred_rollno VARCHAR(50),
    debarred_board VARCHAR(100)
);


// table schema for student_details

CREATE TABLE student_details (
    serial_no SERIAL  , 
    session VARCHAR(50),
    full_name VARCHAR(100),
    date_of_birth DATE,
    aadhaar_no VARCHAR(12),  
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
    hslc_year INT,
    hslc_div VARCHAR(10),     
    hslc_tmarks INT,          
    hslc_inst VARCHAR(100),   
    classXII_board VARCHAR(50),
    classXII_rollno VARCHAR(20),
    classXII_year INT,
    classXII_div VARCHAR(10),
    classXII_tmarks INT,
    classXII_inst VARCHAR(100),
    course VARCHAR(100),      
    mil VARCHAR(50),         
    subject varchar(100),
    exampassed1 varchar(50),
    exampassed2 varchar(50),
    exampassed3 varchar(50),
    exampassed4 varchar(50),
    exampassed5 varchar(50),
    exampassed6 varchar(50),
    board1 varchar(25),
    board2 varchar(25),
    board3 varchar(25),
    board4 varchar(25),
    board5 varchar(25),
    board6 varchar(25),
    year1 int,
    year2 int,             
    year3 int,
    year4 int,
    year5 int,
    year6 int,
    roll_no1 int,
    roll_no2 int,
    roll_no3 int,
    roll_no4 int,
    roll_no5 int,
    roll_no6 int,
    division1 varchar(10),
    division2 varchar(10),
    division3 varchar(10),
    division4 varchar(10),
    division5 varchar(10),
    division6 varchar(10),
    subject_taken1 varchar(250),
    subject_taken2 varchar(250),
    subject_taken3 varchar(250),
    subject_taken4 varchar(250),
    subject_taken5 varchar(250),
    subject_taken6 varchar(250),
    abc_id VARCHAR(50),
    registration_no VARCHAR(100),
    course_code VARCHAR(50),
    current_semester VARCHAR(50),
    roll_no varchar(20)
);


//file upload  table
CREATE TABLE file_uploads (
    serial_no SERIAL,
    aadhaar_no VARCHAR(12) REFERENCES student_details(aadhaar_no) ON UPDATE CASCADE ON DELETE CASCADE,
    file_name VARCHAR(255) NOT NULL,
    file_path TEXT NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE faculty (
    faculty_id SERIAL PRIMARY KEY,         
    first_name VARCHAR(100) NOT NULL,       
    last_name VARCHAR(100) NOT NULL,        
    email VARCHAR(100) UNIQUE NOT NULL,     
    phone_number VARCHAR(20),               
    department VARCHAR(100),                
    role VARCHAR(100),                      
    date_of_birth DATE,                     
    joining_date DATE NOT NULL,             
    subjects TEXT[],                        
    profile_picture VARCHAR(255),           
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP   
);

Explanation of Fields:
faculty_id: A unique identifier for each faculty member (using SERIAL in PostgreSQL for auto-increment).
first_name and last_name: Store the faculty's first and last name.
email: The faculty member's email, which should be unique.
phone_number: Contact number of the faculty (can be nullable if not provided).
department: The department to which the faculty belongs (e.g., Computer Science, Mathematics).
role: The faculty member's role (e.g., Professor, Assistant Professor, Lecturer).
date_of_birth: Date of birth of the faculty member.
joining_date: The date when the faculty member joined the institution.
qualifications: The educational qualifications of the faculty, which can be stored as text.
subjects: A list of subjects that the faculty teaches (using a PostgreSQL array to store multiple subjects).
profile_picture: A file path or URL for the faculty member's profile picture.
created_at and updated_at: Timestamps that automatically track when the record was created and last updated.


CREATE TABLE department (
    department_id SERIAL PRIMARY KEY,           
    department_name VARCHAR(255) UNIQUE NOT NULL, 
    department_code VARCHAR(50) UNIQUE NOT NULL, 
    head_of_department INTEGER REFERENCES faculty(faculty_id), 
    established_date DATE,                      
    number_of_faculty INTEGER,                  
    description TEXT,                           
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP   
);

Explanation of Fields:
department_id: A unique identifier for each department (auto-incremented with SERIAL).
department_name: The name of the department (e.g., "Computer Science", "Mathematics").
department_code: A unique code representing the department (e.g., "CS", "MATH", etc.).
head_of_department: The faculty_id of the faculty member who is the head of the department. This is a foreign key referencing the faculty table.
established_date: The date when the department was established.
number_of_faculty: The total number of faculty members in the department.
description: A description of the department, such as its history or areas of focus.
created_at and updated_at: Timestamps to track when the department was created and last updated.


CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,             
    aadhaar_no VARCHAR(12) NOT NULL,           
    amount DECIMAL(10, 2) NOT NULL,            
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    payment_method VARCHAR(50),                
    payment_status VARCHAR(50) DEFAULT 'Completed', 
    transaction_id VARCHAR(255),               
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (aadhaar_no) REFERENCES student_details(aadhaar_no) 
);

Explanation of Fields:
payment_id: Unique identifier for each payment record.
aadhaar_no: The student’s Aadhaar number, used to link the payment to the student.
amount: The total amount paid.
payment_date: The timestamp of when the payment was made.
payment_method: The method used for the payment (e.g., cash, online transfer).
payment_status: The status of the payment (e.g., Completed, Pending, Failed).
transaction_id: The unique ID associated with the payment transaction (optional).
created_at and updated_at: Timestamps for tracking when the record was created and updated.



CREATE TABLE results (
    result_id SERIAL PRIMARY KEY,             
    aadhaar_no VARCHAR(12) NOT NULL,           
    exam_id VARCHAR(50) NOT NULL,              
    subject_code VARCHAR(50),                  
    marks_obtained DECIMAL(5, 2),              
    total_marks DECIMAL(5, 2),                 
    grade VARCHAR(5),                          
    result_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (aadhaar_no) REFERENCES student_details(aadhaar_no) 
);

Explanation of Fields:
result_id: Unique identifier for each result record.
aadhaar_no: The student’s Aadhaar number, used to link the result to the student.
exam_id: The ID or type of the exam (e.g., Mid-term, Final exam).
subject_code: The code or identifier for the subject in which the exam was taken.
marks_obtained: The number of marks obtained by the student.
total_marks: The total marks available for the exam.
grade: The grade (A, B, C, etc.) awarded based on marks.
result_date: The date when the result was recorded or issued.
created_at and updated_at: Timestamps for tracking when the record was created and last updated.

CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,         
    aadhaar_no VARCHAR(12) NOT NULL,           
    date DATE NOT NULL,                        
    subject_code VARCHAR(50),                  
    status VARCHAR(20) CHECK (status IN ('Present', 'Absent', 'Late')), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (aadhaar_no) REFERENCES student_details(aadhaar_no) 
);

Explanation of Fields:
attendance_id: Unique identifier for each attendance record.
aadhaar_no: The student’s Aadhaar number, used to link the attendance to the student.
date: The date when the class was held.
subject_code: The code or identifier for the subject for which the attendance is being recorded.
status: The attendance status (e.g., Present, Absent, Late).
created_at and updated_at: Timestamps for tracking when the record was created and last updated.


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

Explanation of Fields:
borrow_id: Unique identifier for each borrowing record.
aadhaar_no: The student’s Aadhaar number, used to link the borrowing record to the student.
book_id: The unique ID or code for the book being borrowed.
book_title: The title of the borrowed book.
borrow_date: The date the book was borrowed.
return_date: The date when the book was returned (nullable if not yet returned).
due_date: The due date by which the book should be returned.
fine: The fine charged if the book is returned late.
created_at and updated_at: Timestamps for tracking when the record was created and last updated.
