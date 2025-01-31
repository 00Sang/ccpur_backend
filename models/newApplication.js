const pool = require("../db");

const createStudent = async (studentData) => {
  const {
    session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion,
    name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation,
    mothers_name, mothers_occupation, permanent_address, present_address, guardian_name,
    guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst,
    classXII_board, classXII_rollno, classXII_year, classXII_div, classXII_tmarks,
    classXII_inst, course, mil, subject
  } = studentData;

  const query = `
    INSERT INTO studentdata (
      session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion,
      name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation,
      mothers_name, mothers_occupation, permanent_address, present_address, guardian_name,
      guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst,
      classXII_board, classXII_rollno, classXII_year, classXII_div, classXII_tmarks,
      classXII_inst, course, mil, subject
    ) VALUES (
      $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, 
      $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35
    ) RETURNING *;`
     ;

  const values = [
    session, full_name, date_of_birth, aadhaar_no, sex, category, nationality, religion,
    name_of_community, contact_no, blood_group, email, fathers_name, fathers_occupation,
    mothers_name, mothers_occupation, permanent_address, present_address, guardian_name,
    guardian_address, hslc_board, hslc_rollno, hslc_year, hslc_div, hslc_tmarks, hslc_inst,
    classXII_board, classXII_rollno, classXII_year, classXII_div, classXII_tmarks,
    classXII_inst, course, mil, subject
  ];

  const result = await pool.query(query, values);
  return result.rows[0]; // Return the inserted student record
};

module.exports = { createStudent };
