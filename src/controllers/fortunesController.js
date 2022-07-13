const fortunesModel = require("../models/fortunesModel");

exports.getFortunesController = (req, res, next) =>  {
    const fortunes = fortunesModel.getAllFortunes();
    res.json(fortunes)
}