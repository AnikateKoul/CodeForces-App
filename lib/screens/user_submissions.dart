import 'package:flutter/material.dart';
import 'package:my_codeforces_app/styles/text_styles.dart';
import '../services/codeforces_services.dart';
import '../styles/list_tiles.dart';

class UserSubmissionScreen extends StatefulWidget {
  const UserSubmissionScreen({super.key});

  @override
  State<UserSubmissionScreen> createState() => _UserSubmissionScreenState();
}

class _UserSubmissionScreenState extends State<UserSubmissionScreen> {
  @override
  Widget build(BuildContext context) {
    //! final screenWidth = MediaQuery.of(context).size.width;
    //! final screenHeight = MediaQuery.of(context).size.height;
    final args = ModalRoute.of(context)!.settings.arguments;
    final username = args ?? "AnikateKoul";
    final title = args == null ? "My Submissions" : "$args's Submissions";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: style1(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        child: FutureBuilder(
            future: CodeforcesServices().userSubmissions(username as String),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "No submissions to display",
                      style: style1(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      // print(snapshot.data![index].verdict);
                      return tile2(
                        name: snapshot.data![index].problem.name,
                        rating: snapshot.data![index].problem.rating ?? 0,
                        verdict: snapshot.data![index].verdict ?? "Unknown",
                        contestId:
                            snapshot.data![index].problem.contestId ?? 5000,
                        submissionId: snapshot.data![index].id,
                        context: context,
                      );
                    },
                    itemCount: snapshot.data!.length,
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
