import 'package:flutter/material.dart';
import 'text_styles.dart';
import '../constants.dart';

//! tile for friend list
ListTile tile1(String user, BuildContext context) {
  return ListTile(
    title: Text(
      user,
      style: style1(),
    ),
    onTap: () {
      Navigator.pushNamed(context, profileScreen, arguments: user);
    },
  );
}

//! tile for submissions
ListTile tile2(String name, {int? rating = 0, String verdict = "Unknown"}) {
  rating ??= 0;
  return ListTile(
    title: Text(
      name,
      style: style1(),
    ),
    trailing: Text(
      (verdict == "OK" ? "Accepted" : verdict as String),
      style: style1(color: verdict == "OK" ? kpupil : kred),
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
            color: userColor(rating as int),
          ),
        ),
      ],
    ),
  );
}
