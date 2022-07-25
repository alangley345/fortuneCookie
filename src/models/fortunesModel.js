var db       = require("../db.js");
var mongoose = require('mongoose')
db.initDB();

//fortunes schema
var fortunesSchema = new mongoose.Schema({
    content: {
        type: String,
        required: true,
    },
    contributor: {
        type: String,
        required: true,
    }
})

//model
var fortunesModel = mongoose.model('fortunes',fortunesSchema);

//get a random new fortune
const getNewFortune = async () => {
    var count   = await fortunesModel.count();
    var random  = Math.floor(Math.random()*count);
    var fortune = await fortunesModel.findOne().skip(random).lean();
    return fortune  
}

//get all fortunes in DB (Eventually need to paginate this)
const getAllFortunes = async () => {
    var fortunes = await fortunesModel.find().lean();
    return fortunes  
}

//exports
exports.getNewFortune  = getNewFortune;
exports.getAllFortunes = getAllFortunes;