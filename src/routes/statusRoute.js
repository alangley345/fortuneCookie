var express = require('express');
var router  = express.Router();

router.get("*", function(req, res, next) {
    res.status(404).send('<h1>404! Page not found</h1>');
});

module.exports = router;
