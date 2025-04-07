const express = require('express');
const cloudinary = require('cloudinary').v2;
const db = require('../../../dbConnexion');

const router = express.Router();



router.get("/",(req,res)=>{
    const query = 'SELECT id,username,role FROM users ';
    db.query(query, [], async (err, results) => {
        if (err) throw err;

        if (results.length > 0) {
             res.json(results);
        } else {
            res.status(401).json({ message: 'Nom d\'utilisateur ou mot de passe incorrect' });
        }
    });
})

module.exports = router;