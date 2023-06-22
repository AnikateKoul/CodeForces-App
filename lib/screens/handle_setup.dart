import 'package:flutter/material.dart';
import 'package:my_codeforces_app/styles/button_styles.dart';
import 'package:my_codeforces_app/styles/snackbars.dart';
import 'package:my_codeforces_app/styles/text_styles.dart';
import '../constants.dart';
import '../services/firestore_services.dart';

class HandleScreen extends StatefulWidget {
  const HandleScreen({super.key});

  @override
  State<HandleScreen> createState() => _HandleScreenState();
}

class _HandleScreenState extends State<HandleScreen> {
  final handleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter your CodeForces Handle",
          style: style1(),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: kwhite,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight / 5,
              ),
              Center(
                child: SizedBox(
                  width: screenWidth / 1.1,
                  child: TextFormField(
                    controller: handleController,
                    decoration: InputDecoration(
                      hintText: "Enter your CodeForces handle",
                      suffix: IconButton(
                        onPressed: () {
                          handleController.text = "";
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 8,
              ),
              Center(
                child: TextButton(
                  onPressed: () async {
                    bool isHandleValid = await FireStoreServices().setupHandle(handleController.text);
                    if(isHandleValid) {
                      Navigator.pushReplacementNamed(context, homeScreen);
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(text: "The handle is not correct", color: kred, context: context));
                    }
                  },
                  style: bstyle1(),
                  child: Text(
                    "Submit",
                    style: style1(color: kwhite),
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
