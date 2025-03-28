const express = require("express");
const mysql = require('mysql2');
const cors = require("cors");
require("dotenv").config();


const app = express();
app.use(cors());

const serverPort = process.env.PORT || 3000;

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

app.get("/",(req,res)=>{
    const query = 'SELECT * FROM users ';
    db.query(query, [], async (err, results) => {
        if (err) throw err;

        if (results.length > 0) {
             res.json(results[1]);
        } else {
            res.status(401).json({ message: 'Nom d\'utilisateur ou mot de passe incorrect' });
        }
    });
})


app.listen(serverPort,() => {
    const host = process.env.HOST || "localhost"; 
    console.log(`Server running at http://${host}:${serverPort}/`);
})