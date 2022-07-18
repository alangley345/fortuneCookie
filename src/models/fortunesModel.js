/*
const fortunes = [
    {"id":1, content:"You will accomplish much today."},
    {"id":2, content:"Take risks because you have luck on your side."},
    {"id":3, content:"The best relationships are formed by listening and learning."},
    {"id":4, content:"Do you best for you."},
    {"id":5, content:"Reach for the stars"},
    {"id":6, content:"Everyday begins with a new sunrise."}
];
*/
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

var fortunesModel = mongoose.model('fortunesModel',fortunesSchema)

module.exports={
    //return a single fortune
    getNewFortune: function(){
        fortunesModel.findOne({})
    }
}