import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/styles/text_styles.dart';
import '../templates/user.dart';
import '../services/codeforces_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        color: kwhite,
        child: FutureBuilder<User>(
            //! enter user profile here ->
            future: CodeforcesServices().userInfo("awoo"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int rating = snapshot.data!.rating;
                return Column(
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                        snapshot.data!.rank,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                        "${snapshot.data!.maxRating} (${snapshot.data!.maxRank})",
                                        style: style1(
                                          fontWeight: rating == 0
                                              ? FontWeight.w500
                                              : FontWeight.w800,
                                          color: userColor(
                                              snapshot.data!.maxRating),
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
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
