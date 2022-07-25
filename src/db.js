var mongoose = require('mongoose');

//variables
var path         = require('path'); require('dotenv').config({path:
    path.join(__dirname,'.env') });
var dbUserPsswd  = process.env.FORTUNE_COOKIE_DB_PSSWD
var dbUser       = 'fortunecookie'
var dbName       = 'FortuneCookieApp'
var url          = 'mongodb+srv://' + dbUser + ':' + dbUserPsswd + '@mysharedcluster.dcfx1z7.mongodb.net/' + dbName

//mongodbatlas connection
function initDB(){
    mongoose.connect(url)
    var dbConnection = mongoose.connection;
    dbConnection.on('connected', function() {
      console.log('Successfully connected to database!');
    });
}

module.exports = {
    initDB,
};