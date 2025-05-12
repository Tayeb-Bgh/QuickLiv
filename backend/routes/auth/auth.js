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
    const query = "SELECT idConvTelegramCust as idChat FROM Customer WHERE phoneCust = ?";
    const { phoneNumber } = req.body;

    db.query(query, [phoneNumber], async (err, results) => {
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
                console.log("Code OTP !!!!!");
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
router.post('/register', async (req, res) => {
    const { points,
        firstName,
        lastName,
        birthDate,
        registerDate,
        isSubmittedDeliverer,
        isSubmittedPartner, phone
    } = req.body;

    console.log("aaaaaaaaaaaaaaaaaaaaaaa ", phone)
    const query = `
       UPDATE Customer
            SET
    pointsCust = ?,
    firstNameCust = ?,
    lastNameCust = ?,
    birthDateCust = ?,
    isSubmittedDelivererCust = ?,
    isSubmittedPartnerCust = ?
        WHERE phoneCust = ?

    `;

    db.query(query, [100,
        firstName,
        lastName,
        birthDate,
        0,
        0,
        phone], (err, results) => {
            if (err) {
                console.error("Error inserting customer:", err);
                return res.status(500).json({ success: false, message: "Database error" });
            }

            return res.json({ success: true, message: "Customer registered successfully" });
        });
});


router.post('/verify-otp', (req, res) => {
    const query = "SELECT 'customer' as role,idCust as id FROM Customer WHERE phoneCust = ?";
    const { phoneNumber, otp } = req.body;
    const validOtp = otpCache.get(phoneNumber);


    if (!validOtp) {
        return res.status(410).json({ success: false });
    }

    if (validOtp == otp) {
        otpCache.del(phoneNumber);
        db.query(query, [phoneNumber], async (err, results) => {
            if (err) throw err;

            if (results.length > 0) {
                const token = generateJWT({ id: results[0]["id"], role: results[0]["role"], phone: phoneNumber });

                if (results[0]["role"] == "customer") {
                    return res.json({ success: true, role: "customer", token: token });
                }

            } else {
                return res.status(500).json({ success: false, role: "null" });
            }
        });

    } else {
        return res.status(400).json({ success: false, role: "null" });
    }
});

router.get('/customers/by-phone', authenticate, (req, res) => {
    const query = "SELECT idCust, firstNameCust, lastNameCust, registerDateCust, pointsCust, isSubmittedDelivererCust,isSubmittedPartnerCust FROM Customer WHERE phoneCust = ?";
    const { phoneNumber } = req.body;

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

module.exports = router;
