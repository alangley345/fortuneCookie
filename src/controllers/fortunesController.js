const fortunesModel = require("../models/fortunesModel");

exports.getAllFortunes = (req, res, next) =>  {
    const fortunes = fortunesModel.getAllFortunes();
    res.json(fortunes);
};

exports.getNewFortune = (req, res, next) =>  {
    const fortunes = fortunesModel.getNewFortune();
    res.json(fortunes);
};