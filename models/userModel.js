const pool = require("../db");

// Check if a user exists by email
const findUserByEmail = async (email) => {
  const result = await pool.query("SELECT * FROM users WHERE email = $1", [email]);
  return result.rows[0];
};

// Insert new user into the database
const createUser = async (name, email, hashedPassword) => {
  const query =
    "INSERT INTO users (name, email, password) VALUES($1, $2, $3) RETURNING *";
  const values = [name, email, hashedPassword];
  const result = await pool.query(query, values);
  return result.rows[0];
};

// Update user's password
const updateUserPassword = async (email, hashedPassword) => {
  const query = "UPDATE users SET password = $1 WHERE email = $2";
  await pool.query(query, [hashedPassword, email]);
};

module.exports = {
  findUserByEmail,
  createUser,
  updateUserPassword,
};
