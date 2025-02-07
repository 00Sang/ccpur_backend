const express = require("express");
const cors = require("cors");
const router = require("./router/route"); // 
require('dotenv').config();

const app = express();

// Initialize dotenv to access environment variables
const port = process.env.PORT // 

// Middleware
app.use(cors());
app.use(express.json()); // Allows req.body
app.use(express.urlencoded({ extended: true }));

// Route Middleware
app.use("/api/user", router);

// Handle unknown routes
app.all("*", (req, res) => {
  res.status(404).json({ error: "Route not found" });
});

// General Error Handler
app.use((err, req, res, next) => {
  console.error("Error:", err);
  res.status(500).json({ error: "Internal Server Error" });
});

// Start Server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
