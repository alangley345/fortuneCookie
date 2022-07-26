var db           = require("../db.js");
var mongoose     = require('mongoose')
//var bcrypt       = require('bcrypt');
//SALT_WORK_FACTOR = 10
db.initDB();

//users schema
var userSchema = new mongoose.Schema({
    username: {
        type: String,
        required: [true, "Username can't be blank"],
        match:  [/^[a-zA-Z0-9]+$/, 'is invalid'],
        index: true
    },
    email: {
        type: String,
        required: [true, "Email can't be blank"],
        match: [/\S+@\S+\.\S+/, 'is invalid'],
        index: true
    },  
    hash: {
        type: String,
        required: true,
    },
    salt: {
        type: String,
        required: true,
    }}, 
    {timestamps: true});

var usersModel = mongoose.model('users',userSchema);

//get all fortunes in DB (Eventually need to paginate this)
const addNewUser = async (userData) => {
    var newUser = new usersModel(userData);
    await newUser.save();
}

//exports
exports.addNewUser  = addNewUser;

//userSchema.pre(save, function(next) {
//    var user = this;
//if (!user.isModified('password')) return next();
//
//
//userSchema.methods.comparePassword = function(candidatePassword, cb) {
//    bcrypt.compare(candidatePassword, this.password, function(err, isMatch) {
//        if (err) return cb(err);
//        cb(null, isMatch);
//    });
//};
//