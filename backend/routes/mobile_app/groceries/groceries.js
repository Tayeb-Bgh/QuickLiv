const express = require('express');
const db = require('../../../dbConnexion');
const router = express.Router();

const getAssciatedDayNumber = require('./utils/get_current_day');

router.get("/", (req, res) => {
    const { wilaya, category } = req.query;
    const currDayNbr = getAssciatedDayNumber();

    let query = `
        SELECT idBusns, nameBusns, descBusns, categoryBusns,
               imgUrlBusns, vidUrlBusns, latBusns, lngBusns, wilayaBusns
        FROM Business
        WHERE typeBusns = ? AND dayOffBusns != ? AND wilayaBusns = ?
    `;

    const params = ['grocery', currDayNbr, wilaya];

    if (category) {
        query += ` AND LOWER(categoryBusns) = ?`;
        params.push(category.toLowerCase());
    }

    db.query(query, params, (err, results) => {
        if (err) {
            console.error("Database error:", err);
            return res.status(500).json({ error: "Internal server error" });
        }

        if (results.length > 0) {
            return res.status(200).json(results);
        } else {
            return res.status(404).json({ message: 'No grocery found' });
        }
    });
});


router.get("/reductions/products-business/:idBusns", (req, res) => {
    const { idBusns } = req.params;

    const query = `SELECT ProductBusiness.idProd, ProductBusiness.idBusns, ProductBusiness.reducRateProdBusns, ProductBusiness.priceProdBusns
                   FROM Business b 
                   JOIN ProductBusiness ON ProductBusiness.idBusns = b.idBusns
                   JOIN Product p ON p.idProd = ProductBusiness.idProd
                   WHERE p.byAdminProd = ? AND ProductBusiness.reducRateProdBusns IS NOT NULL AND ProductBusiness.reducRateProdBusns >= 30
                   AND b.typeBusns = ? AND ProductBusiness.qttyProdBusns > ? AND b.idBusns = ?`;

    db.query(query, [1, 'grocery', 0, idBusns], (err, results) => {

        if (err) {
            console.error("[SQL ERROR]", err);
            return res.status(500).json({ error: "Database error" });
        }


        if (results.length > 0) {
            res.status(200).json(results);
        } else {
            res.status(404).json({ message: 'No product on reduction found' });
        };
    });

});


router.get("/products/:idProd", (req, res) => {

    const { idProd } = req.params;

    const query = `SELECT idProd,nameProd,imgUrlProd,unitProd,descProd FROM Product
                   WHERE idProd = ? `;

    db.query(query, [idProd], async (err, results) => {
        if (err) {
            console.error("[SQL ERROR]", err);
            return res.status(500).json({ error: "Database error" });
        } 
        
        if (results) {
            res.status(200).json(results);
        } else {
            res.status(404).json({ message: 'No product on reduction found' });
        }
    });
});

module.exports = router