const express = require('express');
const path = require('path');
const axios = require('axios');
const bodyParser = require('body-parser');
const NodeCache = require('node-cache');
const jwt = require('jsonwebtoken');
const db = require("../../dbConnexion");
const generateJWT = require('./utils/generate_jwt');
const generateOTP = require('./utils/generate_otp');

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
    

    if (!validOtp) {
        return res.status(410).json({ success: false });
    }

    if (validOtp == otp) {
        db.query(query, [phoneNumber, phoneNumber], async (err, results) => {
            if (err) throw err;

            if (results.length > 0 ) {
                const token = generateJWT(results[0]["id"],results[0]["role"], phoneNumber);

                if(results[0]["role"] == "customer"){
                    return res.json({success: true, role:"customer",token:token});
                }else if(results[0]["role"]== "deliverer"){
                    return res.json({success:true, role:"deliverer",token:token})
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
