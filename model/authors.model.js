const mongoose = require('mongoose');
const Schema = mongoose.Schema

const authorSchema = new Schema({
    name: String,
    url: String,
    major: String
})
module.exports = mongoose.model('Authors',authorSchema);