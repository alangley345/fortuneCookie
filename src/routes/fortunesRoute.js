var express = require('express');
var router  = express.Router();
const fortunesController = require("../controllers/fortunesController")

// GET listing of fortunes
router.get("/fortunes",fortunesController.getFortunesController());

module.exports = router;
