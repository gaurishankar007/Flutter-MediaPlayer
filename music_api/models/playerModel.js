const mongoose = require("mongoose");

const playerSchema = new mongoose.Schema({
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

const player = mongoose.model('player', playerSchema);

module.exports = player;