const express = require("express");
const { newuser, login, resetpassword, forgotpassword } = require("../controller/userController");
const { newapplication } = require("../controller/newApplicationForm");
const { existingstudentsform } = require("../controller/existingStudentform"); // ✅ Fixed import
const { uploadFile, getFilesByAadhaar, getSecureFile } = require("../controller/fileUploadController");
const upload = require("../middleware/uploadMiddleware"); 
const authorize = require("../middleware/authMiddleware");
//const { createStudentExamination } = require("../controller/controllerStudentExamination"); // ✅ Fixed import

const router = express.Router();

/// User Authentication routes
router.post("/register", newuser);
router.post("/login", login);
router.post("/resetpassword", resetpassword);
router.post("/forgotpassword", forgotpassword);

// Application Forms
router.post("/newapps", upload, newapplication);
router.post("/existingstudentform", existingstudentsform);

// Upload files (passport and signature)
router.post("/upload", upload, uploadFile);


// Get uploaded files by Aadhaar number
router.get("/upload/:aadhaar_no", getFilesByAadhaar);
// Secure file retrieval (Only for authenticated users)
router.get("/secure-files/:aadhaar_no/:filename", authorize(["student", "staff", "admin"]), getSecureFile);

// Student examination form
//router.post("/examform", createStudentExamination);

// // Admin-only route
// router.get("/admin", authorize(["admin"]), (req, res) => {
//   res.json({ message: "Welcome, Admin!" });
// });

// // Staff and Admin can access
// router.get("/staff", authorize(["admin", "staff"]), (req, res) => {
//   res.json({ message: "Welcome, Staff Member!" });
// });

module.exports = router;

