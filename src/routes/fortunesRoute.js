var express = require('express');
var router  = express.Router();

const fortunesController = require("../controllers/fortunesController");

// GET listing of fortunes
router.get("/new", fortunesController.getNewFortune);
router.get("/all", fortunesController.getAllFortunes);

module.exports = router;