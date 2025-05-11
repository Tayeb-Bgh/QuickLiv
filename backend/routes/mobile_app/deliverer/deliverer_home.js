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
  console.log(req.user); 
  console.log('Deliverer ID from JWT:', id);  
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

    console.log('Deliverer /home response:', responseData);  
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

    console.log('Status updated successfully');     res.json({ message: 'Status updated successfully' });
  });
});
router.get('/orders',authenticate, (req, res) => {
  const query = `SELECT idOrd,custLatOrd,custLngOrd,createdAtOrd,weightCatOrd
  ,delivPriceOrd,transNbrOrd,idCust,firstNameCust,lastNameCust,phoneCust,
  idBusns,nameBusns,phoneBusns,latBusns,lngBusns,imgUrlBusns
  
  FROM CustomerOrder join Cart on idCartOrd = idCart 
  join Customer on idCustCart = idCust 
  join  Business on idBusnsCart = idBusns
  WHERE statusOrd = 0`;

  db.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching orders:', err);
      return res.status(500).json({ error: 'Database query failed' });
    }

    res.status(200).json(results);
  });
});

router.put('/orders/:idOrd',authenticate, (req, res) => {
  const { idOrd } = req.params;
  const { statusOrd } = req.body;

  const query = `UPDATE CustomerOrder SET statusOrd = ? WHERE idOrd = ?`;

  db.query(query, [statusOrd, idOrd], (err, results) => {
    if (err) {
      console.error('Error updating order:', err);
      return res.status(500).json({ error: 'Database query failed' });
    }
    res.status(200).json({ message: 'Order updated successfully', results });
  });
});
router.get('/order/products/:idOrd',authenticate, (req, res) => {
  const { idOrd } = req.params;

  const query = `
    SELECT Product.idProd, nameProd, unitPriceProdCart, qttyProdCart, unitProd
    FROM CustomerOrder 
    JOIN Cart ON idCartOrd = idCart
    JOIN ProductCart ON ProductCart.idCart = Cart.idCart
    JOIN Product ON Product.idProd = ProductCart.idProd 
    WHERE idOrd = ?
  `;
  console.log('ur are caling for the list of products')
  db.execute(query, [idOrd], (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: 'Database error' });
    }
    
     
    res.json({ products: results });
  });
});
 



module.exports = router;
