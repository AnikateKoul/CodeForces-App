import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/screens/add_friend.dart';
import 'package:my_codeforces_app/screens/add_keys.dart';
import 'package:my_codeforces_app/screens/home_screen.dart';
import 'package:my_codeforces_app/screens/my_friends.dart';
import 'package:my_codeforces_app/screens/register_screen.dart';
import 'package:my_codeforces_app/screens/profile_screen.dart';
import 'package:my_codeforces_app/screens/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    bool isLoggedIn;
    if (auth.currentUser != null) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const HomeScreen() : const RegisterScreen(),
      routes: {
        homeScreen: (context) => const HomeScreen(),
        registerScreen: (context) => const RegisterScreen(),
        addFriendScreen: (context) => const AddFriend(),
        addKeyScreen: (context) => const AddKeys(),
        profileScreen: (context) => const ProfileScreen(),
        searchScreen: (context) => const SearchUser(),
        myFriends: (context) => const MyFriends(),
      },
    );
  }
}
