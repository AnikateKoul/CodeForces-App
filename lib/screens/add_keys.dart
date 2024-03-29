// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/services/codeforces_services.dart';
import 'package:my_codeforces_app/services/firestore_services.dart';
import 'package:my_codeforces_app/styles/snackbars.dart';
import 'package:my_codeforces_app/styles/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class AddKeys extends StatefulWidget {
  const AddKeys({super.key});

  @override
  State<AddKeys> createState() => _AddKeysState();
}

class _AddKeysState extends State<AddKeys> {
  final _apiKey = TextEditingController();
  final _secret = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Keys",
          style: style1(),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight / 10,
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "Open the link given below and create your api key and secret:\n (The api key and secret shoud belong to the handle set in the app)",
                  style: style1(fontSize: 15, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: screenHeight / 30,
              ),
              TextButton(
                onPressed: () async {
                  try {
                    final Uri url =
                        Uri.parse('https://codeforces.com/settings/api');
                    if (!await launchUrl(url,
                        mode: LaunchMode.externalApplication)) {
                      throw Exception('Could not launch $url');
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                        text: "Friends synchronized successfully!",
                        color: kblue,
                        context: context));
                  }
                },
                child: const Text("Open Link"),
              ),
              SizedBox(
                height: screenHeight / 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
                child: TextFormField(
                  controller: _apiKey,
                  decoration: const InputDecoration(
                    hintText: "Api Key",
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
                child: TextFormField(
                  controller: _secret,
                  decoration: const InputDecoration(
                    hintText: "Secret",
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 20,
              ),
              TextButton(
                onPressed: () async {
                  try {
                    await FireStoreServices()
                        .addKey(_apiKey.text, _secret.text);
                    // Navigator.pop(context);
                    bool b = await CodeforcesServices(
                            apiKey: _apiKey.text, secret: _secret.text)
                        .checkKey(context);
                    if (b) {
                      await FireStoreServices()
                          .addFriends(_apiKey.text, _secret.text, context);
                      ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                          text: "Friends synchronized successfully!",
                          color: kblue,
                          context: context));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                          text: "The API key and/or secret are not correct!",
                          color: kred,
                          context: context));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                        text:
                            "Some error occured. Please check your internet connection!",
                        color: kred,
                        context: context));
                  }
                },
                child: const Text("Add key"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
