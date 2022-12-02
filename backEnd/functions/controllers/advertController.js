import Advert from "../models/advertModel.js";

const createAdvert = (req, res) => {
    const advert = Advert.create(req.body);
    res.status(201).json({
        succeded: true,
        advert
    })
};

export {createAdvert};