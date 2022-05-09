const jwt = require("jsonwebtoken");
const user = require("../models/userModel.js");

// Guard for normal user
module.exports.verifyUser = function(req, res, next) {
    try{
        const token = req.headers.authorization.split(" ")[1];
        const userData = jwt.verify(token, "loginKey");
        user.findOne({_id: userData.userId}).then((nUser)=>{
            req.userInfo = nUser;
            next();
        }).catch(function(e){
            res.json({error: e});
        });
    }
    catch(e) {
        res.status(400).send({message: "Invalid Token!"});
    }
} 