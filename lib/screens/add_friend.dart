import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/styles/button_styles.dart';
import 'package:my_codeforces_app/styles/text_styles.dart';
import '../services/codeforces_services.dart';
import '../services/firestore_services.dart';
import 'package:my_codeforces_app/styles/snackbars.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({super.key});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    //! final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Friends"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight / 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, searchScreen);
                  },
                  style: bstyle1(),
                  child: Text(
                    "Search Manually",
                    style: style1(color: kwhite),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 20,
            ),
            Text(
              "OR",
              style: style1(fontSize: 30),
            ),
            SizedBox(
              height: screenHeight / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //! Import From CodeForces Button
                TextButton(
                  onPressed: () async {
                    var details = await FireStoreServices().keyAndSecret();
                    // print(details);
                    bool b = await CodeforcesServices()
                        .checkKey1(details[0], details[1]);
                    if (!b) {
                      Navigator.pushNamed(context, addKeyScreen);
                    } else {
                      await FireStoreServices()
                          .addFriends(details[0], details[1]);
                      ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                          text: "Friends synchronized successfully!", color: kblue, context: context));
                    }
                  },
                  style: bstyle1(),
                  child: Text(
                    "Import from Codeforces",
                    style: style1(color: kwhite),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
