const jwt = require('jsonwebtoken');
const path = require('path');
require('dotenv').config({ path: __dirname + '/../../../.env' });

function generateJWT({ id, role, phone }) {
  const payload = {
    id,
    role,
    phone
  };
   console.log("Payload for JWT: ", payload); // 👈 Log the payload for debugging

  const token = jwt.sign(payload, process.env.JWT_SECRET, {
    expiresIn: '7d',
  });
  // 👈 Log the generated token for debugging
  return token;
}

module.exports = generateJWT;
