const express = require("express");
const { adminFirebase } = require("../firebase-config");
const admin = require("../middlewares/admin");
const firebaseRouter = express.Router();

const notification_options = {
    "priority": "high",
};

firebaseRouter.post('/notification',async(req, res)=>{
    const registrationToken = req.body.registrationToken;
    const message = req.body.message;
    const options =  notification_options;
    try {
        const notification = await adminFirebase.messaging().send(
            {
                token: registrationToken,
                notification: message.notification,
                data: message.notification,
                android:
                {
                    priority:'high'
                },
                
            }
        )
        // const notification = await adminFirebase.messaging().sendToDevice(
        //     registrationToken,
        //     {
        //         "notification": {
        //             "body": "body",
        //             "title": "title"
        //          },
        //          "data": {
        //             "click_action": "FLUTTER_NOTIFICATION_CLICK",
        //             "id": "1",
        //             "status": "done",
        //             "image": "https://ibin.co/2t1lLdpfS06F.png",
        //          },
        //     },
        //     options,
        // );
        res.status(200).json(notification);
    
    } catch (error) {
        res
        .status(500)
        .json({
            message: error.message,
        })
    }
    // console.log(token);
    // adminFirebase.messaging().sendToDevice(
    // registrationToken, 
    // message, 
    // options
    // )
    // .then( response => {
    // res.status(200).json(response);
    // res.status(200).send("Notification sent successfully")
    
    // })
    // .catch( error => {
    // res
    // .status(500)
    // .json({
    //     message: error.message,
    // })
    // });

});

module.exports = firebaseRouter;

