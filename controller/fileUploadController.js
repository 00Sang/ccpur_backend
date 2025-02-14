const fs = require("fs");
const path = require("path");
const pool = require("../config/db");

const uploadFile = async (req, res) => {
  try {
    const { user_id, applicant_id } = req.body;

    if (!user_id || !applicant_id) {
      return res.status(400).json({ error: "Both user ID and applicant ID are required." });
    }

    if (!req.files || !req.files.passport || !req.files.signature) {
      return res.status(400).json({ error: "Both passport and signature files are required." });
    }

    const passportFile = req.files.passport[0];
    const signatureFile = req.files.signature[0];

    const passportPath = `/uploads/${passportFile.filename}`;
    const signaturePath = `/uploads/${signatureFile.filename}`;

    await pool.query(
      `INSERT INTO file_uploads (user_id, applicant_id, passport_path, signature_path) 
       VALUES ($1, $2, $3, $4)`,
      [
        user_id,
        applicant_id,
        passportPath,
        signaturePath,
      ]
    );
    

    res.status(201).json({ success: "Files uploaded successfully", user_id, applicant_id });
  } catch (err) {
    console.error("Error uploading file:", err);
    res.status(500).json({ error: "File upload failed" });
  }
};


// Get files metadata by user ID (returns file info, not actual files)
const getFilesByUserId = async (req, res) => {
  console.log("User from Token:", req.user);  // Debug line
  try {
    const { user_id } = req.params;
    const result = await pool.query(
      "SELECT * FROM file_uploads WHERE user_id = $1",
      [user_id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: "No files found" });
    }

    res.json({ success: "Successfully retrieved files", files: result.rows });
  } catch (err) {
    console.error("Error fetching uploads:", err);
    res.status(500).json({ success: false, error: "Internal Server Error" });
  }
};

// Retrieve both passport and signature files for a given user
const getSecureFiles = async (req, res) => {
  try {
    const { user_id } = req.params;
    const requestingUserId = req.user.id;
    const userRole = req.user.role;

    // Validate user access
    if (userRole !== "admin" && userRole !== "staff" && requestingUserId !== user_id) {
      return res.status(403).json({ error: "Access denied: You can only access your own files" });
    }

    // Fetch both passport and signature paths from the database
    const query = `SELECT passport_path, signature_path FROM file_uploads WHERE user_id = $1`;
    const fileResult = await pool.query(query, [user_id]);

    if (fileResult.rows.length === 0) {
      return res.status(404).json({ error: "Files not found for the given user" });
    }

    const { passport_path, signature_path } = fileResult.rows[0];

    // Construct file paths
    const passportFilePath = passport_path ? path.join(__dirname, "..", passport_path) : null;
    const signatureFilePath = signature_path ? path.join(__dirname, "..", signature_path) : null;

    // Check file existence
    const passportExists = passportFilePath && fs.existsSync(passportFilePath);
    const signatureExists = signatureFilePath && fs.existsSync(signatureFilePath);

    // Prepare response
    const files = {};
    if (passportExists) files.passport_url = `/uploads/${path.basename(passport_path)}`;
    if (signatureExists) files.signature_url = `/uploads/${path.basename(signature_path)}`;

    if (!passportExists && !signatureExists) {
      return res.status(404).json({ error: "Files do not exist on the server" });
    }

    res.status(200).json({
      message: "Successfully retrieved files",
      files,
    });
  } catch (error) {
    console.error("Error fetching files:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

module.exports = { uploadFile, getFilesByUserId, getSecureFiles };

