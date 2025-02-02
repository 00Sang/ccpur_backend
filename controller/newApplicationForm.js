const { createStudent } = require("../models/newApplication");

const newapplication = async (req, res) => {
  try {
    const studentData = req.body;

    // Check if all fields are provided
    const requiredFields = [
      "session", "full_name", "date_of_birth", "aadhaar_no", "sex", "category", 
      "nationality", "religion", "name_of_community", "contact_no", "blood_group", "email", 
      "fathers_name", "fathers_occupation", "mothers_name", "mothers_occupation", 
      "permanent_address", "present_address", "guardian_name", "guardian_address", 
      "hslc_board", "hslc_rollno", "hslc_year", "hslc_div", "hslc_tmarks", "hslc_inst", 
      "classXII_board", "classXII_rollno", "classXII_year", "classXII_div", "classXII_tmarks", 
      "classXII_inst", "course", "mil", "subject"
    ];

    const missingFields = requiredFields.filter(field => !studentData[field]);
    if (missingFields.length > 0) {
      return res.status(400).json({ error: `Missing fields: ${missingFields.join(", ")}` });
    }

    // Insert student into database using the model
    const newStudent = await createStudent(studentData);

    res.status(201).json({ message: "Application submitted successfully", student: newStudent });

  } catch (error) {
    console.error("Error inserting student data:", error.message);
    res.status(500).json({ error: "Server error. Please try again later." });
  }
};

module.exports = { newapplication };
