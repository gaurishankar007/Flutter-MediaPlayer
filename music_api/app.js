const express = require("express");
const app = express();
const cors = require("cors"); // Accepts requests from other websites,
app.use(express.json());
app.use(express.urlencoded({extended:true}));
app.use(cors());


//upload is the folder name where images are stored
// the following code make the upload folder public
app.use(express.static(__dirname+"/upload"))

require("./database/db");

const userRoute = require("./routes/userRoute");
app.use(userRoute);

const albumRoute = require("./routes/albumRoute");
app.use(albumRoute);

const songRoute = require("./routes/songRoute");
app.use(songRoute);

const playerRoute = require("./routes/playerRoute");
app.use(playerRoute);

const likeSongRoute = require("./routes/likeSongRoute");
app.use(likeSongRoute);

app.listen(8888);