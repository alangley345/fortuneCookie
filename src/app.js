//requires statements
var createError  = require('http-errors');
var express      = require('express');
var path         = require('path');
var cookieParser = require('cookie-parser');
var logger       = require('morgan');
//var https        = require("https")
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

//define router objects
var indexRouter    = require('./routes/indexRoute');
var fortunesRouter = require('./routes/fortunesRoute');
//const { connect } = require('http2');

var app = express();

// view engine setup
app.set('view engine', 'pug');
app.set('views', __dirname + "/views");

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

//routes
app.use('/', indexRouter);
app.use('/fortunes', fortunesRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;