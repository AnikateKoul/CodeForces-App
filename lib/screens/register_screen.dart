import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/services/firebase_services.dart';
import 'package:my_codeforces_app/services/firestore_services.dart';
import 'package:my_codeforces_app/styles/text_styles.dart';
import 'package:simple_icons/simple_icons.dart';

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
                  child: Text(
                    "Welcome to \n\nCodeforces Companion",
                    textAlign: TextAlign.center,
                    style: style1(fontSize: 36),
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
                      bool isSignedUp =
                          await FirebaseServices().signInWithGoogle();
                      bool isHandlePresent =
                          await FireStoreServices().isHandlePresent();
                      if (isSignedUp && isHandlePresent) {
                        Navigator.pushReplacementNamed(context, homeScreen);
                      } else if (isSignedUp) {
                        await FireStoreServices().createUser();
                        Navigator.pushReplacementNamed(context, handleScreen);
                      } else {
                        print("Some error, please try again");
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
          ],
        ),
      ),
    );
  }
}
