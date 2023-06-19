import 'package:flutter/material.dart';
import 'text_styles.dart';
import '../constants.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'snackbars.dart';

String formatDuration3(Duration duration) {
  String days = duration.inDays.toString().padLeft(2, '0');
  String hours = duration.inHours.remainder(24).toString().padLeft(2, '0');
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  return "$days:$hours:$minutes";
}

String formatDuration1(Duration duration) {
  String hours = duration.inHours.toString().padLeft(2, '0');
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}

String formatDuration2(Duration duration) {
  String hours = duration.inHours.toString().padLeft(2, '0');
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  if (duration.inHours > 24) return formatDuration3(duration);
  return "Duration : $hours:$minutes";
}

//! tile for contest information
ExpansionTile tile1(
    {required int id,
    required String name,
    required String phase,
    required int duration,
    required int startTime,
    required BuildContext context}) {
  return ExpansionTile(
    title: Text(
      name,
      style: style1(color: contestColor(phase)),
    ),
    subtitle: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formatDuration2(Duration(seconds: duration)),
          style: style1(),
        ),
      ],
    ),
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            phase,
            style: style1(color: contestColor(phase)),
          ),
          IconButton(
              onPressed: () async {
                if (phase == "BEFORE") {
                  ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                      text: "The contest hasn't started yet!",
                      color: kred,
                      context: context));
                } else {
                  final Uri url =
                      Uri.parse("https://codeforces.com/contest/$id");
                  if (!await launchUrl(url,
                      mode: LaunchMode.externalApplication)) {
                    ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
                        color: kred,
                        text: "There was some problem. Please try again later.",
                        context: context));
                  }
                }
              },
              icon: const Icon(
                Icons.ios_share,
                color: kunrated,
              )),
        ],
      ),
      Text(
        DateFormat('hh:mm a, dd/MM/yyyy')
            .format(DateTime.fromMillisecondsSinceEpoch(startTime * 1000)),
        style: style1(),
      ),
    ],
  );
}

//! tile for submissions
ListTile tile2(
    {required String name,
    required int rating,
    required String verdict,
    required int contestId,
    required int submissionId,
    required BuildContext context}) {
  return ListTile(
    title: Text(
      name,
      style: style1(),
    ),
    trailing: Text(
      (verdict == "OK" ? "Accepted" : verdict),
      style: style1(color: verdict == "OK" ? kpupil : kred, fontSize: 15),
    ),
    subtitle: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Rating : ",
          style: style1(),
        ),
        Text(
          (rating == 0 ? "Unknown" : "$rating"),
          style: style1(
            color: userColor(rating),
          ),
        ),
      ],
    ),
    onTap: () async {
      if (contestId < 5000) {
        final Uri url = Uri.parse(
            "https://codeforces.com/contest/$contestId/submission/$submissionId");
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
              color: kred,
              text: "There was some problem. Please try again later.",
              context: context));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(makeSnackBar(
            color: kblue,
            text: "Only submissions from problemset can be viewed here",
            context: context));
      }
    },
  );
}
