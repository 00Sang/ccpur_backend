const express = require("express");
const { newuser, login, resetpassword, forgotpassword } = require("../controller/userController");
const{ newapplication } = require("../controller/newApplicationForm");

const router = express.Router();

// Register a new user
router.post("/register", newuser);

// Login a user
router.post("/login", login);

// Reset password
router.post("/resetpassword", resetpassword);

// Forgot password
router.post("/forgotpassword", forgotpassword);

// Application form
router.post("/newapps", newapplication);

module.exports = router;
