const mongoose = require("mongoose");

const user = mongoose.model('user', {
    username: {
        type: String
    },
    password: {
        type: String
    },
    phone: {
        type: String
    },
    address: {
        type: String
    }
});

module.exports = user;