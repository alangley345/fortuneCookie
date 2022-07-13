const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.listen(PORT,console.log("Server started on port: " + PORT));
app.use(express.static(__dirname + '/static'))

app.get('/',function(req,res) {
  res.send('index.html');
});