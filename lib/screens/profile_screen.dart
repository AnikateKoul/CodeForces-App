import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import '../templates/user.dart';
import '../services/codeforces_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Color userColor(int rating) {
    if (rating == 0) {
      return Colors.black;
    } else if (rating < 1200) {
      return const Color.fromRGBO(129, 128, 129, 1);
    } else if (rating < 1400) {
      return const Color.fromRGBO(0, 120, 0, 1);
    } else if (rating < 1600) {
      return const Color.fromRGBO(3, 168, 183, 1);
    } else if (rating < 1900) {
      return const Color.fromRGBO(0, 0, 255, 1);
    } else if (rating < 2100) {
      return const Color.fromRGBO(171, 1, 170, 1);
    } else if (rating < 2400) {
      return const Color.fromRGBO(255, 165, 0, 1);
    } else {
      return const Color.fromRGBO(255, 0, 0, 1);
    }
  }

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
            future: CodeforcesServices().userInfo("raowl"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    SizedBox(
                      height: screenHeight / 12,
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          snapshot.data!.handle,
                          style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontWeight: snapshot.data!.rating == 0 ? FontWeight.w500 : FontWeight.w800,
                            fontSize: 20,
                            color: userColor(snapshot.data!.rating),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth / 30,
                        ),
                        Text(
                          "${snapshot.data!.rating}",
                          style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontWeight: snapshot.data!.rating == 0 ? FontWeight.w500 : FontWeight.w800,
                            fontSize: 20,
                            color: userColor(snapshot.data!.rating),
                          ),
                        ),
                      ],
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
