var express = require('express');
var router  = express.Router();

fortunesController = require("../controllers/fortunesController");
// GET listing of fortunes
router.get("/all", fortunesController.getAllFortunes);
// GET single fortune
router.get("/new", fortunesController.getNewFortune);

module.exports = router;