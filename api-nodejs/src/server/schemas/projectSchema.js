const mongoose = require("mongoose");

const ProjectSchema = new mongoose.Schema({
    title: { type: String, required: true, unique: true},
    description: { type: String },
    beginDate: {type: Date, required: true},
    endDate: {type: Date, required: true},
    client: { 
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Client', 
        require: true, 
    },
    responsible: { 
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Employee', 
        require: true, 
    }
});

module.exports = mongoose.model("Project", ProjectSchema);