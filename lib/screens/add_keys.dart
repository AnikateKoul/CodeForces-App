import 'package:flutter/material.dart';
import 'package:my_codeforces_app/constants.dart';
import 'package:my_codeforces_app/services/codeforces_services.dart';
import 'package:my_codeforces_app/services/firestore_services.dart';
import 'package:my_codeforces_app/styles/snackbars.dart';
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
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight / 10,
            ),
            const Text(
                "Open the link given below and create your api key and secret :"),
            SizedBox(
              height: screenHeight / 30,
            ),
            TextButton(
              onPressed: () async {
                final Uri url =
                    Uri.parse('https://codeforces.com/settings/api');
                if (!await launchUrl(url,
                    mode: LaunchMode.externalApplication)) {
                  throw Exception('Could not launch $url');
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
                await FireStoreServices().addKey(_apiKey.text, _secret.text);
                // Navigator.pop(context);
                bool b = await CodeforcesServices(
                        apiKey: _apiKey.text, secret: _secret.text)
                    .checkKey();
                if (b) {
                  await FireStoreServices()
                      .addFriends(_apiKey.text, _secret.text);
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
              },
              child: const Text("Add key"),
            ),
          ],
        ),
      ),
    );
  }
}
