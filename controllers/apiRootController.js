var express = require('express');
var router = express.Router();

router.get('/', function (req, res, next) {
    res.send('This is the root, look in the correct spot probably');
});

module.exports = router;