var express = require('express');
var router  = express.Router();

const fortunesController = require("../controllers/fortunesController");

// GET listing of fortunes
router.get("/fortunes/new", fortunesController.getNewFortune);
router.get("/fortunes/all", fortunesController.getAllFortunes);

// POST new fortune
router.post("/fortunes/add", fortunesController.addNewFortune);


module.exports = router;