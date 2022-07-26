var express = require('express');
var router  = express.Router();

const fortunesController = require("../controllers/fortunesController");
const usersController    = require("../controllers/usersController")

// GET listing of fortunes
router.get("/fortunes/new", fortunesController.getNewFortune);
router.get("/fortunes/all", fortunesController.getAllFortunes);

var fortuneData = {
    content: "People in glass houses shouldn't throw stones.",
    contributor: "Aaron Langley"
};

// POST new fortune
router.post("/fortunes/add", fortunesController.addNewFortune);

// POST new fortune
router.post("/users/add", usersController.addNewUser);

module.exports = router;