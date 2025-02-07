const jwt = require("jsonwebtoken");
const pool = require("../db");
require("dotenv").config();

// Middleware to authenticate users based on JWT token
const authorize = (roles = []) => {
  return async (req, res, next) => {
    try {
      const token = req.header("Authorization");

      if (!token || !token.startsWith("Bearer ")) {
        return res.status(401).json({ message: "Access denied. No token provided." });
      }

      const decoded = jwt.verify(token.split(" ")[1], process.env.JWT_SECRET);

      // Fetch the user's role from the database
      const userResult = await pool.query("SELECT id, role FROM users WHERE id = $1", [decoded.id]);

      if (userResult.rows.length === 0) {
        return res.status(403).json({ message: "User not found." });
      }

      const user = userResult.rows[0];

      // Attach user details to request
      req.user = { id: user.id, role: user.role };

      // Check if the user's role is authorized
      if (roles.length > 0 && !roles.includes(user.role)) {
        return res.status(403).json({ message: "Forbidden: You do not have permission." });
      }

      next();
    } catch (error) {
      console.error("JWT Error:", error);
      res.status(401).json({ message: "Invalid or expired token." });
    }
  };
};

module.exports = authorize;
