const mysql = require('mysql2');
require("dotenv").config();

const db = mysql.createConnection({
    port: process.env.DB_PORT,
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    connectTimeout: 30000
});

db.connect((err) => {
    if (err) throw err;
    console.log('Connecté à la base de données MySQL');
});

module.exports = db;