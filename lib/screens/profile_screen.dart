import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/services/firestore_services.dart';
import 'package:my_codeforces_app/styles/button_styles.dart';
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
  Future<User> fun(Object? args) async {
    myFriends = await FireStoreServices().friendList();
    return CodeforcesServices()
        .userInfo(args as String);
  }

  //! friend button
  Widget friendButton(String username) {
    // print(myFriends);
    if (myFriends.contains(username)) {
      return TextButton(
        onPressed: () async {
          await FireStoreServices().removeFriend(username);
          setState(() {
            myFriends.remove(username);
          });
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
          await FireStoreServices().addFriend(username);
          setState(() {
            myFriends.add(username);
          });
        },
        style: bstyle1(),
        child: Text(
          "Add Friend",
          style: style1(color: kwhite),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments ?? "AnikateKoul";
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: kwhite,
        title: Text(args as String, style: style1(),),
        centerTitle: true,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        color: kwhite,
        child: FutureBuilder(
            //! enter user profile here ->
            future: fun(args),
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
                              "The user you are trying to find does not extist",
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
                              width: screenWidth / 1.5,
                              height: screenHeight / 3.5,
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
                                                  snapshot.data!.contribution),
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
                            Navigator.pushNamed(context, friendSubmissions, arguments: args);
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
    );
  }
}
