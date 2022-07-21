
var adminFirebase = require("firebase-admin");

var serviceAccount = require("./serviceAccountKey.json");


adminFirebase.initializeApp({
  credential: adminFirebase.credential.cert(serviceAccount),
  // databaseURL: "firebase-adminsdk-2yh9s@clone-eda6a.iam.gserviceaccount.com"
})

module.exports.adminFirebase = adminFirebase