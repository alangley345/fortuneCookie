var express = require('express');
var router  = express.Router();

// GET listing of fortunes
router.post("**", function(req, res, next) {
    res.status(300).send({ redirect:"/fortune"});
});

module.exports = router;