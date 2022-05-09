const multer = require('multer');

const storageNavigation = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, "./upload/music");
    },
    filename: function(req, file, cb) {
        cb(null, Date.now()+"_"+file.originalname);
    }
});


const filter = function(req, file, cb) {
    if(file.mimetype == "audio/mpeg" || file.mimetype=="audio/mp4") {
        cb(null, true);
    }
    else {
        cb(null, false);
    }
}

const mUpload = multer({
    storage: storageNavigation,
    fileFilter: filter
});

module.exports = mUpload;