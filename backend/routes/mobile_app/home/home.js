const express = require('express')
const db = require('../../../dbConnexion');
const router = express.Router();

router.get('/businesses/:id/products', (req, res) => {

    const { params: { id } } = req

    if(!id)
        res.status(400).send({err:"Bad Request"})

    const query = `SELECT pb.idProd,pb.idBusns,pb.reducRateProdBusns
                    FROM ProductBusiness pb
                    JOIN Product p ON pb.idProd = p.idProd
                    WHERE pb.idBusns = ? AND reducRateProdBusns >= ?`

    const params = [id,30]

    db.query(query,params,(err,results)=>{
        if (err) {
            console.error("Database error:", err);
            return res.status(500).json({ error: "Internal server error" });
        }

        if(results && results.length> 0){
            return res.status(200).json(results);
        } else {
            return res.status(404).json({ message: 'No categories found' })
        }

    })
})

router.get('/products/:idProd', (req, res) => {

    const { params: { idProd} } = req

    if(!idProd)
        res.status(400).send({err:"Bad Request"})

    const query = `SELECT p.idProd,p.nameProd,p.categoryProd,p.descProd,p.unitProd,p.imgUrlProd,p.secondCategoryProd
                    FROM Product p
                    WHERE p.idProd = ? AND p.deleteProd = ?`

    const params = [idProd,0]
    

    db.query(query,params,(err,results)=>{
        if (err) {
            console.error("Database error:", err);
            return res.status(500).json({ error: "Internal server error" });
        }

        if(results && results.length> 0){
            return res.status(200).json(results);
        } else {
            return res.status(404).json({ message: 'No product found' })
        }
    });


})







module.exports = router;