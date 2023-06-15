import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/services/firebase_services.dart';
import 'package:my_codeforces_app/services/firestore_services.dart';
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
                  child: const Text(
                    "Welcome to Codeforces App",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
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
                TextButton.icon(
                  onPressed: () async {
                    bool isSignedUp =
                        await FirebaseServices().signInWithGoogle();
                    if (isSignedUp) {
                      await FireStoreServices().createUser();
                      Navigator.pushReplacementNamed(context, homeScreen);
                    } else {
                      print("Some error, please try again");

                    }
                  },
                  style: ButtonStyle(
                      iconColor: MaterialStateProperty.all<Color>(kblue),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(26, 228, 209, 209))),
                  icon: const Icon(SimpleIcons.google),
                  label: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Sign In With Google",
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: kred,
                      ),
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
