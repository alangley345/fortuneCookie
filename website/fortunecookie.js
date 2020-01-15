//hardcoded list of fortunes for now.
var fortunes = ["You will accomplish much today", "Take risks because you have luck on your side",
 "The best relationships are formed by listening and learning","Do you best for you", "Reach for the stars",];

//randomly selects array position from above string
let randomValue = fortunes[Math.floor(Math.random() * fortunes.length)]

document.getElementById("fortune").innerHTML = randomValue;