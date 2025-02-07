const pool = require("../db");
const path = require("path");

const createExistingStudentDetails = async (req, res) => {
  try {
    // Extract student details from request body
    const {
      session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion,
      name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation,
      mothers_name, mothers_occupation, permanent_address, present_address, guardian_name,
      guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst,
      classxii_board, classxii_rollno, classxii_year, classxii_div, classxii_tmarks, classxii_inst,
      course, mil, subject, additional_subject, exampassed1, exampassed2, exampassed3, exampassed4,
      exampassed5, exampassed6, board1, board2, board3, board4, board5, board6, year1, year2, year3,
      year4, year5, year6, roll_no1, roll_no2, roll_no3, roll_no4, roll_no5, roll_no6, division1, 
      division2, division3, division4, division5, division6, subject_taken1, subject_taken2, 
      subject_taken3, subject_taken4, subject_taken5, subject_taken6, abc_id, registration_no, 
      course_code, current_semester, roll_no, agree
    } = req.body;

    // Step 1: Fetch user_id from users table using email
    const userQuery = "SELECT id FROM users WHERE email = $1";
    const userResult = await pool.query(userQuery, [email]);

    if (userResult.rows.length === 0) {
      return res.status(404).json({ error: "User with this email not found" });
    }

    const user_id = userResult.rows[0].id; // Extract the user_id

    // Step 2: Get the file paths for passport and signature from the uploaded files
    const passportFilePath = req.file ? req.file.path : null;  // Assuming passport is uploaded as single file
    const signatureFilePath = req.files?.signature ? req.files.signature[0].path : null;  // Assuming multiple files are handled

    // Step 3: Insert student details into student_details table
    const studentQuery = `
      INSERT INTO student_details (
        session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion,
        name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation,
        mothers_name, mothers_occupation, permanent_address, present_address, guardian_name,
        guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst,
        classxii_board, classxii_rollno, classxii_year, classxii_div, classxii_tmarks, classxii_inst,
        course, mil, subject, additional_subject, exampassed1, exampassed2, exampassed3, exampassed4,
        exampassed5, exampassed6, board1, board2, board3, board4, board5, board6, year1, year2, year3,
        year4, year5, year6, roll_no1, roll_no2, roll_no3, roll_no4, roll_no5, roll_no6, division1, 
        division2, division3, division4, division5, division6, subject_taken1, subject_taken2, 
        subject_taken3, subject_taken4, subject_taken5, subject_taken6, abc_id, registration_no, 
        course_code, current_semester, roll_no, agree, user_id
      ) VALUES (
        $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, 
        $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, 
        $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, 
        $57, $58, $59, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $70, $71, $72, $73, $74, 
        $75, $76, $77, $78, $79, $80, $81
      ) RETURNING aadhaar_no; 
    `;

    const studentValues = [
      session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion,
      name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation,
      mothers_name, mothers_occupation, permanent_address, present_address, guardian_name,
      guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst,
      classxii_board, classxii_rollno, classxii_year, classxii_div, classxii_tmarks, classxii_inst,
      course, mil, subject, additional_subject, exampassed1, exampassed2, exampassed3, exampassed4,
      exampassed5, exampassed6, board1, board2, board3, board4, board5, board6, year1, year2, year3,
      year4, year5, year6, roll_no1, roll_no2, roll_no3, roll_no4, roll_no5, roll_no6, division1, 
      division2, division3, division4, division5, division6, subject_taken1, subject_taken2, 
      subject_taken3, subject_taken4, subject_taken5, subject_taken6, abc_id, registration_no, 
      course_code, current_semester, roll_no, agree, user_id
    ];

    const studentResult = await pool.query(studentQuery, studentValues);
    const aadhaar_no_result = studentResult.rows[0].aadhaar_no;

    // Step 4: Store passport and signature file paths in the file_uploads table
    const fileUploadQuery = `
      INSERT INTO file_uploads (aadhaar_no, passport_file_path, signature_file_path)
      VALUES ($1, $2, $3)
      RETURNING *;
    `;
    const fileUploadValues = [aadhaar_no_result, passportFilePath, signatureFilePath];

    await pool.query(fileUploadQuery, fileUploadValues);

    res.status(201).json({
      message: "Student record inserted, and files uploaded successfully.",
      student: studentResult.rows[0]
    });
  } catch (error) {
    console.error("Error inserting student data:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

module.exports = createExistingStudentDetails;
