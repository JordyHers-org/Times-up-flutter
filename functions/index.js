const functions = require("firebase-functions");
const admin = require("firebase-admin");
// newData;

admin.initializeApp(functions.config().functions);

// exports.myTrigger = functions.firestore
//   .document("users/{userId}/notifications/{notificationId}")
//   .onCreate(async (snapshot, context) => {
//     const notificationId = context.params.notificationId;

//     if (snapshot.empty) {
//       console.log("No Devices");
//       return;
//     }

//     newData = snapshot.data();

//     const deviceIdTokens = await admin
//       .firestore()
//       .collection("DeviceTokens")
//       .where("childId", "==", notificationId)
//       .get();

//     const tokens = [];

//     for (var token of deviceIdTokens.docs) {
//       tokens.push(token.data().device_token);
//     }
//     const Notifications = {
//       notification: {
//         title: "Hey New notification",
//         body: newData.message,
//         sound: "default",
//       },
//       data: {
//         click_action: "FLUTTER_NOTIFICATION_CLICK",
//         message: newData.message,
//       },
//     };

//     try {
//       const response = await admin
//         .messaging()
//         .sendToDevice(tokens, Notifications);
//       console.log("Id", notificationId);
//       console.log("Notification sent successfully");
//     } catch (err) {
//       console.log(err);
//     }
//   });


const firestore = admin.firestore();

exports.deleteInactiveUsers = functions.pubsub.schedule("every 1 minutes").onRun(async (context) => {

  const usersCollection = firestore.collection("users");
  const currentDate = new Date();
  const thirtyDaysAgo = new Date(currentDate.getTime() - 30 * 24 * 60 * 60 * 1000);

  const snapshot = await usersCollection.get();

  const batch = firestore.batch();

  snapshot.forEach((doc) => {
    const { accountStatus, createdAt } = doc.data();

    if (accountStatus === "activated") {
      // Skip activated users
      return;
    }

    const createdAtDate = createdAt.toDate(); // Assuming createdAt field is stored as a Firestore Timestamp

    if (currentDate.getTime() - createdAtDate.getTime() >= thirtyDaysAgo.getTime()) {
      // Delete users with "deactivated" status older than 30 days
      batch.delete(doc.ref);
    }
  });

  return batch.commit();
});


//  exports.deleteUserAfter30Days= onSchedule("1 * * * *", async (event) => {
//
////  "every day 00:00"
//    // Fetch all user details.
////    const inactiveUsers = await getInactiveUsers();
////
////    // Use a pool so that we delete maximum `MAX_CONCURRENT` users in parallel.
////    const promisePool = new PromisePool(
////        () => deleteInactiveUser(inactiveUsers),
////        MAX_CONCURRENT,
////    );
////    await promisePool.start();
//
//    logger.log("running after 1 minute");
//  });



//  // Define the function that will be called when the schedule fires
//  function deleteUserDocument() {
//    // Get the current date and time
//    const now = new Date();
//
//    // Get the user document that was scheduled to be deleted
//    const userDocument = admin.firestore().collection('users').doc('user-id');
//
//    // Check if the user document is still active
//    if (userDocument.exists()) {
//      // Delete the user document
//      userDocument.delete();
//    }
//  }
//
//  // Schedule the function to be called in 30 days
//  const schedule = admin.scheduler().schedule('every 30 days', deleteUserDocument);
//
//  // Define the function that will be called when the user wants to cancel the schedule
//  function cancelSchedule() {
//    // Cancel the schedule
//    schedule.cancel();
//  }
//
//  // Export the functions
//  module.exports = {
//    deleteUserDocument,
//    cancelSchedule
//  };
//
//exports.deleteUser = functions.https.onRequest((req, res) => {
//  // Get the user ID from the request body
//  const userId = req.body.userId;
//
//  // Get the Firestore database
//  const db = admin.firestore();
//
//  // Create a promise to delete the user document
//  const promise = db.collection('users').doc(userId).delete();
//
//  // Schedule the promise to be executed in 1 minute
//  setTimeout(() => promise.then(() => res.send('User deleted!')), 60000);
//});



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
