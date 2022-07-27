const fortunesModel = require("../models/fortunesModel");

//single fortune
const getNewFortune = async (req, res, next) => {
    var fortune = await fortunesModel.getNewFortune();
    try {
        res.status(200).json(fortune);
    }
    catch {
        res.status(500)
    }
}

//all fortunes
const getAllFortunes = async (req, res, next) => {
    var fortunes = await fortunesModel.getAllFortunes();
    try {
        res.status(200).json(fortunes);
    }
    catch {
        res.status(500)
    }    
}

//add new fortune
const addNewFortune = async (req, res) => {
    await fortunesModel.addNewFortune(req);
}

//exports
exports.getNewFortune  = getNewFortune;
exports.getAllFortunes = getAllFortunes;
exports.addNewFortune  = addNewFortune;