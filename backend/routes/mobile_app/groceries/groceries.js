const express = require('express');
const db = require('../../../dbConnexion');
const router = express.Router();

const getAssciatedDayNumber = require('./utils/get_current_day');

router.get("/",(req,res)=>{

    const {wilaya,city} = req.query;
    const currDayNbr = getAssciatedDayNumber();

    console.log('blablabla')

    // ! AND hourOpenBusns <= CURRENT_TIME AND hourCloseBusns >= CURRENT_TIME
    const query = `SELECT idBusns,nameBusns,typeBusns,categoryBusns,imgUrlBusns,vidUrlBusns,latBusns,lngBusns
                   FROM Business
                   WHERE typeBusns = ? AND dayOffBusns != ?`;
    db.query(query, ['grocery',currDayNbr,wilaya], async (err, results) => {
        if (err) throw err;

        if (results.length > 0) {
             res.status(200).json(results);
        } else {
            res.status(404).json({ message: 'No grocery found' });
        }
    });
})

module.exports = router