import 'package:flutter/material.dart';
import 'text_styles.dart';
import '../constants.dart';

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
