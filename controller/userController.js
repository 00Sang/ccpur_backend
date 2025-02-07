const { createUser, findUserByEmail, updateUserPassword } = require("../models/userModel");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const nodemailer = require("nodemailer");
require("dotenv").config();

// Register a new user
const newuser = async (req, res) => {
  try {
    const { name, email, password, role, aadhaar_no, program } = req.body;

    if (!name || !email || !password || !program) {
      return res.status(400).json({ message: "Please provide all required details" });
    }

    // Validate role (only allow 'student', 'staff', or 'admin')
    const validRoles = ["student", "staff", "admin"];
    const assignedRole = validRoles.includes(role) ? role : "student"; // Default to 'student'

    // Check if user already exists
    const user = await findUserByEmail(email);
    if (user) {
      return res.status(400).json({ message: "User with this email already exists" });
    }

    // Hash the password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // Create user in the database with the assigned role
    const newUser = await createUser(name, email, hashedPassword, assignedRole, program);
    const userId = newUser.id; // Directly return ID

    // Insert student details (Only if role is 'student' and Aadhaar is provided)
    if (assignedRole === "student" && aadhaar_no) {
      await pool.query(
        "INSERT INTO student_details (aadhaar_no, user_id) VALUES ($1, $2)",
        [aadhaar_no, userId]
      );
    }

    return res.status(201).json({
      message: "User registered successfully",
      userId,
      name,
      email,
      password,
      role,
      program
    });

  } catch (error) {
    console.error("Error in user registration:", error);
    return res.status(500).json({ message: "Internal Server Error" });
  }
};


// Login a user
const login = async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ error: "Email and password are required" });
  }

  try {
    const user = await findUserByEmail(email);
    if (!user) {
      return res.status(400).json({ error: "User not found" });
    }

    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) {
      return res.status(401).json({ error: "Invalid password" });
    }

    // Generate JWT with user role
    const token = jwt.sign(
      { id: user.id, email: user.email, role: user.role, program: user.program },
      process.env.JWT_SECRET,
      { expiresIn: "1h" }
    );

    res.json({
      message: "Login successful",
      token
    });
  } catch (error) {
    console.error("Error in login:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Forgot password
const forgotpassword = async (req, res) => {
  try {
    const { email } = req.body;

    // Check if user exists
    const user = await findUserByEmail(email);
    if (!user) {
      return res.status(404).json({ error: "User does not exist" });
    }

    // Generate reset token (expires in 1 hour)
    const resetToken = jwt.sign(
      { email: user.email },
      process.env.JWT_SECRET,
      { expiresIn: "1h" }
    );

    // Send email with reset link
    const resetLink = `${process.env.FRONTEND_URL}/resetpassword/${resetToken}`;
    
    await transporter.sendMail({
      to: email,
      subject: "Password Reset Request",
      html: `<p>Click <a href="${resetLink}">here</a> to reset your password.</p>`
    });

    res.json({ message: "Password reset link sent to your email." });

  } catch (error) {
    console.error("Error in forgotpassword:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};


// Reset password
const resetpassword = async (req, res) => {
  const { token, newPassword } = req.body;

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const hashedPassword = await bcrypt.hash(newPassword, 10);
    await updateUserPassword(decoded.email, hashedPassword);

    res.json({ message: "Password updated successfully" });
  } catch (error) {
    console.error("Error in resetpassword:", error);

    if (error.name === "TokenExpiredError") {
      return res.status(400).json({ error: "Token has expired. Request a new one." });
    } else if (error.name === "JsonWebTokenError") {
      return res.status(400).json({ error: "Invalid token." });
    }

    res.status(500).json({ error: "Internal Server Error" });
  }
};

module.exports = {
  newuser,
  login,
  resetpassword,
  forgotpassword,
};
