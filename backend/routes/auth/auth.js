const express = require('express');
const path = require('path')
const axios = require('axios');
const bodyParser = require('body-parser');
const NodeCache = require('node-cache');
const db = require("../../dbConnexion");

require('dotenv').config({ path: __dirname + '/../../.env' });

const router = express();
router.use(bodyParser.json());

TELEGRAM_TOKEN = process.env.TELEGRAM_TOKEN;

const otpCache = new NodeCache({ stdTTL: 90 });

router.post('/login', async (req, res) => {
    const query = "SELECT idConvTelegramCust as idChat FROM Customer WHERE phoneCust = ? UNION SELECT idConvTelegramDel as idChat FROM Deliverer WHERE phoneDel = ?";
    const { phoneNumber } = req.body;


    db.query(query, [phoneNumber, phoneNumber], async (err, results) => {
        if (err) throw err;

        if (results.length > 0 && results[0].idChat) {

            const otp = Math.floor(10000 + Math.random() * 90000).toString();
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
                console.error(err.response?.data);
                res.status(500).json({ "success": false });
            }

        } else {
            res.status(500).json({ "success": false });
        }
    });

});

router.post('/verify-otp', (req, res) => {
    const query = "SELECT 'customer' as role FROM Customer WHERE phoneCust = ? UNION SELECT 'deliverer' as role FROM Deliverer WHERE phoneDel = ?";
    const { phoneNumber, otp } = req.body;
    const validOtp = otpCache.get(phoneNumber);
    console.log(validOtp);

    if (!validOtp) {
        return res.status(410).json({ success: false });
    }

    if (validOtp == otp) {
        db.query(query, [phoneNumber, phoneNumber], async (err, results) => {
            if (err) throw err;
            console.log(results)
            if (results.length > 0 ) {
                if(results[0]["role"] == "customer"){
                    console.log("je suis customer")
                    return res.json({success: true, role:"customer"});
                }else if(results[0]["role"]== "deliverer"){
                    console.log("je suis livreur")
                    return res.json({success:true, role:"deliverer"})
                }

            } else {
                return res.status(500).json({ success: false, role:"null" });
            }
        });
        otpCache.del(phoneNumber); 
    } else {
        return res.status(400).json({ success: false, role: "null" });
    }
});




module.exports = router;
