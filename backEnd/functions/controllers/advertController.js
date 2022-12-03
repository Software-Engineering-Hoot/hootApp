const Advert = require("../models/advertModel.js");
const createAdvert = (req, res) => {
    console.log('REQ BODY', req.body);

    const advert = Advert.create(req.body);
    res.status(201).json({
        succeded: true,
        advert,
    })
};
module.exports = createAdvert;