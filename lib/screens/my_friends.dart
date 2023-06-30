// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/services/codeforces_services.dart';
import 'package:my_codeforces_app/styles/text_styles.dart';
import 'package:my_codeforces_app/templates/user.dart';
import '../services/firestore_services.dart';

class MyFriends extends StatefulWidget {
  const MyFriends({super.key});

  @override
  State<MyFriends> createState() => _MyFriendsState();
}

class _MyFriendsState extends State<MyFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Friends",
          style: style1(),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Container(
          color: kwhite,
          child: FutureBuilder(
            future: FireStoreServices().friendList(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "You currently have 0 friends.",
                      style: style1(),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        snapshot.data![index],
                        style: style1(),
                      ),
                      onTap: () async {
                        User details = await CodeforcesServices().userInfo(snapshot.data![index], context);
                        Navigator.pushNamed(context, profileScreen,
                                arguments: [details, snapshot.data!, 1])
                            .then((value) => setState(() {}));
                      },
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
