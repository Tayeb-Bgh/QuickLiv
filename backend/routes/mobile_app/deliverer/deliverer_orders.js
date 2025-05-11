const express = require('express');
const path = require('path');
require('dotenv').config({ path: __dirname + './../../../env' });
const bodyParser = require('body-parser');
const db = require("../../../dbConnexion");
const authenticate = require('../../auth/utils/verify_jwt');

const router = express.Router();  
router.use(bodyParser.json());const bodyParser = require('body-parser');
const express = require('express');



module.exports = router;
