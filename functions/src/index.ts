// eslint-disable-next-line require-jsdoc

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

interface Analect {
  creatorId: string;
  creatorName: string;
  // Add other properties from your Analect model
}

export const onAnalectCreateSendNotificationToAllFollowers = functions.firestore
  .document("analects/{analectId}")
  .onCreate(async (snapshot) => {
    try {
      const analect = snapshot.data() as Analect | undefined;

      if (!analect) {
        throw new Error("Analect data not found");
      }

      const {creatorId, creatorName} = analect;
      const followers = await getFollowers(creatorId);

      const asyncFunctList = followers.map(async (followerUID) => {
        const registrationToken = await getFcmToken(followerUID);

        if (!registrationToken) return;

        const payload = {
          notification: {
            title: "New Analect",
            body: `${creatorName} has created a new analect`,
          },
          token: registrationToken,
        };

        await admin.messaging().send(payload);

        console.log("Successfully sent message to", followerUID);
      });

      await Promise.all(asyncFunctList);
    } catch (error) {
      console.error("Error in onAnalectCreate:", error);
      throw error;
    }
  });


async function getFollowers(userId: string): Promise<string[]> {
  const userSnapshot = await admin
    .firestore()
    .collection("users")
    .doc(userId)
    .collection("followers")
    .get();

  return userSnapshot.docs.map((follower) => follower.id);
}


async function getFcmToken(userId: string): Promise<string | undefined> {
  const receiverDoc = await admin
    .firestore()
    .collection("users")
    .doc(userId)
    .get();

  if (receiverDoc.exists) {
    return receiverDoc.data()?.fcmToken;
  }

  return undefined;
}
