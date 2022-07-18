const fortunesModel = require("../models/fortunesModel");

//calls to model
module.exports={

    getNewFortune:function(req, res){
        fortunesModel.getNewFortune(function(fortune){
            res.json(fortune)
        })
    }
}

exports.getAllFortunes = (req, res, next) =>  {
    const fortunes = fortunesModel.getAllFortunes();
    res.json(fortunes);
}