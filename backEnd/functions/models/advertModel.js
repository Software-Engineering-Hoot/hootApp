const {Schema} = require('firefose');
const {SchemaTypes} = require('firefose');
const {String, Number, Array} = SchemaTypes;

const advertSchema = new Schema({
    headline: {
        type: String,
        required: true,
        trim: true
    },
    description: {
        type: String,
        required: true,
        trim: true
    },
    publishDate: {
        type: Date,
        default: Date.now
    },
    picture: {
        picUrl: String,
        required: true
    },
    petType: {
        type: String,

    }
});

const {Model} = require('firefose');
const router = require('../routes/advertRoute');
const Advert = new Model("Advert", advertSchema);

module.exports = Advert;
