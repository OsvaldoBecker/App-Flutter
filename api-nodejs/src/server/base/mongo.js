const mongoose = require("mongoose");
const uri = "mongodb://localhost:27017/Trabalho-DWM";

mongoose.connect(uri, {
    useUnifiedTopology: true,
    useCreateIndex: true,
    useFindAndModify: false,
    useNewUrlParser: true
});