const express = require('express');
const path = require('path');
const axios = require('axios');
const bodyParser = require('body-parser');
const NodeCache = require('node-cache');
const jwt = require('jsonwebtoken');
const db = require("../../dbConnexion");
const generateJWT = require('./utils/generate_jwt');
const generateOTP = require('./utils/generate_otp');
const authenticate = require('./utils/verify_jwt');


require('dotenv').config({ path: __dirname + '/../../.env' });

const router = express();
router.use(bodyParser.json());

TELEGRAM_TOKEN = process.env.TELEGRAM_TOKEN;

const otpCache = new NodeCache({ stdTTL: 90 });

router.post('/login', async (req, res) => {
    const query = "SELECT idConvTelegramCust as idChat FROM Customer WHERE phoneCust = ? UNION SELECT idConvTelegramDel as idChat FROM Deliverer WHERE phoneDel = ?";
    const { phoneNumber } = req.body;


    db.query(query, [phoneNumber, phoneNumber], async (err, results) => {
        if (err) {
            console.error("Error executing query:", err);
            return res.status(500).json({ success: false, message: "Database error" });
        }
        if (results.length > 0 && results[0].idChat) {
            const otp = generateOTP();

            try {
                const response = await axios.post(`https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage`, {
                    chat_id: results[0]["idChat"],
                    text: `Votre code OTP est : ${otp}`
                });
                if (response.status == 200) {
                    otpCache.set(phoneNumber, otp);

                    return res.json({ success: true });
                } else {
                    return res.status(500).json({ success: false });
                }

            } catch (err) {
                return res.status(500).json({ "success": false });
            }

        } else {
            return res.json({ success: false });
        }
    });

});

router.post('/verify-otp', (req, res) => {
    const query = "SELECT 'customer' as role,idCust as id FROM Customer WHERE phoneCust = ? UNION SELECT 'deliverer' as role, idDel as id FROM Deliverer WHERE phoneDel = ?";
    const { phoneNumber, otp } = req.body;
    const validOtp = otpCache.get(phoneNumber);

    if (validOtp == otp) {
        otpCache.del(phoneNumber);
        db.query(query, [phoneNumber, phoneNumber], async (err, results) => {
            if (err) throw err;

            if (results.length > 0) {
                const token = generateJWT({ id: results[0]["id"], role: results[0]["role"], phone: phoneNumber });

                if (results[0]["role"] == "customer") {
                    return res.json({ success: true, role: "customer", token: token });
                } else if (results[0]["role"] == "deliverer") {
                    return res.json({ success: true, role: "deliverer", token: token })
                }

            } else {
                return res.status(500).json({ success: false, role: "null", });
            }
        });

    } else {
        return res.status(400).json({ success: false, role: "null", });
    }
});

router.get('/customers/by-phone', authenticate, (req, res) => {
    const query = "SELECT idCust, firstNameCust, lastNameCust, registerDateCust, pointsCust, isSubmittedDelivererCust,isSubmittedPartnerCust FROM Customer WHERE phoneCust = ?";
    const phoneNumber = req.query.phoneNumber;

    db.query(query, [phoneNumber], (err, results) => {
        if (err) throw err;

        if (results.length > 0) {
            const customer = results[0];
            return res.json({
                idCust: customer.idCust,
                firstNameCust: customer.firstNameCust,
                lastNameCust: customer.lastNameCust,
                registerDateCust: customer.registerDateCust,
                pointsCust: customer.pointsCust,
                isSubmittedDelivererCust: customer.isSubmittedDelivererCust,
                isSubmittedPartnerCust: customer.isSubmittedPartnerCust
            });
        } else {
            return res.sendStatus(500);
        }

    })
});

router.get('/deliverers/by-phone', authenticate, (req, res) => {
    const query = "SELECT idDel, firstNameDel, lastNameDel, registerDateDel, emailDel, adrsDel, statusDel FROM Deliverer WHERE phoneDel = ?";
    const { phoneNumber } = req.body;

    db.query(query, [phoneNumber], (err, results) => {
        if (err) throw err;

        if (results.length > 0) {
            const deliverer = results[0];
            return res.json({
                idDel: deliverer.idDel,
                firstNameDel: deliverer.firstNameDel,
                lastNameDel: deliverer.lastNameDel,
                registerDateDel: deliverer.registerDateDel,
                emailDel: deliverer.emailDel,
                adrsDel: deliverer.adrsDel,
                statusDel: deliverer.statusDel
            });
        } else {
            return res.sendStatus(404);
        }

    })
}
);

router.get('/deliverer/vehicle/by-deliverer-id', authenticate, (req, res) => {
    const query = `SELECT idVehc, typeVehc, brandVehc, modelVehc, colorVehc, insuranceExprVehc, registerNbrVehc,yearVehc FROM Vehicle WHERE idVehc IN(
                        SELECT vehicleDel FROM Deliverer WHERE idDel = ?
                ) `;
    const { idDel } = req.body;

    db.query(query, [idDel], (err, results) => {
        if (err) {
            console.error("Error executing query:", err);
            return res.status(500).json({ success: false, message: "Database error" });
        }

        if (results.length > 0) {
            const vehicle = results[0];
            return res.json({
                idVehc: vehicle.idVehc,
                typeVehc: vehicle.typeVehc,
                brandVehc: vehicle.brandVehc,
                modelVehc: vehicle.modelVehc,
                colorVehc: vehicle.colorVehc,
                insuranceExprVehc: vehicle.insuranceExprVehc,
                registerNbrVehc: vehicle.registerNbrVehc,
                yearVehc: vehicle.yearVehc
            });
        } else {
            return res.sendStatus(404);
        }
    });
});

router.get('/deliverer/rating', authenticate, (req, res) => {
    const query = `
        SELECT AVG(ratingDelOrd) as rating FROM CustomerOrder o JOIN Delivery d ON o.idOrd = d.idOrd 
        WHERE idDel = ? AND ratingDelOrd IS NOT NULL
    `;
    const { idDel } = req.body;

    db.query(query, [idDel], (err, results) => {
        if (err) {
            console.error("Error executing query:", err);
            return res.status(500).json({ success: false, message: "Database error" });
        }

        if (results.length > 0 && results[0].rating !== null) {
            return res.json({ success: true, rating: results[0].rating });
        } else {
            return res.json({ success: true, rating: 4.5 });
        }
    });

});

router.get('/deliverer/delivery-number', authenticate, (req, res) => {
    const query = `
        SELECT COUNT(*) as deliveryNbr FROM Delivery d JOIN CustomerOrder o ON d.idOrd = o.idOrd WHERE idDel = ? AND statusOrd = ?
    `;
    const { idDel } = req.body;

    db.query(query, [idDel, 4], (err, results) => {
        if (err) {
            console.error("Error executing query:", err);
            return res.status(500).json({ success: false, message: "Database error" });
        }

        if (results.length > 0) {
            return res.json({ success: true, deliveryNbr: results[0].deliveryNbr });
        } else {
            return res.json({ success: false, message: "No deliveries found" });
        }
    });

});

module.exports = router;