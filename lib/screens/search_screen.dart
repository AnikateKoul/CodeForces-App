// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/services/codeforces_services.dart';
import 'package:my_codeforces_app/services/firestore_services.dart';
import 'package:my_codeforces_app/styles/button_styles.dart';
import 'package:my_codeforces_app/styles/text_styles.dart';
import 'package:my_codeforces_app/templates/user.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final userController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search User"),
        centerTitle: true,
      ),
      body: Container(
        color: kwhite,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight / 6,
              ),
              Center(
                child: SizedBox(
                  width: screenWidth / 1.1,
                  // height: screenHeight/15,
                  child: TextFormField(
                    controller: userController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      hintText: "Enter user CodeForces ID",
                      suffix: IconButton(
                          onPressed: () {
                            userController.text = "";
                          },
                          icon: const Icon(Icons.clear)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 7,
              ),
              Center(
                child: SizedBox(
                  width: screenWidth / 2.5,
                  child: TextButton(
                    onPressed: () async {
                      User data = await CodeforcesServices().userInfo(userController.text, context);
                      if(data.handle == "//") data.handle = userController.text;
                      List friendList = await FireStoreServices().friendList(context);
                      Navigator.pushNamed(context, profileScreen,
                          arguments: [data, friendList, 1]);
                    },
                    style: bstyle1(),
                    child: Text(
                      "Search",
                      style: style1(color: kwhite),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
