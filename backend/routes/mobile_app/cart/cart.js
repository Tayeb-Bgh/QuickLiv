require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const db = require('../../../dbConnexion');
const authenticate = require('../../auth/utils/verify_jwt');

const router = express.Router();  
router.use(bodyParser.json());

router.get('/products/:idProd',authenticate, (req, res) => {
    const {idProd} = req.params;
    const query =  `
        SELECT unitProd,descProd
        FROM Product p
        WHERE idProd = ?
    `;
    db.query(query, [idProd], (err, results) => {
        if (err) {
            console.error("[SQL ERROR]", err);
            return res.status(500).json({ error: "Database error" });
        }
        if (results.length > 0) {
            res.status(200).json(results[0]);
        } else {
            res.status(404).json({ message: 'No product found' });
        }
    });
});

module.exports = router;
