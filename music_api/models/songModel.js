const mongoose = require('mongoose');

const songSchema = new mongoose.Schema({
    title: {
        type: String
    },
    album: {
        type: mongoose.Types.ObjectId, ref: 'album'
    },
    music: {
        type: String
    },
    players: {
        type: Number, default: 0
    },
    likes: {
        type: Number, default: 0
    }
},
{
    timestamps: true
}
);

const song = mongoose.model('song', songSchema);

module.exports = song;