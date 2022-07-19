const fortunesModel = require("../models/fortunesModel");

//calls to model
const getNewFortune = async (req, res, next) => {
    var fortune = await fortunesModel.getNewFortune();
    try {
        res.json(fortune);
    }
    catch {
        res.status(500)
    }
}

const getAllFortunes = async (req, res, next) => {
    var fortunes = await fortunesModel.getAllFortunes();
    try {
        res.json(fortunes);
    }
    catch {
        res.status(500)
    }
}
//exports
exports.getNewFortune  = getNewFortune;
exports.getAllFortunes = getAllFortunes;