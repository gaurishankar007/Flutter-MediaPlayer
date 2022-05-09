const mongoose = require("mongoose");

const likeSongSchema = new mongoose.Schema({
    user: {
        type: mongoose.Types.ObjectId, ref: 'user'
    },
    song: {
        type: mongoose.Types.ObjectId, ref: 'song'
    }
},
{
    timestamps: true
}
);

const likeSong = mongoose.model('likeSong', likeSongSchema);

module.exports = likeSong;