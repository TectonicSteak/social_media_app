const mong = require("mongoose");
const express = require("express");
const app = express();
require("dotenv").config();

const connection = mong
  .connect(process.env.MONGO_URL)
  .then((result) => {
    app.listen(5000);
    console.log("Connected To MongoDB");
  })
  .catch((err) => console.log(err));

module.exports = mong;