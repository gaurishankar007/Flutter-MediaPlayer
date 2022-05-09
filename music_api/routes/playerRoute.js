const express = require('express');
const router = new express.Router();
const auth = require('../auth/auth');
const song = require('../models/songModel');
const player = require('../models/playerModel');
const mongoose = require('mongoose');

router.post("/play/song", auth.verifyUser, async (req, res)=> {
    player.findOne({user: req.userInfo._id, song: req.body.songId}).then((fPlayer)=> {
        if(fPlayer===null) {
            const newPlayer = new player({
                user: req.userInfo._id,
                song: mongoose.Types.ObjectId(req.body.songId)
            });
            newPlayer.save();
            
            song.findById(req.body.songId).then((fSong)=> {        
                song.updateOne({_id: req.body.songId}, {players: fSong.players + 1}).then(()=> {                    
                    return res.send({resM: "Played first time."});
                });
            }); 
        } else {     
            return res.send({resM: "Already played."});
        }
    });
});

module.exports = router;