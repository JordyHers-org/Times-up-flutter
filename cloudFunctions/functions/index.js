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

// exports.sendFollowerNotification = functions.database
//   .ref("/followers/{followedUid}/{followerUid}")
//   .onWrite(async (change, context) => {
//     const followerUid = context.params.followerUid;
//     const followedUid = context.params.followedUid;
//     // If un-follow we exit the function.
//     if (!change.after.val()) {
//       return console.log("User ", followerUid, "un-followed user", followedUid);
//     }
//     console.log(
//       "We have a new follower UID:",
//       followerUid,
//       "for user:",
//       followedUid
//     );

//     // Get the list of device notification tokens.
//     const getDeviceTokensPromise = admin
//       .database()
//       .ref(`/users/${followedUid}/notificationTokens`)
//       .once("value");

//     // Get the follower profile.
//     const getFollowerProfilePromise = admin.auth().getUser(followerUid);

//     // The snapshot to the user's tokens.
//     let tokensSnapshot;

//     // The array containing all the user's tokens.
//     let tokens;

//     const results = await Promise.all([
//       getDeviceTokensPromise,
//       getFollowerProfilePromise,
//     ]);
//     tokensSnapshot = results[0];
//     const follower = results[1];

//     // Check if there are any device tokens.
//     if (!tokensSnapshot.hasChildren()) {
//       return console.log("There are no notification tokens to send to.");
//     }
//     console.log(
//       "There are",
//       tokensSnapshot.numChildren(),
//       "tokens to send notifications to."
//     );
//     console.log("Fetched follower profile", follower);

//     // Notification details.
//     const payload = {
//       notification: {
//         title: "You have a new follower!",
//         body: `${follower.displayName} is now following you.`,
//         icon: follower.photoURL,
//       },
//     };

//     // Listing all tokens as an array.
//     tokens = Object.keys(tokensSnapshot.val());
//     // Send notifications to all tokens.
//     const response = await admin.messaging().sendToDevice(tokens, payload);
//     // For each message check if there was an error.
//     const tokensToRemove = [];
//     response.results.forEach((result, index) => {
//       const error = result.error;
//       if (error) {
//         console.error("Failure sending notification to", tokens[index], error);
//         // Cleanup the tokens who are not registered anymore.
//         if (
//           error.code === "messaging/invalid-registration-token" ||
//           error.code === "messaging/registration-token-not-registered"
//         ) {
//           tokensToRemove.push(tokensSnapshot.ref.child(tokens[index]).remove());
//         }
//       }
//     });
//     return Promise.all(tokensToRemove);
//   });
