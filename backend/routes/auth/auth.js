const express = require('express');
const path = require('path')
const axios = require('axios');
const bodyParser = require('body-parser');
const db = require("../../dbConnexion");

require('dotenv').config({ path: __dirname + '/../../.env' });

const router = express();
router.use(bodyParser.json());

TELEGRAM_TOKEN = process.env.TELEGRAM_TOKEN;

router.post('/login', async (req, res) => {
    const query = "SELECT idConvTelegramCust as idChat FROM Customer WHERE phoneCust = ? UNION SELECT idConvTelegramDel as idChat FROM Deliverer WHERE phoneDel = ?";
    const { phoneNumber } = req.body;


    db.query(query, [phoneNumber, phoneNumber], async (err, results) => {
        if (err) throw err;

        if (results.length > 0) {
            
            const otp = Math.floor(100000 + Math.random() * 900000).toString();
            try {
                const response = await axios.post(`https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage`, {
                    chat_id: results[0]["idChat"],
                    text: `Votre code OTP est : ${otp}`
                });
                res.json({"success": response.status == 200 ? true : false});
            } catch (err) {
                console.error(err.response?.data);
                res.status(500).json({ "success": false });
            }
           
        } else {
            res.status(500).json({"success": false});
        }
    });

});




module.exports = router;
