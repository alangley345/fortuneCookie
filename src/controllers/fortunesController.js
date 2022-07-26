const fortunesModel = require("../models/fortunesModel");

//single fortune
const getNewFortune = async (req, res, next) => {
    var fortune = await fortunesModel.getNewFortune();
    try {
        res.json(fortune);
    }
    catch {
        res.status(500)
    }
}

//all fortunes
const getAllFortunes = async (req, res, next) => {
    var fortunes = await fortunesModel.getAllFortunes();
    try {
        res.json(fortunes);
    }
    catch {
        res.status(500)
    }
}

//add new fortune
const addNewFortune = async (req, res, next) => {
    var fortuneData = {
        content: "Love is in the air!",
        contributor: "Aaron Langley"
    };
    await fortunesModel.addNewFortune(fortuneData);
    //next();
    
}

//exports
exports.getNewFortune  = getNewFortune;
exports.getAllFortunes = getAllFortunes;
exports.addNewFortune  = addNewFortune;