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

// db.query(`
//     INSERT INTO Coupon (couponPrice, discountRate, isUsed, idCust)
//     VALUES (?, ?, ?, ?)
//   `, [50.0, 30, true, 1], (err, result) => {
//     if (err) {
//       console.error('Erreur d’insertion :', err);
//       return;
//     }

//     console.log("✅ Coupon inséré avec succès !");
//   });

db.query(`DESCRIBE Customer`, (err, result) => {
    if (err) {
        console.error('Erreur lors de la récupération de la structure de la table :', err);
        return;
    }
    console.log('Structure de la table Customer :', result);
});




module.exports = db;