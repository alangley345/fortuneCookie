var mongoose     = require("mongoose");

//variables
var path         = require('path'); require('dotenv').config({path:
    path.join(__dirname,'.env') });
var dbUserPsswd  = process.env.FORTUNE_COOKIE_DB_PSSWD
var dbUser       = 'fortunecookie'
var dbName       = 'FortuneCookieApp'
var url          = 'mongodb+srv://' + dbUser + ':' + dbUserPsswd + '@mysharedcluster.dcfx1z7.mongodb.net/' + dbName

//mongodbatlas connection
mongoose.connect(url)
var dbConnection = mongoose.connection;
dbConnection.on('connected', function() {
  console.log('Successfully connected to database!');
});

//schema
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

const getAllFortunes = async () => {
    var fortune = await fortunesModel.find().lean();
    return fortune  
}

//exports
exports.getNewFortune  = getNewFortune;
exports.getAllFortunes = getAllFortunes;



