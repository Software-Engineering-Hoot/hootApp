const express = require("express");
const advertController = require("../controllers/advertController.js")

const router = express.Router();
router.post('/', function (req, res){
    advertController.createAdvert;
});

module.exports= router;