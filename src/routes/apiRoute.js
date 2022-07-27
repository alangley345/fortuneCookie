var express = require('express');
var router  = express.Router();

const fortunesController = require("../controllers/fortunesController");
const usersController    = require("../controllers/usersController")

// GET listing of fortunes
router.get("/fortunes/new", fortunesController.getNewFortune);
router.get("/fortunes/all", fortunesController.getAllFortunes);

var fortuneData = {
    content: "You have to climb a hill before coasting down.",
    contributor: "Aaron Langley"
};

// POST new fortune
router.post("/fortunes/add", async (req,res) => {
    fortunesController.addNewFortune(fortuneData);
}) ;

// POST new fortune
router.post("/users/add", function(req, res) {
    usersController.addNewUser();
});

module.exports = router;