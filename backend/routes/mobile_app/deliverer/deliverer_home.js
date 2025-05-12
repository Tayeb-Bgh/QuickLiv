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
  
  const query = `SELECT idOrd,custLatOrd,custLngOrd,createdAtOrd,weightCatOrd,statusOrd
  ,delivPriceOrd,transNbrOrd,idCust,firstNameCust,lastNameCust,phoneCust,
  idBusns,nameBusns,phoneBusns,latBusns,lngBusns,imgUrlBusns,adrsBusns
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
router.put('/orders/:idOrd', authenticate, (req, res) => {
  const { idOrd } = req.params;
  const { statusOrd } = req.body;

  // Validate if statusOrd is provided
  if (!statusOrd) {
    return res.status(400).json({ error: 'statusOrd is required' });
  }

  console.log('Assigning order:', idOrd);
  console.log('User ID:', req.user.id);

  const query = `UPDATE CustomerOrder SET statusOrd = ? WHERE idOrd = ?`;
  
  db.query(query, [statusOrd, idOrd], (err, results) => {
    if (err) {
      console.error('Error updating order:', err);
      return res.status(500).json({ error: 'Database query failed' });
    }

    if (results.affectedRows === 0) {
      // No rows were updated, meaning the orderId might not exist
      return res.status(404).json({ error: 'Order not found' });
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
 


router.get('/order',authenticate, (req, res) => {
   const id = req.user.id;
  const query = `SELECT CustomerOrder.idOrd,statusOrd,custLatOrd,custLngOrd,createdAtOrd,weightCatOrd
  ,delivPriceOrd,transNbrOrd,idCust,firstNameCust,lastNameCust,phoneCust,
  idBusns,nameBusns,phoneBusns,latBusns,lngBusns,imgUrlBusns,adrsBusns
  FROM CustomerOrder join Cart on idCartOrd = idCart 
  join Customer on idCustCart = idCust 
  join  Business on idBusnsCart = idBusns
  join Delivery on CustomerOrder.idOrd = Delivery.idOrd
  WHERE idDel = ? AND ( statusOrd = 1 or statusOrd = 2 or statusOrd = 3)`;

  db.query(query,[id], (err, results)=> {
    if (err) {
      console.error('Error fetching orders:', err);
      return res.status(500).json({ error: 'Database query failed' });
    }

    res.status(200).json(results);
  });
});
router.post('/order/assign/:id', authenticate, (req, res) => {
  const { id: idOrd } = req.params;  
  const idDel = req.user.id;  

  const query = `INSERT INTO Delivery (idDel, idOrd) VALUES (?, ?)`;
  console.log('test is callinnggg')
  db.query(query, [idDel, idOrd], (err, result) => {
    if (err) {
      console.error('Error inserting into Delivery:', err);
      return res.status(500).json({ error: 'Database query failed' });
    }

    res.status(200).json({ message: 'Order successfully added to Delivery', result });
  });
});



router.put('/ordersLanLng/:idOrd', authenticate, (req, res) => {
  const { idOrd } = req.params;
  const { statusOrd } = req.body;
  const {lngDel,lanDel} = req.body;

  // Validate if statusOrd is provided
  if (!statusOrd) {
    return res.status(400).json({ error: 'statusOrd is required' });
  }

  console.log('Assigning order:', idOrd);
  console.log('User ID:', req.user.id);

  const query = `UPDATE CustomerOrder SET statusOrd = ? ,delLatOrd = ?, delLngOrd = ? WHERE idOrd = ?`;
  
  db.query(query, [statusOrd,  lanDel , lngDel,idOrd], (err, results) => {
    if (err) {
      console.error('Error updating order:', err);
      return res.status(500).json({ error: 'Database query failed' });
    }

    if (results.affectedRows === 0) {
      // No rows were updated, meaning the orderId might not exist
      return res.status(404).json({ error: 'Order not found' });
    }

    res.status(200).json({ message: 'Order updated successfully', results });
  });
});




module.exports = router;
