//requires statements
var createError  = require('http-errors');
var express      = require('express');
var path         = require('path');
var cookieParser = require('cookie-parser');
var logger       = require('morgan');

//define router objects
var indexRouter   = require('./routes/indexRoute');
var apiRouter     = require('./routes/apiRoute');
var statusRouter  = require('./routes/statusRoute');

var app = express();

// view engine setup
app.set('view engine', 'pug');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

//routes
app.use('/api', apiRouter);
app.use('/',indexRouter);
app.use(express.static(__dirname + '/dist/prod'));
app.all('*', statusRouter);
  
module.exports = app;