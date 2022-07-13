const fortuneModel = require("../models/fortuneModel");

exports.getfortunesController = (req, res, next) =>  {
    const fortunes = fortunesModel.getFortunes();
    res.json(fortunes);
}