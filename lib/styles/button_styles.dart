import 'package:flutter/material.dart';
import '../constants.dart';

ButtonStyle bstyle1({Color color = kred, double borderRadius = 50}) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color?>(color),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
  );
}
