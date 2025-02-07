const studentData = require("../models/newApplicationModel");
const { createStudent } = require("../models/newApplicationModel");
const multer = require("multer");
const path = require("path");

// Set up multer for file uploads
const upload = multer({
  storage: multer.diskStorage({
    destination: (req, file, cb) => {
      const dir = path.join(__dirname, "../uploads");
      cb(null, dir);
    },
    filename: (req, file, cb) => {
      cb(null, `${Date.now()}-${file.originalname}`);
    }
  }),
  fileFilter: (req, file, cb) => {
    const allowedMimeTypes = ["image/jpeg", "image/png", "image/jpg"];
    if (allowedMimeTypes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error("Invalid file type"), false);
    }
  }
}).fields([{ name: "passport", maxCount: 1 }, { name: "signature", maxCount: 1 }]);

// Controller for handling existing student form submission
const existingstudentsform = async (req, res) => {
  try {
    // Handle file uploads first
    upload(req, res, async (err) => {
      if (err) {
        return res.status(400).json({ error: `File upload error: ${err.message}` });
      }

      const existingStudent = req.body;

      // Check if all fields are provided
      const requiredFields = [
        "session",
        "full_name",
        "date_of_birth",
        "aadhaar_no",
        "sex",
        "category",
        "nationality",
        "religion",
        "name_of_community",
        "contact_no",
        "blood_group",
        "email",
        "fathers_name",
        "fathers_occupation",
        "mothers_name",
        "mothers_occupation",
        "permanent_address",
        "present_address",
        "guardian_name",
        "guardian_address",
        "hslc_board",
        "hslc_rollno",
        "hslc_year",
        "hslc_div",
        "hslc_tmarks",
        "hslc_inst",
        "classXII_board",
        "classXII_rollno",
        "classXII_year",
        "classXII_div",
        "classXII_tmarks",
        "classXII_inst",
        "course",
        "mil",
        "subject",
        "additional_subject",
        "exampassed1",
        "exampassed2",
        "exampassed3",
        "exampassed4",
        "exampassed5",
        "exampassed6",
        "board1",
        "board2",
        "board3",
        "board4",
        "board5",
        "board6",
        "year1",
        "year2",
        "year3",
        "year4",
        "year5",
        "year6",
        "roll_no1",
        "roll_no2",
        "roll_no3",
        "roll_no4",
        "roll_no5",
        "roll_no6",
        "division1",
        "division2",
        "division3",
        "division4",
        "division5",
        "division6",
        "subject_taken1",
        "subject_taken2",
        "subject_taken3",
        "subject_taken4",
        "subject_taken5",
        "subject_taken6",
        "abc_id",
        "registration_no",
        "course_code",
        "current_semester",
        "roll_no",
        "user_id",
        "agree"
      ];

      const missingFields = requiredFields.filter((field) => !existingStudent[field]);
      if (missingFields.length > 0) {
        return res.status(400).json({ error: `Missing fields: ${missingFields.join(", ")}` });
      }

      // Handle file paths for passport and signature
      let passportPath = "";
      let signaturePath = "";

      if (req.files) {
        if (req.files.passport) passportPath = req.files.passport[0].path;
        if (req.files.signature) signaturePath = req.files.signature[0].path;
      }

      // Insert student into the database, including passport and signature file paths
      const newStudent = await createStudent({
        ...existingStudent,
        passport: passportPath, // Save passport file path
        signature: signaturePath, // Save signature file path
      });

      res.status(201).json({
        message: "Application submitted successfully",
        student: newStudent,
      });
    });
  } catch (error) {
    console.error("Error inserting student data:", error.message);
    res.status(500).json({ error: "Server error. Please try again later." });
  }
};

module.exports = { existingstudentsform };
