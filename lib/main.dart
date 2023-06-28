import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/screens/add_friend.dart';
import 'package:my_codeforces_app/screens/add_keys.dart';
import 'package:my_codeforces_app/screens/contest_info_screen.dart';
import 'package:my_codeforces_app/screens/handle_setup.dart';
import 'package:my_codeforces_app/screens/user_submissions.dart';
import 'package:my_codeforces_app/screens/home_screen.dart';
import 'package:my_codeforces_app/screens/my_friends.dart';
import 'package:my_codeforces_app/screens/register_screen.dart';
import 'package:my_codeforces_app/screens/profile_screen.dart';
import 'package:my_codeforces_app/screens/search_screen.dart';
import 'package:my_codeforces_app/services/firestore_services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

bool isHandlePresent = false;
bool isLoggedIn = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (FirebaseAuth.instance.currentUser != null) {
    isHandlePresent = await FireStoreServices().isHandlePresent();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
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
      home: const SplashScreen(),
      routes: {
        homeScreen: (context) => const HomeScreen(),
        registerScreen: (context) => const RegisterScreen(),
        addFriendScreen: (context) => const AddFriend(),
        addKeyScreen: (context) => const AddKeys(),
        profileScreen: (context) => const ProfileScreen(),
        searchScreen: (context) => const SearchUser(),
        myFriends: (context) => const MyFriends(),
        friendSubmissions: (context) => const UserSubmissionScreen(),
        contestInfo: (context) => const ContestInfoScreen(),
        handleScreen: (context) => const HandleScreen(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedSplashScreen(
      duration: 1500,
      splashIconSize: min(screenWidth/1.2, screenHeight/1.2),
      splash: 'assets/images/appLogo.png',
      nextScreen: isLoggedIn
          ? (isHandlePresent ? const HomeScreen() : const HandleScreen())
          : const RegisterScreen(),
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
