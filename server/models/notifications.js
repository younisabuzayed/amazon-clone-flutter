const mongoose = require('mongoose');

const notificationsSchema = mongoose.Schema({
    sender:
    {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
    },
    receiver:
    [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
    }],
    title: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    // read_by:[{
    //     readerId:
    //     {
    //         type:mongoose.Schema.Types.ObjectId, 
    //         ref:'User'
    //     },
    //     read_at: 
    //     {
    //         type: Date,
    //         default: Date.now
    //     }
    // }],
    created_at:
    {
        type: Date, 
        default: Date.now,
    },
});

const Notifications = mongoose.model("Notifications", notificationsSchema);
module.exports = Notifications;