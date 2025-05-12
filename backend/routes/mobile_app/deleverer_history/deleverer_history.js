const express = require('express');
const path = require('path');
require('dotenv').config({ path: __dirname + './../../../.env' });
const bodyParser = require('body-parser');
const db = require("../../../dbConnexion");
const authenticate = require('../../auth/utils/verify_jwt');
const { calculateProductTotalPrice } = require('../deleverer_history/utils/totalePrice');
const router = express.Router();
router.use(bodyParser.json());

router.get("/history", authenticate, async (req, res) => {
    console.log("JE SUI RENTRE YOUPI");
    try {
        const idDel = req.user.id;
        const query = `
            SELECT 
                d.idOrd, 
                d.cancelCommentDel, 
                co.delivPriceOrd, 
                co.transNbrOrd, 
                co.createdAtOrd
            FROM Delivery d
            JOIN CustomerOrder co ON d.idOrd = co.idOrd
            WHERE d.idDel = ? AND co.statusOrd = ?;
        `;

        db.query(query, [idDel,4], (err, results) => {
            if (err) {
                console.error('Error while retrieving orders:', err);
                return res.status(500).json({
                    success: false,
                    message: 'Server error while retrieving orders'
                });
            }

            return res.status(200).json({
                success: true,
                data: results
            });
        });
    } catch (error) {
        console.error('Error while retrieving orders:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while retrieving orders'
        });
    }
});


router.get("/customer/:idOrd", async (req, res) => {
    try {
        const idOrd = req.params.idOrd;

        const query = `
            SELECT 
                cust.firstNameCust, 
                cust.lastNameCust,
                b.idBusns as idBusnsCart
            FROM CustomerOrder co
            JOIN Cart cart ON co.idCartOrd = cart.idCart
            JOIN Customer cust ON cart.idCustCart = cust.idCust
            JOIN Business b ON cart.idBusnsCart = b.idBusns
            WHERE co.idOrd = ?;
        `;

        db.query(query, [idOrd], (err, results) => {
            if (err) {
                console.error('Error while retrieving customer information:', err);
                return res.status(500).json({
                    success: false,
                    message: 'Server error while retrieving customer information'
                });
            }

            if (results.length === 0) {
                return res.status(404).json({
                    success: false,
                    message: 'No customer information found for this order'
                });
            }

            return res.status(200).json({
                success: true,
                data: results[0]
            });
        });
    } catch (error) {
        console.error('Error while retrieving customer information:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while retrieving customer information'
        });
    }
});


router.get("/business/:idBusnsCart", async (req, res) => {
    try {
        const idBusnsCart = req.params.idBusnsCart;

        const query = `
            SELECT bus.nameBusns, bus.adrsBusns, bus.imgUrlBusns
            FROM Business bus
            WHERE bus.idBusns = ?;
        `;

        db.query(query, [idBusnsCart], (err, results) => {
            if (err) {
                console.error('Error while retrieving business information:', err);
                return res.status(500).json({
                    success: false,
                    message: 'Server error while retrieving business information'
                });
            }

            if (results.length === 0) {
                return res.status(404).json({
                    success: false,
                    message: 'No business information found for this ID'
                });
            }

            return res.status(200).json({
                success: true,
                data: results[0]
            });
        });
    } catch (error) {
        console.error('Error while retrieving business information:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while retrieving business information'
        });
    }
});

router.get("/products/:idOrd", async (req, res) => {
    try {
        const idOrd = req.params.idOrd;

        const query = `
            SELECT
                p.nameProd,
                p.unitProd,
                pc.qttyProdCart,
                pc.unitPriceProdCart
            FROM CustomerOrder co
            JOIN Cart c ON co.idCartOrd = c.idCart
            JOIN ProductCart pc ON c.idCart = pc.idCart
            JOIN Product p ON pc.idProd = p.idProd
            WHERE co.idOrd = ?;
        `;

        db.query(query, [idOrd], (err, products) => {
            if (err) {
                console.error('Error while retrieving products:', err);
                return res.status(500).json({
                    success: false,
                    message: 'Server error while retrieving products'
                });
            }

            let total = 0;

            const productSummaries = products.map(product => {
                total += calculateProductTotalPrice(product);

                return {
                    nameProd: product.nameProd,
                    unitProd: product.unitProd,
                    qttyProdCart: product.qttyProdCart,
                };
            });

            return res.status(200).json({
                success: true,
                data: {
                    products: productSummaries,
                    totalAmount: parseFloat(total.toFixed(2))
                }
            });
        });
    } catch (error) {
        console.error('Error while retrieving products:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while retrieving products'
        });
    }
});

module.exports = router;
