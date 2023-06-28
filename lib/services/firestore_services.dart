// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/styles/snackbars.dart';
import 'codeforces_services.dart';

class FireStoreServices {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  createUser() async {
    final userDocRef = db.collection("Users").doc(user.uid);
    final doc = await userDocRef.get();
    if (!doc.exists) {
      await db.collection("Users").doc(user.uid).set({
        "name": user.displayName,
        "email": user.email,
        "timestamp": DateTime.now(),
      });
    } else {
      print('Document data:');
    }
  }

  addKey(String apiKey, String secret) async {
    try {
      await db.collection("Keys").doc(user.uid).set({
        "apiKey": apiKey,
        "secret": secret,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List> friendList(BuildContext context) async {
    try {
      final userDocRef = db.collection("Friends").doc(user.uid);
      final doc = await userDocRef.get();
      if (!doc.exists) {
        await db.collection("Friends").doc(user.uid).set({
          "friends": [],
        });
        return [];
      } else {
        return doc["friends"];
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
          text: "Some error occured. Please check your internet connection!",
          color: kred,
          context: context));
      return [];
    }
  }

  addFriends(String? apiKey, String? secret, BuildContext context) async {
    var oldFriends = await friendList(context);
    var newFriends =
        await CodeforcesServices().importFriends(apiKey, secret, context);
    newFriends = oldFriends + newFriends;
    newFriends = newFriends.toSet().toList();
    await db.collection("Friends").doc(user.uid).set({
      "friends": newFriends,
    });
  }

  addFriend(String username, BuildContext context) async {
    var oldFriends = await friendList(context);
    var newFriends = oldFriends + [username];
    newFriends = newFriends.toSet().toList();
    await db.collection("Friends").doc(user.uid).set({
      "friends": newFriends,
    });
    if (oldFriends.length == newFriends.length) {
      print("Already a friend");
    } else {
      print("Friend added");
    }
  }

  keyAndSecret() async {
    try {
      final userDocRef = db.collection("Keys").doc(user.uid);
      final doc = await userDocRef.get();
      if (!doc.exists) {
        print("Uid is : ${user.uid} and doc does not exist");
        return [null, null];
      } else {
        return [doc["apiKey"], doc["secret"]];
      }
    } catch (e) {
      rethrow;
    }
  }

  removeFriend(String username, BuildContext context) async {
    var oldFriends = await friendList(context);
    oldFriends.remove(username);
    await db.collection("Friends").doc(user.uid).set({
      "friends": oldFriends,
    });
    print("Friend Removed");
  }

  Future<bool> setupHandle(String handle, BuildContext context) async {
    try {
      String newHandle =
          (await CodeforcesServices().userInfo(handle, context)).handle;
      String _newHandle = newHandle.toLowerCase();
      handle = handle.toLowerCase();
      if (handle != _newHandle) return false;
      if (!(await isHandlePresent())) {
        await db.collection("Users").doc(user.uid).set({
          "handle": newHandle,
        }, SetOptions(merge: true));
      } else {
        await db.collection("Users").doc(user.uid).update({
          "handle": newHandle,
        });
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isHandlePresent() async {
    final userDocRef = db.collection("Users").doc(user.uid);
    final doc = await userDocRef.get();
    if (!doc.exists) return false;
    if (doc.data()!.containsKey("handle")) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getHandle() async {
    final userDocRef = db.collection("Users").doc(user.uid);
    final doc = await userDocRef.get();
    return doc["handle"];
  }
}
