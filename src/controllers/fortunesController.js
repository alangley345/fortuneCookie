const fortuneModel = require("../models/fortunes");

exports.getfortunesController = (req, res, next) =>  {
    const fortunes = fortunesModel.getFortunes();
    res.json(fortunes);
}