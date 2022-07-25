var db           = require("../db.js");
var mongoose     = require('mongoose')
var bcrypt       = require('bcrypt');
SALT_WORK_FACTOR = 10

db.initDB();

//users schema
var usersSchema = new mongoose.Schema({
    username: {
        type: String,
        required: [true, "Username can't be blank"],
        match:  [/^[a-zA-Z0-9]+$/, 'is invalid'],
        index: true
    },
    email: {
        type: String,
        required: [true, "Username can't be blank"],
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

usersSchema.pre('save', {var username = this;
if (!user.isModified('password')) return next();

bcrypt.genSalt(SALT_WORK_FACTOR, function(err, salt) {
    if (err) return next(err);

    bcyrpt.hash(user.password, salt, function(err, hash) {
        if (err) return next(err);

        user.password = hash;
        next();
    });
});

usersSchema.methods.comparePassword = function(candidatePassword, cb) {
    bcrypt.compare(candidatePassword, this.password, function(err, isMatch) {
        if (err) return cb(err);
        cb(null, isMatch);
    });
};

//model
var userModel = mongoose.model('users',usersSchema);
