require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');

const axios = require('axios');

const router = express.Router();

router.use(bodyParser.json());



router.post('/delivery-type', async (req, res) => {
  
  const { items } = req.body;

  if (!items || !Array.isArray(items)) {
    return res.status(400).json({ error: 'Le champ items est requis et doit être un tableau.' });
  }

  try {
    const prompt = `
Tu es une intelligence artificielle experte en logistique. En te basant uniquement sur les noms des produits et leur quantité, détermine si une commande peut être livrée en scooter ou nécessite une voiture. Sois logique en imaginant la taille/volume/poids typique de chaque produit.

Voici la liste :
${items.map(item => `- ${item.quantity} ${item.unit ? "grammes" : "unités"}  x ${item.name}`).join('\n')}

Répond uniquement par : "scooter" pour scooter ou "car" pour voiture, sans phrase supplémentaire.
    `.trim();
    
    const response = await axios.post(
      'https://api.mistral.ai/v1/chat/completions',
      {
        model: 'mistral-medium', // ou mistral-small / mistral-tiny
        messages: [
          { role: 'system', content: 'Tu es un assistant logistique intelligent.' },
          { role: 'user', content: prompt }
        ],
        temperature: 0.3,
      },
      {
        headers: {
          'Authorization': `Bearer ${process.env.MISTRAL_API_KEY}`,
          'Content-Type': 'application/json',
        }
      }
    );

    const result = response.data.choices[0].message.content.trim().toLowerCase();
    res.json({ deliveryMethod: result });

  } catch (error) {
    console.error('Erreur API Mistral:', error.response?.data || error.message);
    res.status(500).json({ error: 'Erreur lors de la communication avec l’IA.' });
  }
});


module.exports = router;
