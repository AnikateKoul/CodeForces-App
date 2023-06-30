// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/services/firebase_services.dart';
import 'package:my_codeforces_app/services/firestore_services.dart';
import 'package:my_codeforces_app/styles/snackbars.dart';
import 'package:my_codeforces_app/styles/text_styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight / 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth / 20,
                    ),
                    child: Image.asset(
                      'assets/images/appLogo.png',
                      width: min(screenWidth / 1.3, screenHeight / 1.3),
                      height: max(screenHeight / 4.5, screenWidth / 4.5),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight / 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth / 1.3,
                    child: TextButton(
                      onPressed: () async {
                        try {
                          bool isSignedUp =
                              await FirebaseServices().signInWithGoogle();
                          bool isHandlePresent =
                              await FireStoreServices().isHandlePresent();
                          if (isSignedUp && isHandlePresent) {
                            Navigator.pushReplacementNamed(context, homeScreen);
                          } else if (isSignedUp) {
                            await FireStoreServices().createUser();
                            Navigator.pushReplacementNamed(
                                context, handleScreen);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(text: "Login unsuccessful. Please check your connection!", color: kred, context: context));
                        }
                      },
                      style: ButtonStyle(
                          iconColor: MaterialStateProperty.all<Color>(kblue),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(26, 228, 209, 209))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/googleLogo.png',
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            "Sign In With Google",
                            style: style1(color: kred, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight / 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
