const multer = require("multer");
const path = require("path");

// Storage configuration
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    // Define the folder to store the files
    cb(null, './uploads'); // Store files in the 'uploads' directory
  },
  filename: (req, file, cb) => {
    // Generate a unique filename using timestamp and file extension
    cb(null, Date.now() + path.extname(file.originalname));
  }
});

const upload = multer({
  storage: storage,
  limits: { fileSize: 5 * 1024 * 1024 }, // Limit file size to 5 MB
}).fields([
  { name: 'passport', maxCount: 1 }, // Allow only one passport file
  { name: 'signature', maxCount: 1 }, // Allow only one signature file
]);

module.exports = upload;
