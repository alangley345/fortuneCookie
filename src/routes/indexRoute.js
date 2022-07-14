var express = require('express');
var router  = express.Router();

// GET listing of fortunes
router.get("/", function(req, res, next) {
    res.render("index",{title:"Fortune Cookie"})
});

module.exports = router;