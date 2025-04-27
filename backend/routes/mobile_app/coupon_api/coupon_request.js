
require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const db = require('../../../dbConnexion');
const authenticate = require('../../auth/utils/verify_jwt');

const router = express.Router();

router.use(bodyParser.json());


router.post('/create-coupon', authenticate, async (req, res) => {

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

router.get('/get-client-point', authenticate, async (req, res) => {

  try {
    const client_id = req.user.id;
    const query = "SELECT pointsCust FROM Customer WHERE idCust = ?";

    db.query(query, [client_id], (err, results) => {
      if (err) {
        console.error('Database error:', err);
        return res.status(500).json({
          success: false,
          message: 'Error retrieving customer points',
          error: err.message
        });
      }

      if (results.length === 0) {
        return res.status(404).json({
          success: false,
          message: 'Customer not found'
        });
      }


      return res.status(200).json({
        success: true,
        message: 'Customer points retrieved successfully',
        data: {
          pointsCust: results[0].pointsCust
        }
      });
    });
  } catch (error) {
    console.error('Server error:', error);
    return res.status(500).json({
      success: false,
      message: 'Internal server error',
      error: error.message
    });
  }
});



router.put('/update-client-point', authenticate, async (req, res) => {
  try {
    const client_id = req.user.id;;

    const { pointsCust } = req.body;


    if (pointsCust === undefined) {
      return res.status(400).json({
        success: false,
        message: 'Points value is required'
      });
    }

    if (typeof pointsCust !== 'number' || pointsCust < 0) {
      return res.status(400).json({
        success: false,
        message: 'Points value must be a positive number'
      });
    }
    const updateQuery = "UPDATE Customer SET pointsCust = ? WHERE idCust = ?";

    db.query(updateQuery, [pointsCust, client_id], (err, results) => {
      if (err) {
        console.error('Database error:', err);
        return res.status(500).json({
          success: false,
          message: 'Error updating customer points',
          error: err.message
        });
      }

      if (results.affectedRows === 0) {
        return res.status(404).json({
          success: false,
          message: 'Customer not found or no changes made'
        });
      }

      return res.status(200).json({
        success: true,
        message: 'Customer points updated successfully',
        data: {
          pointsCust: pointsCust
        }
      });
    });
  } catch (error) {
    console.error('Server error:', error);
    return res.status(500).json({
      success: false,
      message: 'Internal server error',
      error: error.message
    });
  }
});

module.exports = router;