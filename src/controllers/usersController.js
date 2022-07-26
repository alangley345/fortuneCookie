const usersModel = require('../models/usersModel');

//add new user
const addNewUser = async (req, res, next) => {
    //test users
    var userData = {
        username: "test",
        email: "testemail@email.net",
        hash: "password",
        salt: "yes please"
    };

    await usersModel.addNewUser(userData);
    //next();
    
}

//exports
exports.addNewUser = addNewUser;