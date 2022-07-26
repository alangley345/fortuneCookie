//var db           = require("../db.js");
//var mongoose     = require('mongoose')
//var bcrypt       = require('bcrypt');
//SALT_WORK_FACTOR = 10
//
//db.initDB();
//
////users schema
//var userSchema = new mongoose.Schema({
//    username: {
//        type: String,
//        required: [true, "Username can't be blank"],
//        match:  [/^[a-zA-Z0-9]+$/, 'is invalid'],
//        index: true
//    },
//    email: {
//        type: String,
//        required: [true, "Username can't be blank"],
//        match: [/\S+@\S+\.\S+/, 'is invalid'],
//        index: true
//    },
//    hash: {
//        type: String,
//        required: true,
//    },
//    salt: {
//        type: String,
//        required: true,
//    }}, 
//    {timestamps: true});
//
//var usersModel = mongoose.model('user',userSchema);
//
//get all fortunes in DB (Eventually need to paginate this)
//const addUser = async () => {
//    bcrypt.genSalt(SALT_WORK_FACTOR, function(err, salt) {
//        if (err) return next(err);
//
//    bcyrpt.hash(user.password, salt, function(err, hash) {
//        if (err) return next(err);
//        user.password = hash;
//        next();
//    });
//}

//exports
exports.addUser  = addUser;

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