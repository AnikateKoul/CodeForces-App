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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Codeforces App"),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: kred,
        // surfaceTintColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth / 50, vertical: screenHeight / 80),
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(screenHeight / 10),
                        child: Image.network(
                          FirebaseAuth.instance.currentUser?.photoURL as String,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        FirebaseAuth.instance.currentUser?.displayName
                            as String,
                        style: const TextStyle(
                          color: kwhite,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //! CodeForces Profile
            ListTile(
              leading: const Icon(
                Icons.account_box_outlined,
                color: kwhite,
              ),
              title: const Text(
                "Codeforces Profile",
                style: TextStyle(
                  color: kwhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, profileScreen);
              },
            ),
            //! Sign Out
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: kwhite,
              ),
              title: const Text(
                "Sign Out",
                style: TextStyle(
                  color: kwhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () async {
                await FirebaseServices().signOut();
                Navigator.pushReplacementNamed(context, registerScreen);
              },
            ),
          ],
        ),
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
                Text(FirebaseAuth.instance.currentUser?.displayName != null
                    ? FirebaseAuth.instance.currentUser?.displayName as String
                    : "No Name"),
              ],
            ),
            SizedBox(
              height: screenHeight / 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, addFriendScreen);
              },
              child: Text("Add Friend"),
            ),
          ],
        ),
      ),
    );
  }
}
