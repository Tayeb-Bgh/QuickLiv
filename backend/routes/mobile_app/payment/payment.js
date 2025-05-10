const express = require('express')
const router = express.Router()
const db = require("../../../dbConnexion")
const authenticate = require('../../auth/utils/verify_jwt')

router.get("/coupons", authenticate, (req, res) => {

    const { id } = req.user

    if (!id)
        return res.status(400).json({ status: "Error", error: "Bad request", message: "user id required" })

    const query = `SELECT * FROM Coupon
                    WHERE idCustCoupon = ? AND isUsedCoup = ?`


    const params = [id, 0]

    db.query(query, params, (err, results) => {

        if (err)
            return res.status(500).json({ status: "Error", error: "Internal server error" })

        if (results.length > 0)
            return res.status(200).json(results)
        else
            return res.status(404).json({ status: "Error", error: "Not found", message: "No coupons found" })
    })

})

router.put("/coupons/:couponId", authenticate, (req, resp) => {

    const {id} = req.user;
     if (!id)
        return resp.status(400).json({ status: "Error", error: "Bad request", message: "user id required" })

    const { couponId } = req.params

    console.log("aaaaaaaaa")

    const query = ` UPDATE Coupon SET isUsedCoup = ?
                    WHERE idCoupon = ?`
    console.log(query)

    const params = [1, couponId]

    db.query(query, params, (err, results) => {
        if (err)
            return resp.status(500).json({ status: "error", error: "Internal server error.", message: "An error has occured internally, please retry later." })

        if (results.affectedRows > 0) {
            return resp.status(200).json({ status: "success", message: `Coupon updated succesfully for customer ${req.user.id}` })
        }
        else
            return resp.status(400).json({ status: "error", error: "Bad request", message: `Failed to update coupon for customer ${req.user.id}` })
    })

})

router.post("/carts", authenticate, (req, resp) => {

    const { id } = req.user
    const { idBusnsCart } = req.body

    if (!id || !idBusnsCart)
        return resp.status(400).json({ status: "error", error: "Bad request", message: "Business id and customer id are required." })

    const query = `INSERT INTO Cart(idCustCart,idBusnsCart)
                    VALUES(?,?)`

    const params = [id, idBusnsCart]

    db.query(query, params, (err, results) => {
        if (err)
            return resp.status(500).json({ status: "error", error: "Internal server error.", message: "An error has occured internally, please retry later." })

        if (results.affectedRows > 0) {
            const insertedId = results.insertId;
            return resp.status(201).json({ id: insertedId, status: "success", message: `Cart added succesfully for customer ${id}` })
        }
        else
            return resp.status(400).json({ status: "error", error: "Bad request", message: `Failed to add cart for customer ${id}` })
    })

})

router.post("/carts/product-cart", (req, resp) => {

    console.log("gros caca sa mèèèèèèèère")
    const { idProd, idCart, unitPriceProdCart, qttyProdCart, noteProdCart } = req.body

    if (!idProd || !idCart || !qttyProdCart || !unitPriceProdCart) {
        return resp.status(400).json({ status: "error", error: "Bad request", message: "Product id and cart id and unit and quantity are required." })
    }
    const query = `INSERT INTO ProductCart(idProd,idCart,unitPriceProdCart,qttyProdCart,noteProdCart)
                    VALUES(?,?,?,?,?)`

    const params = [idProd, idCart, unitPriceProdCart, qttyProdCart, noteProdCart]

    db.query(query, params, (err, results) => {
        console.log(`${results}`)
        if (err) {
            return resp.status(500).json({ status: "error", error: "Internal server error.", message: "An error has occured internally, please retry later." })
        }

        if (results.affectedRows > 0) {
            return resp.status(201).json({ status: "success", message: `Product added succesfully for cart ${idCart}` })
        }
        else
            return resp.status(400).json({ status: "error", error: "Bad request", message: `Failed to add product for cart ${idCart}` })
    })

})

router.post("/orders", (req, resp) => {

    const { idCartOrd, idCouponOrd, statusOrd, delivPriceOrd, weightCatOrd, transNbrOrd, ratingDelOrd, ratingBusnsOrd, custLatOrd, custLngOrd, delLatOrd, delLngOrd, cancelCustOrd, cancelDelOrd } = req.body

    if (!idCartOrd || !weightCatOrd || !custLatOrd || !custLngOrd || !delivPriceOrd) {
        console.log(`${idCartOrd} ${weightCatOrd} ${custLatOrd} ${custLngOrd} ${delivPriceOrd}`)
        return resp.status(400).json({ status: "error", error: "Bad request", message: "Cart's id and weight and delivery price and curstomer's position are required." })
    }
    const query = `INSERT INTO CustomerOrder(idCartOrd,idCouponOrd,statusOrd,delivPriceOrd,weightCatOrd,transNbrOrd,ratingDelOrd,ratingBusnsOrd,custLatOrd,custLngOrd,delLatOrd,delLngOrd,cancelCustOrd,cancelDelOrd)
                    VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)`
    const params = [idCartOrd, idCouponOrd, statusOrd, delivPriceOrd, weightCatOrd, transNbrOrd, ratingDelOrd, ratingBusnsOrd, custLatOrd, custLngOrd, delLatOrd, delLngOrd, cancelCustOrd, cancelDelOrd]

    db.query(query, params, (err, results) => {
        console.log("REEEEES" + results);
        console.log("REEEEES" + err);
        if (err)
            return resp.status(500).json({ status: "error", error: "Internal server error.", message: "An error has occured internally, please retry later." })

        if (results.affectedRows > 0) {
            return resp.status(201).json({ status: "success", message: `Order added succesfully for cart ${idCartOrd}` })
        }
        else
            return resp.status(400).json({ status: "error", error: "Bad request", message: `Failed to add order for cart ${idCartOrd}` })
    })

})


module.exports = router