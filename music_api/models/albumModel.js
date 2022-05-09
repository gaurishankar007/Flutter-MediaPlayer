const mongoose = require("mongoose");

const albumSchema = new mongoose.Schema({
    title: {
        type: String
    }
},
{
    timestamps: true
}
);

const album = mongoose.model('album', albumSchema);

module.exports = album;