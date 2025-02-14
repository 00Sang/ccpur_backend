const { newStudentDetails } = require("../models/newApplicationModel");
const pool = require("../config/db");

const newapplication = async (req, res) => {
  try {
    const studentData = req.body;

    // Check if all required fields are provided
    const requiredFields = [
      "session", "full_name", "date_of_birth", "aadhaar_no", "sex", "category",
      "nationality", "religion", "name_of_community", "contact_no", "blood_group",
      "email", "fathers_name", "fathers_occupation", "mothers_name", "mothers_occupation",
      "permanent_address", "present_address", "guardian_name", "guardian_address",
      "hslc_board", "hslc_rollno", "hslc_year", "hslc_div", "hslc_tmarks", "hslc_inst",
      "classxii_board", "classxii_rollno", "classxii_year", "classxii_div", "classxii_tmarks",
      "classxii_inst", "course", "mil", "subject", "agree", "pincode"
    ];

    const missingFields = requiredFields.filter((field) => !studentData[field]);
    if (missingFields.length > 0) {
      return res.status(400).json({ error: `Missing fields: ${missingFields.join(", ")}` });
    }

    // Insert student details
const applicantResult = await newStudentDetails(studentData);
const applicantId = applicantResult?.application_id;
let userID = applicantResult?.user_id;

console.log("Applicant Result:", applicantResult); // Debugging

// Fetch user_id if missing
if (!userID) {
    const userRes = await pool.query("SELECT user_id FROM users WHERE email = $1", [studentData.email]);
    if (userRes.rows.length > 0) {
        userID = userRes.rows[0].user_id;
    } else {
        return res.status(500).json({ error: "Failed to retrieve user ID" });
    }
}

if (!applicantId) {
    return res.status(500).json({ error: "Failed to insert student details. Missing applicant ID." });
}

// Handle file uploads
const passportFile = req.files?.passport?.[0];
const signatureFile = req.files?.signature?.[0];

if (!passportFile || !signatureFile) {
    return res.status(400).json({ error: "Both passport and signature files are required." });
}

// Insert files into the database
const fileQuery = `
    INSERT INTO file_uploads (applicant_id, user_id, passport_path, signature_path)
    VALUES ($1, $2, $3, $4)`;

await pool.query(fileQuery, [
    applicantId,
    userID,
    `/uploads/${passportFile.filename}`,
    `/uploads/${signatureFile.filename}`,
]);

return res.status(201).json({
    message: "Applicant files uploaded successfully",
    applicantId,
    userID,
});

  } catch (error) {
    console.error("Error inserting student data:", error);
    res.status(500).json({ error: "Server error. Please try again later." });
  }
};

module.exports = { newapplication };
