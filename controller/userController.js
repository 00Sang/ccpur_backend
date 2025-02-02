const { createUser, findUserByEmail, updateUserPassword } = require("../models/userModel");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const nodemailer = require("nodemailer");
require("dotenv").config();

// Register a new user
const newuser = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
      return res.status(400).json({ message: "Please provide all user details" });
    }

    // Check if user already exists
    const user = await findUserByEmail(email);
    if (user) {
      return res.status(400).json({ message: "User with this email already exists" });
    }

    // Hash the password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // Create user in the database
    const newUser = await createUser(name, email, hashedPassword);
    return res.status(201).json({
      message: "User registered successfully",
      user: newUser
    });

  } catch (error) {
    console.error(error);
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

    const token = jwt.sign({ id: user.id, email: user.email }, process.env.JWT_SECRET);
    res.json({ message: "Login successful", token });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Forgot password
const forgotpassword = async (req, res) => {
  try {
    const { email } = req.body;
    if (!email) {
      return res.status(400).json({ error: "Email is required" });
    }

    const user = await findUserByEmail(email);
    if (!user) {
      return res.status(404).json({ error: "User does not exist" });
    }

    const resetToken = jwt.sign({ email }, process.env.JWT_SECRET, { expiresIn: "1h" });
    
    const transporter = nodemailer.createTransport({
      service: "Gmail",
      auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS,
      },
    });

    await transporter.sendMail({
      to: email,
      subject: "Password Reset",
      html: `<p>Click <a href="${process.env.FRONTEND_URL}/resetpassword/${resetToken}">here</a> to reset your password</p>`,
    });

    res.json({ message: "Password reset link sent" });
  } catch (error) {
    console.error("Error in forgotpassword:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Reset password route
const resetpassword = async (req, res) => {
  const { token, newPassword } = req.body;

  try {
    // Decode the reset token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    // Hash the new password
    const hashedPassword = await bcrypt.hash(newPassword, 10);

    // Update the password in the database
    await updateUserPassword(decoded.email, hashedPassword);

    // Send success response
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
