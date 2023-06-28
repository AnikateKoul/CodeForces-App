// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/screens/contest_info_screen.dart';
import 'package:my_codeforces_app/services/firebase_services.dart';
import 'package:my_codeforces_app/services/firestore_services.dart';
import 'package:my_codeforces_app/styles/snackbars.dart';
import '../styles/text_styles.dart';

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
        title: Text(
          "Upcoming/Recent Contests",
          style: style1(),
        ),
        centerTitle: true,
      ),
      //! Navigation Drawer
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
                        style: style2(),
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
              title: Text(
                "Codeforces Profile",
                style: style2(),
              ),
              onTap: () async {
                try {
                  String handle = await FireStoreServices().getHandle();
                  Navigator.pushNamed(context, profileScreen,
                      arguments: [handle, 0]);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                      text:
                          "Some error occured. Please check your internet connection!",
                      color: kred,
                      context: context));
                }
              },
            ),
            //! Search User
            ListTile(
              leading: const Icon(
                Icons.search,
                color: kwhite,
              ),
              title: Text(
                "Search User",
                style: style2(),
              ),
              onTap: () {
                Navigator.pushNamed(context, searchScreen);
              },
            ),
            //! My Friends
            ListTile(
              leading: const Icon(
                Icons.group,
                color: kwhite,
              ),
              title: Text(
                "My Friends",
                style: style2(),
              ),
              onTap: () {
                Navigator.pushNamed(context, myFriends);
              },
            ),
            //! My Submissions
            ListTile(
              leading: const Icon(
                Icons.list,
                color: kwhite,
              ),
              title: Text(
                "My Submissions",
                style: style2(),
              ),
              onTap: () async {
                try {
                  String handle = await FireStoreServices().getHandle();
                  Navigator.pushNamed(context, friendSubmissions,
                      arguments: [handle, 0]);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                      text:
                          "Some error occured. Please check your internet connection!",
                      color: kred,
                      context: context));
                }
              },
            ),
            //! Add Friends
            ListTile(
              leading: const Icon(
                Icons.person_add_alt_1,
                color: kwhite,
              ),
              title: Text(
                "Add Friends",
                style: style2(),
              ),
              onTap: () {
                Navigator.pushNamed(context, addFriendScreen);
              },
            ),
            //! Sign Out
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: kwhite,
              ),
              title: Text(
                "Sign Out",
                style: style2(),
              ),
              onTap: () async {
                try {
                  await FirebaseServices().signOut();
                  Navigator.pushReplacementNamed(context, registerScreen);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                      text:
                          "Some error occured. Please check your internet connection!",
                      color: kred,
                      context: context));
                }
              },
            ),
          ],
        ),
      ),
      body: const ContestInfoScreen(),
    );
  }
}
