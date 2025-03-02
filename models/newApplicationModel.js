const pool = require("../config/db");

const newStudentDetails = async (studentData) => {
  try {
    const {
      session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion,
      name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation,
      mothers_name, mothers_occupation, permanent_address, present_address, guardian_name,
      guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst,
      classxii_board, classxii_rollno, classxii_year, classxii_div, classxii_tmarks, classxii_inst,
      course, mil, subject, agree, pincode
    } = studentData;

    const query = `
      INSERT INTO new_applications (
        session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion,
        name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation,
        mothers_name, mothers_occupation, permanent_address, present_address, guardian_name,
        guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst,
        classxii_board, classxii_rollno, classxii_year, classxii_div, classxii_tmarks, classxii_inst,
        course, mil, subject, agree, pincode
      ) VALUES (                 
        $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, 
        $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37
      ) RETURNING application_id, user_id;
    `;

    const values = [
      session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion,
      name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation,
      mothers_name, mothers_occupation, permanent_address, present_address, guardian_name,
      guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst,
      classxii_board, classxii_rollno, classxii_year, classxii_div, classxii_tmarks, classxii_inst,
      course, mil, subject, agree, pincode
    ];

    const result = await pool.query(query, values);
    return result.rows[0]; // Return the inserted student data

  } catch (error) {
    console.error("Error inserting student data:", error.message);
    throw error;
  }
};

const approvedStd = async (approvedStudents) => {
  try {
    const {
      session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion,
      name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation,
      mothers_name, mothers_occupation, permanent_address, present_address, guardian_name,
      guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst,
      classxii_board, classxii_rollno, classxii_year, classxii_div, classxii_tmarks, classxii_inst,
      course, mil, subject, agree, pincode
    } = approvedStudents;

    const query = `
      INSERT INTO student_details (
        session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion,
        name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation,
        mothers_name, mothers_occupation, permanent_address, present_address, guardian_name,
        guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst,
        classxii_board, classxii_rollno, classxii_year, classxii_div, classxii_tmarks, classxii_inst,
        course, mil, subject, agree, pincode
      ) VALUES (                  
        $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, 
        $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37
      ) RETURNING *;
    `;

    const values = [
      session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion,
      name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation,
      mothers_name, mothers_occupation, permanent_address, present_address, guardian_name,
      guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst,
      classxii_board, classxii_rollno, classxii_year, classxii_div, classxii_tmarks, classxii_inst,
      course, mil, subject, agree, pincode
    ];

    const result = await pool.query(query, values);
    return result.rows[0]; // Return the inserted student data

  } catch (error) {
    console.error("Error inserting student data:", error.message);
    throw error;
  }
};
module.exports = {newStudentDetails, approvedStd};
