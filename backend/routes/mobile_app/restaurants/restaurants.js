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

    const params = ['restaurant', currDayNbr, wilaya];

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
            return res.status(404).json({ message: 'No restaurant found' });
        }
    });
});


router.get("/products-business/:idBusns", (req, res) => {
    const { idBusns } = req.params;

    const query = `SELECT pb.idProd, pb.idBusns, pb.priceProdBusns
                   FROM Business b 
                   JOIN ProductBusiness pb ON pb.idBusns = b.idBusns
                   JOIN Product p ON p.idProd = pb.idProd
                   WHERE p.byAdminProd = ? AND pb.reducRateProdBusns IS NULL
                   AND b.typeBusns = ?  AND b.idBusns = ? LIMIT 1`;

    db.query(query, [0, 'restaurant', idBusns], (err, results) => {

        if (err) {
            console.error("[SQL ERROR]", err);
            return res.status(500).json({ error: "Database error" });
        }

        console.log("[DEBUG] SQL results", results);

        if (results.length > 0) {
            res.status(200).json(results);
        } else {
            res.status(404).json({ message: 'No product found' });
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
            //console.log("[DEBUG] SQL results", results);
            res.status(200).json(results);
        } else {
            res.status(404).json({ message: 'No product found' });
        }
    });
});

module.exports = router