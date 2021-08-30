const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const articleSchema = new Schema({
    name: String,
    topic: String,
    date: String,
    authorId:String
})
module.exports = mongoose.model('Articles',articleSchema);