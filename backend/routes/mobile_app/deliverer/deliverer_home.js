const express = require('express');
const path = require('path');
require('dotenv').config({ path: __dirname + './../../../env' });
const bodyParser = require('body-parser');
const db = require("../../../dbConnexion");
const authenticate = require('../../auth/utils/verify_jwt');

const router = express.Router();  
router.use(bodyParser.json());

router.get('/home', authenticate, (req, res) => {
  const { id } = req.user;
  console.log(req.user); // Extract the deliverer ID from the JWT token
  console.log('Deliverer ID from JWT:', id); // 👈 Log the deliverer ID for debugging
  const query = `
    SELECT COUNT(Delivery.idOrd) AS totalOrders,
           SUM(delivPriceOrd) AS totalProfit,
           statusDel as status
    FROM Deliverer
    JOIN Delivery ON Delivery.idDel = Deliverer.idDel
    JOIN CustomerOrder ON Delivery.idOrd = CustomerOrder.idOrd
    WHERE Delivery.idDel = ?;
  `;

  db.query(query, [id], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ error: 'Database error' });
    }

    const { totalOrders, totalProfit, status } = results[0];

    if (totalOrders === null) {
      return res.status(404).json({ error: 'No orders found for this deliverer' });
    }

    const responseData = {
      delivererId: id,
      status: status ?? 0,
      orders: totalOrders ?? 0,
      profit: totalProfit ?? 0.0,
    };

    console.log('Deliverer /home response:', responseData); // 👈 Log before sending
    res.json(responseData);
  });
});
router.put('/home', authenticate, (req, res) => {
  const { id } = req.user;
  const { status } = req.body;  

  console.log('Received status update:', status);  

  const query = `
    UPDATE Deliverer
    SET statusDel = ?
    WHERE idDel = ?;
  `;

  db.query(query, [status, id], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ error: 'Database error' });
    }

    if (results.affectedRows === 0) {
      return res.status(404).json({ error: 'Deliverer not found' });
    }

    console.log('Status updated successfully'); // 👈 Log success message
    res.json({ message: 'Status updated successfully' });
  });
});
module.exports = router;
