//hardcoded list of fortunes for now.
//TO DO - move to dedicated DB later

const { default: mongoose } = require("mongoose");

const fortunes = [
    {"id":1, content:"You will accomplish much today."},
    {"id":2, content:"Take risks because you have luck on your side."},
    {"id":3, content:"The best relationships are formed by listening and learning."},
    {"id":4, content:"Do you best for you."},
    {"id":5, content:"Reach for the stars"},
    {"id":6, content:"Everyday begins with a new sunrise."}
];

var fortunesSchema = new mongoose.Schema({
    content: String,
    contributor: String
})

var fortunesModel = mongoose.model('fortunes',fortunesSchema)

exports.getNewFortune = () => {
    const fortune = fortunesModel.findOne();
};

//exports.getAllFortunes = () => {
//    return fortunes;
//};

//exports.getNewFortune = () => {
//  const randomFortune = fortunes[Math.floor(Math.random() * fortunes.length)];
//  return randomFortune
//};