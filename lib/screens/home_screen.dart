import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/services/firebase_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Codeforces App"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseServices().signOut();
              Navigator.pushReplacementNamed(context, registerScreen);
            },
            child: Text("Sign Out"),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth,
                  child: Image.network(FirebaseAuth.instance.currentUser?.photoURL !=
                          null
                      ? FirebaseAuth.instance.currentUser?.photoURL as String
                      : "https://codeforces.org/s/95132/images/codeforces-sponsored-by-ton.png"),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(FirebaseAuth.instance.currentUser?.displayName != null
                    ? FirebaseAuth.instance.currentUser?.displayName as String
                    : "No Name"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}