const fs = require("fs");
const path = require("path");
const pool = require("../db");

// Upload file controller
const uploadFile = async (req, res) => {
  try {
    const { aadhaar_no } = req.body; // Extract Aadhaar number from request body
    if (!req.files || !req.files.passport || !req.files.signature) {
      return res.status(400).json({ error: "Both passport and signature files are required" });
    }

    // Get the passport and signature files
    const passportFile = req.files.passport[0];
    const signatureFile = req.files.signature[0];

    // Define file paths to store on the server
    const passportPath = `/uploads/${passportFile.filename}`;
    const signaturePath = `/uploads/${signatureFile.filename}`;

    // Store file metadata in the database
    const result = await pool.query(
      "INSERT INTO file_uploads (aadhaar_no, passport_path, signature_path) VALUES ($1, $2, $3) RETURNING *",
      [aadhaar_no, passportPath, signaturePath]
    );

    res.status(201).json({ success: "Files uploaded successfully", files: result.rows[0] });
  } catch (err) {
    console.error("Error uploading file:", err);
    res.status(500).json({ error: "File upload failed" });
  }
};

// Get files metadata by Aadhaar number (returns file info, not actual files)
const getFilesByAadhaar = async (req, res) => {
  try {
    const { aadhaar_no } = req.params;
    const result = await pool.query(
      "SELECT * FROM file_uploads WHERE aadhaar_no = $1",
      [aadhaar_no]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: "No files found" });
    }

    res.json({ success: "successfully retreived file", files: result.rows });
  } catch (err) {
    console.error("Error fetching uploads:", err);
    res.status(500).json({ success: false, error: "Internal Server Error" });
  }
};

// Secure file retrieval based on Aadhaar number and user role
const getSecureFile = async (req, res) => {
  try {
    const { aadhaar_no, filename } = req.params;
    const userId = req.user.id; // Retrieved from authentication middleware
    const userRole = req.user.role; // User's role from token

    // Check if the user exists and fetch their Aadhaar number (if student)
    const userResult = await pool.query("SELECT role FROM users WHERE id = $1", [userId]);

    if (userResult.rows.length === 0) {
      return res.status(403).json({ error: "Unauthorized access" });
    }

    // If the user is not an admin, ensure they are only accessing their own files
    if (userRole !== "admin") {
      const studentResult = await pool.query(
        "SELECT aadhaar_no FROM student_details WHERE user_id = $1",
        [userId]
      );

      if (studentResult.rows.length === 0 || studentResult.rows[0].aadhaar_no !== aadhaar_no) {
        return res.status(403).json({ error: "Access denied: You can only access your own files" });
      }
    }

    // Check if the requested file exists in the database
    const fileResult = await pool.query(
      "SELECT file_name FROM file_uploads WHERE aadhaar_no = $1 AND file_name = $2",
      [aadhaar_no, filename]
    );

    if (fileResult.rows.length === 0) {
      return res.status(404).json({ error: "File not found" });
    }

    // Construct file path
    const filePath = path.join(__dirname, "..", "uploads", filename);

    // Check if file exists on the server
    if (!fs.existsSync(filePath)) {
      return res.status(404).json({ error: "File does not exist" });
    }

    // Serve the file securely
    res.sendFile(filePath);
  } catch (error) {
    console.error("Error fetching file:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};
module.exports = { uploadFile, getFilesByAadhaar, getSecureFile };
