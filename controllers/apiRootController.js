var express = require('express');
var deployment = require('../deploy')
var router = express.Router();

router.get('/', function (req, res, next) {

    deployment.DeployQuoteGen('','','','')
    res.send('This is the root, look in the correct spot probably');
});

module.exports = router;