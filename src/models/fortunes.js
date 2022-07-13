//hardcoded list of fortunes for now.
//TO DO - move to dedicated DB later

const fortunes = ["You will accomplish much today.", "Take risks because you have luck on your side.",
 "The best relationships are formed by listening and learning.","Do you best for you.", "Reach for the stars","Everyday begins with a new sunrise."];

//randomly selects array position
exports.getFortune = () => {
    //let randomValue = fortunes[Math.floor(Math.random() * fortunes.length)]
    return fortunes;
};


//document.getElementById("fortune").innerHTML = randomValue;