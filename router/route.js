const express = require("express");
const { newUser, login, resetpassword, forgotpassword } = require("../controller/basicUserController");
const { newapplication } = require("../controller/newStudentApplication");
const { existingstudentsform } = require("../controller/existingStudentform");
const { uploadFile, getFilesByUserId, getSecureFiles } = require("../controller/fileUploadController");
const upload = require("../middleware/uploadFileMiddleware"); 
const paymentController = require("../controller/paymentController");
const { getTeachingStaff, getNonTeachingStaff, updateAttendance,facultyDashboard, updateStaffDetails } = require('../controller/facultyInfoController');
const { getStaffDetails, getStudentsDetails, deleteStudent, updateStudent } = require('../controller/adminController');
const { authenticateUser, authorizeRoles } = require('../middleware/basicAuth'); // Import authentication and RBAC middleware
const { deleteStaffDetails } = require('../models/facultyInfoModels');
const { semesterExamination } = require("../controller/studentExaminationController");
const { getPendingApplications, approveApplicant, rejectApplication, getSingleApplication } = require('../controller/applicationApprovalController')
const router = express.Router();



/* *************************** SIMPLE OPREATIONS SECTION ************************** */

router.post("/register", newUser);
router.post("/login", login);
router.post("/resetpassword", resetpassword);
router.post("/forgotpassword", forgotpassword);



/* ************************* FILE UPLOADS SECTOIN ****************************** */

// Upload files (passport and signature)
router.post("/upload", upload, uploadFile);

// Get all uploaded files metadata by user ID (requires authentication)
router.get("/getfiles/:user_id", authenticateUser, authorizeRoles("student", "staff", "admin"), getFilesByUserId);

  // Securely retrieve a specific file by user ID and filename(get the actual file images to be viewed)
  router.get(
    "/secure-getfiles/:user_id", authenticateUser,
    authorizeRoles("student", "staff", "admin"),
    getSecureFiles
  );


/* ************************* PAYMENTS SECTION *************************** */

// Create a new payment
router.post("/payments", authenticateUser, paymentController.createPayment);

// Get payment details by ID
router.get("/payments:id", authenticateUser, paymentController.getPaymentById);

// List all payments (with filters)
router.get("/payments", authenticateUser, authorizeRoles("admin"), paymentController.getAllPayments);

// Update payment status
router.put("/payments:id", authenticateUser, authorizeRoles("admin"), paymentController.updatePaymentStatus);

// Delete a payment
router.delete("/payments:id", authenticateUser, authorizeRoles("admin"), paymentController.deletePayment);

// Create a payment intent for online payments
router.post("/payments/checkout", authenticateUser, paymentController.createPaymentIntent);


/* *************************FACULTY & ADMIN SECTION **************************** */


// Teaching & Non-Teaching Routes
router.get('/teaching-staff', authenticateUser, authorizeRoles('admin', 'staff'), getTeachingStaff); //Protected route
router.get('/non-teaching-staff', authenticateUser, authorizeRoles('admin', 'staff'), getNonTeachingStaff); //Protected route

// Faculty and Admin Protected Routes
router.post('/updateAttendance', authenticateUser, authorizeRoles('staff', 'admin'), updateAttendance); // Protected Route

// Route to fetch student details (Admin & Staff)
router.get('/getStudentDetails', authenticateUser, authorizeRoles('admin', 'staff'), getStudentsDetails); // Protected Route

// Route to fetch all/some faculty details (Admin Only)
router.get('/getStaffDetails', getStaffDetails); // Protected Route

// Protected route: Faculty Dashboard(staff Only)
router.get('/faculty-Dashboard', authenticateUser, authorizeRoles('staff'), facultyDashboard); //Protected route

//Route to delete student details(Admin Only)
router.delete('/deleteStudentDetails', authenticateUser, authorizeRoles('admin'), deleteStudent); //Protected route

//Route to update student details(Admin Only)
router.put('/updateStudentDetails', authenticateUser, authorizeRoles('admin'), updateStudent);//Protected route

//Route to update Staff Details
router.put('/updateStaffDetails', authenticateUser, authorizeRoles('admin'), updateStaffDetails); //Protected route

//Route to delete Staff Details
router.delete('/deleteStaffDetails',authenticateUser, authorizeRoles('admin'), deleteStaffDetails);//ptotected route


/* ************************** APPLICATIONS SECTION ******************************* */

// Application Forms(NEW & OLD)
router.post("/newapplication",authenticateUser, upload, newapplication);
router.post("/existingstudentform", existingstudentsform);

//Route to get all pending Applications
router.get('/getPendingApplications',  getPendingApplications);//ptotected route

//Route to get single applicant Applications
router.get('/getSingleApplications',authenticateUser, authorizeRoles('admin'), getSingleApplication);//ptotected route

//Route to approve New Student Applications
router.put('/approveApplicant',authenticateUser, authorizeRoles('admin'), approveApplicant);//ptotected route

//Route to reject New Student Applications
router.put('/rejectApplication',authenticateUser, authorizeRoles('admin'), rejectApplication);//ptotected route


/* ******************************** EXXAMINATION SECTION ****************************** */

// SEMESTER Examination form
router.post("/semesterExamForm", authenticateUser, semesterExamination);


module.exports = router;

