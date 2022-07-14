var express = require('express');
var router  = express.Router();

// GET listing of fortunes
fortunesController = require("../controllers/fortunesController");
router.get("/", fortunesController.getFortunesController);

module.exports = router;