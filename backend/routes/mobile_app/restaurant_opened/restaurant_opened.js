const express = require('express');
const db = require('../../../dbConnexion');
const router = express.Router();

router.get("/:idRestaurant/categories", (req, res) => {
    const { idRestaurant } = req.params;
    
    const query = `
        SELECT DISTINCT p.secondCategoryProd FROM Product p 
        JOIN ProductBusiness pb ON p.idProd = pb.idProd 
        JOIN Business b ON pb.idBusns = b.idBusns 
        WHERE b.idBusns = ?
    `;

    db.query(query, idRestaurant, (err, results) => {
        if (err) {
            console.error("Database error:", err);
            return res.status(500).json({ error: "Internal server error" });
        }

        if (results.length > 0) {
            return res.status(200).json(results);
        } else {
            return res.status(404).json({ message: 'No restaurant found' });
        }
    });
});

router.get("/:idRestaurant/products/", (req, res) => {
    const { idRestaurant } = req.params;

    let query = `
        SELECT p.idProd,p.unitProd, p.nameProd, pb.priceProdBusns, pb.reducRateProdBusns, p.descProd, p.imgUrlProd, p.secondCategoryProd 
        FROM Product p 
        JOIN ProductBusiness pb ON p.idProd = pb.idProd 
        JOIN Business b ON pb.idBusns = b.idBusns 
        WHERE b.idBusns = ? 
    `;


    db.query(query, idRestaurant, (err, results) => {
        if (err) {
            console.error("Database error:", err);
            return res.status(500).json({ error: "Internal server error" });
        }

        if (results.length > 0) {
            
            return res.status(200).json(results);
        } else {
            return res.status(404).json({ message: 'No products found' });
        }
    });
}
);


module.exports = router