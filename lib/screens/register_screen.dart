import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/services/firebase_services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
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
                  child: const Text(
                    "Welcome to Codeforces App",
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 15,
            ),
            SizedBox(
              width: screenWidth/1.2,
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
            ),
            SizedBox(
              height: screenHeight / 30,
            ),
            SizedBox(
              width: screenWidth/1.2,
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: "Password", //91abc52d
                ),
              ),
            ),
            SizedBox(
              height: screenHeight / 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    bool isSignedUp = await FirebaseServices().signUpWithEmail(_emailController.text, _passwordController.text);
                    if(isSignedUp) Navigator.pushReplacementNamed(context, homeScreen);
                    else print("Some error, please try again");
                  },
                  child: Text("Sign Up with Email"),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    bool isSignedUp = await FirebaseServices().signInWithGoogle();
                    if(isSignedUp) Navigator.pushReplacementNamed(context, homeScreen);
                    else print("Some error, please try again");
                  },
                  child: Text("Sign In"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
