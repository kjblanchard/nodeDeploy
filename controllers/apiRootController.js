var express = require('express');
var deployment = require('../deploy')
var router = express.Router();

router.get('/', function (req, res, next) {

    res.send('Request received, starting deployment');
    deployment.DeployQuoteGen('theImageName','deploymentName','no','theSiteName')
});

module.exports = router;