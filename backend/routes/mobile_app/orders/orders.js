const express = require('express');
const router = express.Router();
const db = require('../../../dbConnexion');
const authenticate = require('../../auth/utils/verify_jwt');

router.get("/details/:id", (req, res) => {
    const orderId = req.params.id;

    // Première requête pour les infos de base de la commande
    const queryOrder = `
        SELECT 
            o.idOrd as id,
            o.statusOrd as status,
            o.createdAtOrd as createdAt,
            o.delivPriceOrd as deliveryPrice,
            o.ratingBusnsOrd as ratingBusns,
            o.ratingDelOrd as ratingDel,
            o.custLatOrd as customerLat,
            o.custLngOrd as customerLng,
            o.delLatOrd as delivererLat,
            o.transNbrOrd as paymentMethod,
            o.delLngOrd as delivererLng,
            c.reducRateCoupon as discountRate,
            (SELECT SUM(pc.unitPriceProdCart * pc.qttyProdCart) 
             FROM ProductCart pc WHERE pc.idCart = o.idCartOrd) as totalAmount,
            o.idCartOrd as cartId
        FROM CustomerOrder o
        LEFT JOIN Coupon c ON o.idCouponOrd = c.idCoupon
        WHERE o.idOrd = ?
    `;

    db.query(queryOrder, [orderId], (err, orderRows) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ error: 'Database error' });
        }

        if (orderRows.length === 0) {
            return res.status(404).json({ error: 'Order not found' });
        }

        const order = orderRows[0];
        const priceWithReduc = order.discountRate 
            ? order.totalAmount * (1 - order.discountRate / 100)
            : null;

        // Requête pour les infos du business
        const queryBusiness = `
            SELECT 
                b.idBusns as id,
                b.nameBusns as name,
                b.imgUrlBusns as imgUrl
            FROM Cart c
            JOIN Business b ON c.idBusnsCart = b.idBusns
            WHERE c.idCart = ?
        `;

        db.query(queryBusiness, [order.cartId], (err, businessRows) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ error: 'Database error' });
            }

            const business = businessRows[0] ? {
                id: businessRows[0].id,
                name: businessRows[0].name,
                imgUrl: businessRows[0].imgUrl
            } : null;

            // Requête pour les produits
            const queryProducts = `
                SELECT 
                    p.idProd as id,
                    p.nameProd as name,
                    pc.unitPriceProdCart as price,
                    pc.qttyProdCart as quantity,
                    p.unitProd as unit,
                    pc.noteProdCart as notice
                FROM ProductCart pc
                JOIN Product p ON pc.idProd = p.idProd
                WHERE pc.idCart = ?
            `;

            db.query(queryProducts, [order.cartId], (err, productRows) => {
                if (err) {
                    console.error('Database error:', err);
                    return res.status(500).json({ error: 'Database error' });
                }

                const products = productRows.map(p => ({
                    id: p.id,
                    name: p.name,
                    price: p.price,
                    quantity: p.quantity,
                    unit: p.unit,
                    notice: p.notice
                }));

                // Requête pour le livreur (seulement si nécessaire)
                deliverer = null
                if (order.delivererLat && order.delivererLng) {
                    const queryDeliverer = `
                        SELECT 
                            d.idDel as id,
                            d.firstNameDel as firstName,
                            d.lastNameDel as lastName,
                            d.phoneDel as phoneNumber,
                            d.imgUrlDel as imgUrl
                        FROM Delivery dl
                        JOIN Deliverer d ON dl.idDel = d.idDel
                        WHERE dl.idOrd = ?
                    `;

                    db.query(queryDeliverer, [orderId], (err, delivererRows) => {
                        if (err) {
                            console.error('Database error:', err);
                            return res.status(500).json({ error: 'Database error' });
                        }

                        deliverer = delivererRows[0] ? {
                            id: delivererRows[0].id,
                            firstName: delivererRows[0].firstName,
                            lastName: delivererRows[0].lastName,
                            phoneNumber: delivererRows[0].phoneNumber,
                            imgUrl: delivererRows[0].imgUrl
                        } : null;

                        sendResponse();
                    });
                } else {
                    sendResponse();
                }

                function sendResponse() {
                    
                    const completeOrder = {
                        id: order.id,
                        status: order.status,
                        createdAt: order.createdAt,
                        totalAmount: order.totalAmount,
                        priceWithReduc: priceWithReduc,
                        deliveryPrice: order.deliveryPrice,
                        paymentMethod: order.paymentMethod ? true : false,
                        business: business,
                        deliverer: deliverer,
                        products: products,
                        ratingBusns: order.ratingBusns,
                        ratingDel: order.ratingDel,
                        delivererLocation: order.delivererLat && order.delivererLng
                            ? { lat: order.delivererLat, lng: order.delivererLng }
                            : null,
                        customerLocation: { 
                            lat: order.customerLat, 
                            lng: order.customerLng 
                        },
                        pointWon: null
                    };
                    
                    res.json(completeOrder);
                }
            });
        });
    });
});

// ordersRoute.js
router.get("/customer-orders-ids", authenticate, async (req, res) => {
    const idCust = req.user.id;
    
    try {
        // Requête pour récupérer seulement les IDs des commandes du client
        db.query(`
            SELECT o.idOrd as id
            FROM CustomerOrder o
            JOIN Cart c ON o.idCartOrd = c.idCart
            WHERE c.idCustCart = ?
            ORDER BY o.createdAtOrd DESC
        `, [idCust],(err,orders)=>{
            console.log(orders)
            res.json(orders.map(order => order.id));
        });
        
    } catch (error) {
        console.error('Error fetching customer order IDs:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

module.exports = router;