const express = require('express')
const db = require('../../../dbConnexion');
const router = express.Router();

router.get('/:id/products', (req, res) => {

    const { params: { id } } = req

    if(!id)
        res.status(400).send({err:"Bad Request"})

    const query = `SELECT pb.idProd,pb.idBusns,pb.qttyProdBusns,pb.reducRateProdBusns,pb.priceProdBusns
                    FROM ProductBusiness pb
                    JOIN Product p ON pb.idProd = p.idProd
                    WHERE pb.idBusns = ?`

    const params = [id]

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
    console.log(idProd)

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

router.get('/:id/categories', (req, res) => {

    const { params: { id } } = req

    if(!id)
        return res.status(400).send({err:"Bad Request"})

    
    const query = `SELECT DISTINCT p.categoryProd 
                    FROM Product p 
                    JOIN ProductBusiness pb ON pb.idProd = p.idProd    
                    JOIN Business b ON pb.idBusns = b.idBusns
                    WHERE b.idBusns = ?`

    const params = [id]

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

router.get('/:id/categories/:category/second-categories', (req, res) => {

    const { params: { id, category } } = req
    
    if(!id || !category)
        res.status(400).send({err:"Bad Request"})

    const parsedCat = category.includes('-') ? category.replaceAll('-',' ') : category

    const params = [id,parsedCat]


    const query = `SELECT DISTINCT p.secondCategoryProd 
                    FROM Product p 
                    JOIN ProductBusiness pb ON pb.idProd = p.idProd    
                    JOIN Business b ON pb.idBusns = b.idBusns
                    WHERE pb.idBusns = ? AND TRIM(LOWER(p.categoryProd)) = TRIM(LOWER(?))`

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




module.exports = router;