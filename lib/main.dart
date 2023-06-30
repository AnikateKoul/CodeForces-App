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
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:my_codeforces_app/styles/button_styles.dart';
import 'package:my_codeforces_app/styles/text_styles.dart';
import 'package:restart_app/restart_app.dart';

bool isHandlePresent = false;
bool isLoggedIn = false;
bool isConnected = true;
void main() async {
  // print("I ran");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (FirebaseAuth.instance.currentUser != null) {
    isHandlePresent = await FireStoreServices().isHandlePresent();
  }
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    isConnected = false;
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
      splashIconSize: min(screenWidth / 1.2, screenHeight / 1.2),
      splash: 'assets/images/appLogo.png',
      nextScreen: isConnected ? isLoggedIn
          ? (isHandlePresent ? const HomeScreen() : const HandleScreen())
          : const RegisterScreen() : const NoInternetScreen(),
      splashTransition: SplashTransition.slideTransition,
    );
  }
}

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("CF Companion", style: style1()),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          color: kwhite,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight/20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "No internet connection! Please check your connection",
                  textAlign: TextAlign.center,
                  style: style1(fontSize: 30),
                ),
              ),
              SizedBox(
                height: screenHeight/15,
              ),
              TextButton(
                onPressed: () {
                  Restart.restartApp();
                },
                style: bstyle1(),
                child: Text(
                  "Try again",
                  style: style1(color: kwhite),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
