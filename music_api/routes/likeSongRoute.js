const express = require('express');
const router = new express.Router();
const auth = require('../auth/auth');
const song = require('../models/songModel');
const likeSong = require('../models/likeSongModel');
const mongoose = require('mongoose');

router.post("/like/song", auth.verifyUser, async (req, res)=> {
    likeSong.findOne({user: req.userInfo._id, song: req.body.songId}).then((fLikeSong)=> {
        if(fLikeSong===null) {
            const newLikeSong = new likeSong({
                user: req.userInfo._id,
                song: mongoose.Types.ObjectId(req.body.songId)
            });
            newLikeSong.save();
            
            song.findById(req.body.songId).then((fSong)=> {        
                song.updateOne({_id: req.body.songId}, {likes: fSong.likes + 1}).then(()=> {                
                    return res.send({resM: "Added to your liked songs."});                    
                });
            }); 
        } else {
            likeSong.findByIdAndDelete(fLikeSong._id).then(()=> {
                song.findById(req.body.songId).then((fSong)=> {        
                    song.updateOne({_id: req.body.songId}, {likes: fSong.likes - 1}).then(()=> {                
                        return res.send({resM: "Removed from your liked songs."});                    
                    });
                }); 
            });
        }
    });
});

module.exports = router;