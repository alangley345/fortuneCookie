const express   = require("express");
const app       = express();
const router    = express.Router()
const PORT      = 3000;
const bootstrap = require("./src/bootstrap.js");

app.use(router)
bootstrap(app, router );
app.listen(PORT,console.log("Server started on port: " + PORT));

router.get("/",(req, res, next) => {
  return res.send("Welcome to Fortune Cookie!")
})