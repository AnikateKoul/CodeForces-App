import 'package:flutter/material.dart';
import 'text_styles.dart';
import '../constants.dart';

//! tile for submissions
ListTile tile2(String name, {int? rating = 0, String verdict = "Unknown"}) {
  rating ??= 0;
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
