/* require('dotenv').config();
const express = require('express');
const axios = require('axios');
const bodyParser = require('body-parser');

const router = express();
router.use(bodyParser.json());



TELEGRAM_TOKEN = '7362874893:AAEnYCVUmus2Ykw6XMgUx8aP5VRuBpq0-J0';

router.post('/start-auth', async (req, res) => {
  const { chatId } = req.body;

  try {
    // Envoie un message avec bouton "Partager le numéro"
    const response = await axios.post(`https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage`, {
      chat_id: chatId,
      text: 'Cliquez pour partager votre numéro et recevoir un OTP :',
      reply_markup: {
        keyboard: [[{ 
          text: "📞 Partager mon numéro", 
          request_contact: true 
        }]],
        one_time_keyboard: true,
        resize_keyboard: true
      }
    });

    res.json(response.data);
  } catch (err) {
    console.error(err.response?.data);
    res.status(500).json({ success: false });
  }
});
router.post('/send-otp-telegram', async (req, res) => {
  const { chatId } = req.body; // À récupérer quand l'utilisateur commence à discuter avec le bot
  const otp = Math.floor(100000 + Math.random() * 900000).toString();

  try {
    const response = await axios.post(`https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage`, {
      chat_id: chatId,
      text: `Votre code OTP est : ${otp}`
    });
    res.json(response.data);
  } catch (err) {
    console.error(err.response?.data);
    res.status(500).json({ success: false });
  }
});


module.exports = router;
 */