const functions = require("firebase-functions");
const admin = require("firebase-admin");
var newData;

admin.initializeApp(functions.config().functions);

exports.myTrigger = functions.firestore
  .document("users/{userId}/notifications/{notificationId}")
  .onCreate(async (snapshot, context) => {
    const notificationId = context.params.notificationId;

    if (snapshot.empty) {
      console.log("No Devices");
      return;
    }

    newData = snapshot.data();

    const deviceIdTokens = await admin
      .firestore()
      .collection("DeviceTokens")
      .where("childId", "==", notificationId)
      .get();

    var tokens = [];

    for (var token of deviceIdTokens.docs) {
      tokens.push(token.data().device_token);
    }
    var Notifications = {
      notification: {
        title: "Hey New notification",
        body: newData.message,
        sound: "default",
      },
      data: {
        click_action: "FLUTTER_NOTIFICATION_CLICK",
        message: newData.message,
      },
    };

    try {
      const response = await admin
        .messaging()
        .sendToDevice(tokens, Notifications);
      console.log("Id", notificationId);
      console.log("Notification sent successfully");
    } catch (err) {
      console.log(err);
    }
  });
