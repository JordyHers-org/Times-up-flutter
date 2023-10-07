import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp(functions.config().functions);

exports.sendNotification = functions.firestore
  .document("users/{userId}/notifications/{notificationId}")
  .onCreate(async (snapshot, context) => {
    const notificationId = context.params.notificationId;
    const newData = snapshot.data();

    if (!newData) {
      console.log("No Devices");
      return;
    }

    const deviceIdTokens = await admin
      .firestore()
      .collection("DeviceTokens")
      .where("childId", "==", notificationId)
      .get();

    const tokens: string[] = [];

    deviceIdTokens.docs.forEach((token) => {
      tokens.push(token.data().device_token);
    });

    const Notifications = {
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
      console.log("response", response);
      console.log("Notification sent successfully");
    } catch (err) {
      console.log(err);
    }
  });


