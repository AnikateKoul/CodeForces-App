import 'package:flutter/material.dart';
import '../services/firestore_services.dart';
import '../styles/list_tiles.dart';

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
        title: const Text("My Friends"),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future: FireStoreServices().friendList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(itemBuilder: (context, index) {
                return tile1(snapshot.data![index], context);
              }, itemCount: snapshot.data!.length,);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
