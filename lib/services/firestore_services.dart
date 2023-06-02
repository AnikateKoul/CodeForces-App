import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
        "timestamp" : DateTime.now(),
      });
    } else {
      print('Document data:');
    }
  }
}
