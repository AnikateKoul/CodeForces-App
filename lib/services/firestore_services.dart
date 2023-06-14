import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'codeforces_services.dart';

class FireStoreServices {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  createUser() async {
    final userDocRef = db.collection("Users").doc(user.email);
    final doc = await userDocRef.get();
    if (!doc.exists) {
      await db.collection("Users").doc(user.email).set({
        "name": user.displayName,
        "email": user.email,
        "timestamp": DateTime.now(),
      });
    } else {
      print('Document data:');
    }
  }

  addKey(String apiKey, String secret) async {
    await db.collection("Keys").doc(user.email).set({
      "apiKey": apiKey,
      "secret": secret,
    });
  }

  Future<List> friendList() async {
    final userDocRef = db.collection("Friends").doc(user.email);
    final doc = await userDocRef.get();
    if (!doc.exists) {
      await db.collection("Friends").doc(user.email).set({
        "friends": [],
      });
      return [];
    } else {
      return doc["friends"];
    }
  }

  addFriends(String? apiKey, String? secret) async {
    var oldFriends = await friendList();
    var newFriends = await CodeforcesServices().importFriends(apiKey, secret);
    newFriends = oldFriends + newFriends;
    newFriends = newFriends.toSet().toList();
    await db.collection("Friends").doc(user.email).set({
      "friends": newFriends,
    });
  }

  addFriend(String username) async {
    var oldFriends = await friendList();
    var newFriends = oldFriends + [username];
    newFriends = newFriends.toSet().toList();
    await db.collection("Friends").doc(user.email).set({
      "friends": newFriends,
    });
    if (oldFriends.length == newFriends.length) {
      print("Already a friend");
    } else {
      print("Friend added");
    }
  }

  keyAndSecret() async {
    final userDocRef = db.collection("Keys").doc(user.email);
    final doc = await userDocRef.get();
    if (!doc.exists) {
      return [null, null];
    } else {
      return [doc["apiKey"], doc["secret"]];
    }
  }

  removeFriend(String username) async {
    var oldFriends = await friendList();
    oldFriends.remove(username);
    await db.collection("Friends").doc(user.email).set({
      "friends": oldFriends,
    });
    print("Friend Removed");
  }
}
