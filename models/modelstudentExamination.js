const pool = require("../db");

const studentExamination = async (studentexam) => {
  try {
    const {
      application_for, examination_session, ABC_id, registration_no, of_year, roll_no, dept_code,
      fathers_name, guardian_name, permanent_address, course_code, year_semester, sex, category,
      papercode_a, paperno_a, papercode_b, paperno_b, papercode_c, paperno_c, papercode_d, paperno_d,
      papercode_e, paperno_e, papercode_f, paperno_f, papercode_g, paperno_g, papercode_h, paperno_h,
      papercode_i, paperno_i, papercode_j, paperno_j, exampassed1, board1, year1, roll_no1, division1, subject_taken1,
      exampassed2, board2, year2, roll_no2, division2, subject_taken2, exampassed3, board3, year3, roll_no3,
      division3, subject_taken3, exampassed4, board4, year4, roll_no4, division4, subject_taken4, 
      debarred_exam_name, debarred_year, debarred_rollno, debarred_board
    } = studentexam; 

    const query = `
      INSERT INTO student_examinations (
        application_for, examination_session, ABC_id, registration_no, of_year, roll_no, dept_code,
        fathers_name, guardian_name, permanent_address, course_code, year_semester, sex, category,
        papercode_a, paperno_a, papercode_b, paperno_b, papercode_c, paperno_c, papercode_d, paperno_d,
        papercode_e, paperno_e, papercode_f, paperno_f, papercode_g, paperno_g, papercode_h, paperno_h,
        papercode_i, paperno_i, papercode_j, paperno_j, exampassed1, board1, year1, roll_no1, division1, subject_taken1,
        exampassed2, board2, year2, roll_no2, division2, subject_taken2, exampassed3, board3, year3, roll_no3,
        division3, subject_taken3, exampassed4, board4, year4, roll_no4, division4, subject_taken4, 
        debarred_exam_name, debarred_year, debarred_rollno, debarred_board
      ) VALUES (
        $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20,
        $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40,
        $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60
      ) RETURNING *;
    `;

    const values = [
      application_for, examination_session, ABC_id, registration_no, of_year, roll_no, dept_code,
      fathers_name, guardian_name, permanent_address, course_code, year_semester, sex, category,
      papercode_a, paperno_a, papercode_b, paperno_b, papercode_c, paperno_c, papercode_d, paperno_d,
      papercode_e, paperno_e, papercode_f, paperno_f, papercode_g, paperno_g, papercode_h, paperno_h,
      papercode_i, paperno_i, papercode_j, paperno_j, exampassed1, board1, year1, roll_no1, division1, subject_taken1,
      exampassed2, board2, year2, roll_no2, division2, subject_taken2, exampassed3, board3, year3, roll_no3,
      division3, subject_taken3, exampassed4, board4, year4, roll_no4, division4, subject_taken4, 
      debarred_exam_name, debarred_year, debarred_rollno, debarred_board
    ];

    const result = await pool.query(query, values);
    return result.rows[0]; // Return the inserted data
  } catch (error) {
    console.error("Error inserting student data:", error);
    throw error; // Let the controller handle errors
  }
};

module.exports = studentExamination;
