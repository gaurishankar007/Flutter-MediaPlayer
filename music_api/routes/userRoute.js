const express = require("express");
const router = new express.Router();
const jwt = require("jsonwebtoken");
const bcryptjs = require("bcryptjs");
const user = require("../models/userModel");

router.post("/user/register", function(req, res) {
    const username = req.body.username;
    const password = req.body.password;

    user.findOne({username: username}).then((userData)=> {
        if(userData===null) {
            bcryptjs.hash(password, 10, function(e, hashed_value11){
                const userData = new user({username: username, password: hashed_value11});
                userData.save().then(()=> {            
                    res.status(201).send({resM: "Register Success"});
                }
                );
            });
        } else {
            res.status(400).send({resM: "Username already exists."});         
        }
        
    });
});

router.post("/user/login", (req, res)=> {
    const username = req.body.username;
    const password = req.body.password;

    user.findOne({username: username}).then((userData)=> {
        if(userData!==null) {
            // Now comparing client password with the given password
            bcryptjs.compare(password, userData.password, function(e, result){
                if(!result) {
                    return res.status(400).send({resM: "Incorrect password, try again."});
                }
                // Now lets generate token
                const token = jwt.sign({userId: userData._id}, "loginKey");
                res.status(202).send({token: token, user_id: userData._id, username: userData.username, resM: "Login success"});         
            });
        }
        else {
            res.status(404).send({resM: "Username did not match."});                    
        }
    });
});

module.exports = router;