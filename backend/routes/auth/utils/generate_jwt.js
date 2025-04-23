const jwt = require('jsonwebtoken');
const path = require('path');
require('dotenv').config({ path: __dirname + '/../../../.env' });

function generateJWT({ id, role, phone }) {
  const payload = {
    id,
    role,
    phone
  };

  const token = jwt.sign(payload, process.env.JWT_SECRET, {
    expiresIn: '7d',
  });

  return token;
}

module.exports = generateJWT;
