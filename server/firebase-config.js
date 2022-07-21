
var adminFirebase = require("firebase-admin");

var serviceAccount = require("./serviceAccountKey.json");


adminFirebase.initializeApp({
  credential: adminFirebase.credential.cert(serviceAccount),
})

module.exports.adminFirebase = adminFirebase