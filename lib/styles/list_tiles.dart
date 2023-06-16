import 'package:flutter/material.dart';
import 'text_styles.dart';
import '../constants.dart';
import 'package:intl/intl.dart';

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
    required int startTime}) {
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
      Text(
        phase,
        style: style1(color: contestColor(phase)),
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
    {required String name, required int rating, required String verdict}) {
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
  );
}
