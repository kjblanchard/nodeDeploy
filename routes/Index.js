const express = require('express');
const router = express.Router();

const apiRoute = require('../controllers/apiRootController');

router.use(function (req, res, next) {
  next()
})

router.use('/api', apiRoute);

module.exports = router;