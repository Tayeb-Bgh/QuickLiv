const express = require('express')
const router = express.Router()
const db = require('../../../dbConnexion')
const authenticate = require('../../auth/utils/verify_jwt')

/* router.get("/",authenticate,(req,res)=>{
    const idCust = req.user.id;
    const query = 'SELECT o.* FROM CustomerOrder o JOIN Cart c ON o.idCartOrd=c.idCart WHERE c.idCustOrd = ?';


})
 */
module.exports=router;