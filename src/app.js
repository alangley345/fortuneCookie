const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;
const bootstrap = require("./src/bootstrap");

bootstrap(app, router);

app.listen(PORT,console.log("Server started on port: " + PORT));