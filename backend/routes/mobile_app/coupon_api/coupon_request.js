
require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const db = require('../../../dbConnexion');
const authenticate = require('../../auth/utils/verify_jwt');

const router = express.Router();

router.use(bodyParser.json());


router.post('/createcoupon', authenticate, async (req, res) => {

  const client_id = req.user.id;

  const { reducRateCoupon,
    reducCodeCoupon,
    isUsedCoup, } = req.body;


  if (!reducRateCoupon || !reducCodeCoupon || isUsedCoup === undefined) {
    return res.status(400).json({
      success: false,
      message: "Le code et le taux de réduction sont requis"
    });
  }

  const query = `
    INSERT INTO Coupon (reducRateCoupon, reducCodeCoupon, isUsedCoup, idCustCoupon) 
    VALUES (?, ?, ?, ?)
  `;

  try {
    db.query(
      query,
      [reducRateCoupon, reducCodeCoupon, isUsedCoup, client_id],
      (err, results) => {
        if (err) {
          console.error("Erreur lors de la création du coupon:", err);
          return res.status(500).json({
            success: false,
            message: "Erreur lors de la création du coupon",
            error: err.message
          });
        }


        return res.status(201).json({
          success: true,
          message: "Coupon créé avec succès",
          couponId: results.insertId
        });
      }
    );
  } catch (error) {
    console.error('Erreur lors de la création du coupon:', error);
    res.status(500).json({ error: 'Erreur lors de la création du coupon.' });
  }
});

module.exports = router;