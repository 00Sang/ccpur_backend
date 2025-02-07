const studentDetails = require("../models/newApplicationModel");
const { uploadFile } = require("../controller/fileUploadController"); // Make sure to import uploadFile
const pool = require("../db");

const newapplication = async (req, res) => {
  try {
    const studentData = req.body;

    // Check if all required fields are provided (excluding files)
    const requiredFields = [
      "session", "full_name", "date_of_birth", "aadhaar_no", "sex", "category",
      "nationality", "religion", "name_of_community", "contact_no", "blood_group", "email",
      "fathers_name", "fathers_occupation", "mothers_name", "mothers_occupation",
      "permanent_address", "present_address", "guardian_name", "guardian_address",
      "hslc_board", "hslc_rollno", "hslc_year", "hslc_div", "hslc_tmarks", "hslc_inst",
      "classxii_board", "classxii_rollno", "classxii_year", "classxii_div", "classxii_tmarks",
      "classxii_inst", "course", "mil", "subject", "agree",
    ];

    const missingFields = requiredFields.filter(field => !studentData[field]);
    if (missingFields.length > 0) {
      return res.status(400).json({ error: `Missing fields: ${missingFields.join(", ")}` });
    }

    // Insert student details into the student_details table
    const newStudent = await studentDetails(studentData);

    // Handle file uploads (passport and signature)
    const passportFile = req.files?.passport ? req.files.passport[0] : null;
    const signatureFile = req.files?.signature ? req.files.signature[0] : null;

    if (passportFile && signatureFile) {
      // Store the files in the file_uploads table
      await pool.query(
        "INSERT INTO file_uploads (aadhaar_no, file_name, file_path) VALUES ($1, $2, $3), ($1, $4, $5)",
        [
          studentData.aadhaar_no,
          passportFile.filename,
          `/uploads/${passportFile.filename}`,
          signatureFile.filename,
          `/uploads/${signatureFile.filename}`
        ]
      );
    } else {
      return res.status(400).json({ error: "Both passport and signature files are required." });
    }

    res.status(201).json({
      message: "Application submitted successfully",
      student: newStudent
    });

  } catch (error) {
    console.error("Error inserting student data:", error.message);
    res.status(500).json({ error: "Server error. Please try again later." });
  }
};

module.exports = { newapplication };
