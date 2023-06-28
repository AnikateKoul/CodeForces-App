// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/services/firestore_services.dart';
import 'package:my_codeforces_app/styles/button_styles.dart';
import 'package:my_codeforces_app/styles/snackbars.dart';
import 'package:my_codeforces_app/styles/text_styles.dart';
import '../services/codeforces_services.dart';
import '../templates/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var myFriends = [];
  Future<User> fun(Object? args, BuildContext context) async {
    try {
      myFriends = await FireStoreServices().friendList(context);
      return CodeforcesServices().userInfo(args as String, context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
          text: "Some error occured. Please check your internet connection!",
          color: kred,
          context: context));
      return User(
          handle: "//", contribution: 0, titlePhoto: "//", friendOfCount: 0);
    }
  }

  //! friend button
  Widget friendButton(String username) {
    // print(myFriends);
    if (myFriends.contains(username)) {
      return TextButton(
        onPressed: () async {
          try {
            await FireStoreServices().removeFriend(username, context);
            setState(() {
              myFriends.remove(username);
            });
            ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                text: "Removed Friend Successfully!",
                color: kred,
                context: context));
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                text:
                    "Some error occured. Please check your internet connection!",
                color: kred,
                context: context));
          }
        },
        style: bstyle1(),
        child: Text(
          "Remove Friend",
          style: style1(color: kwhite),
        ),
      );
    } else {
      return TextButton(
        onPressed: () async {
          try {
            await FireStoreServices().addFriend(username, context);
            setState(() {
              myFriends.add(username);
            });
            ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                text: "Added Friend Successfully!",
                color: kblue,
                context: context));
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                text:
                    "Some error occured. Please check your internet connection!",
                color: kred,
                context: context));
          }
        },
        style: bstyle1(color: kblue),
        child: Text(
          "Add Friend",
          style: style1(color: kwhite),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List _args = ModalRoute.of(context)!.settings.arguments as List;
    final args = _args[0];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: kwhite,
        title: Text(
          _args[1] == 0 ? "My Profile" : args,
          style: style1(),
        ),
        centerTitle: true,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Container(
          color: kwhite,
          child: FutureBuilder(
              //! enter user profile here ->
              future: fun(args, context),
              builder: (context, snapshot) {
                // print(snapshot);
                if (snapshot.hasData) {
                  if (snapshot.data!.handle == "//") {
                    // Navigator.pop(context);
                    return Column(
                      children: [
                        SizedBox(
                          height: screenHeight / 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: screenWidth / 1.2,
                              child: Text(
                                "The user you are trying to find does not exist",
                                textAlign: TextAlign.center,
                                style: style1(fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenWidth / 8,
                        ),
                        Center(
                          child: SizedBox(
                            width: screenWidth / 2.5,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color?>(kred),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ))),
                              child: Text(
                                "Go Back",
                                style: style1(color: kwhite),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    int rating = snapshot.data!.rating == null
                        ? 0
                        : snapshot.data!.rating as int;
                    int maxRating = snapshot.data!.maxRating == null
                        ? 0
                        : snapshot.data!.maxRating as int;
                    String rank = snapshot.data!.rank == null
                        ? "Unrated"
                        : snapshot.data!.rank as String;
                    String maxRank = snapshot.data!.maxRank == null
                        ? "Unrated"
                        : snapshot.data!.maxRank as String;
                    // print("rating = $rating");
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: screenHeight / 12,
                          ),
                          //! User profile image
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: min(screenHeight, screenWidth) / 1.5,
                                height: min(screenHeight, screenWidth) / 1.5,
                                child: Image.network(
                                  snapshot.data!.titlePhoto,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 30,
                          ),
                          //! User Information
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth / 10),
                                child: Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(10),
                                    1: FlexColumnWidth(1),
                                    2: FlexColumnWidth(10),
                                  },
                                  children: [
                                    //! Username
                                    TableRow(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Username : ",
                                              style: style1(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: screenWidth / 30,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data!.handle,
                                              style: style1(
                                                fontWeight: rating == 0
                                                    ? FontWeight.w500
                                                    : FontWeight.w800,
                                                color: userColor(rating),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    //! User Rating
                                    TableRow(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Rating : ",
                                              style: style1(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: screenWidth / 30,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "$rating",
                                              style: style1(
                                                fontWeight: rating == 0
                                                    ? FontWeight.w500
                                                    : FontWeight.w800,
                                                color: userColor(rating),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    //! User Rank
                                    TableRow(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Rank : ",
                                              style: style1(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: screenWidth / 30,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              rank,
                                              style: style1(
                                                fontWeight: rating == 0
                                                    ? FontWeight.w500
                                                    : FontWeight.w800,
                                                color: userColor(rating),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    //! User Contribution
                                    TableRow(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Contribution : ",
                                              style: style1(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: screenWidth / 30,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${snapshot.data!.contribution}",
                                              style: style1(
                                                fontWeight: rating == 0
                                                    ? FontWeight.w500
                                                    : FontWeight.w800,
                                                color: contributionColor(
                                                    snapshot
                                                        .data!.contribution),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    //! User max rating
                                    TableRow(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Max rating : ",
                                              style: style1(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: screenWidth / 30,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "$maxRating ($maxRank)",
                                              style: style1(
                                                fontWeight: rating == 0
                                                    ? FontWeight.w500
                                                    : FontWeight.w800,
                                                color: userColor(maxRating),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 10,
                          ),
                          //! Add or remove Friend
                          friendButton(snapshot.data!.handle),
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          //! User Submissions
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, friendSubmissions,
                                  arguments: [args, 1]);
                            },
                            style: bstyle1(color: kblue),
                            child: Text(
                              "See Submissions",
                              style: style1(color: kwhite),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight / 30,
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  // print("Hello There");
                  return Container(
                    color: kwhite,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
