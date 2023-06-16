import 'package:flutter/material.dart';
import '../constants.dart';

//! Text Styles
TextStyle style1(
    {double fontSize = 20.0,
    String fontFamily = 'Source Sans Pro',
    FontWeight fontWeight = FontWeight.w500,
    Color color = Colors.black}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

TextStyle style2(
    {Color color = kwhite, 
    FontWeight fontWeight = FontWeight.w500}) {
  return TextStyle(
    color: color,
    fontWeight: fontWeight,
  );
}

//! function to give color according to rating
Color userColor(int rating) {
  if (rating == 0) {
    return Colors.black;
  } else if (rating < 1200) {
    return knewbie;
  } else if (rating < 1400) {
    return kpupil;
  } else if (rating < 1600) {
    return kspecialist;
  } else if (rating < 1900) {
    return kexpert;
  } else if (rating < 2100) {
    return kcm;
  } else if (rating < 2400) {
    return kmaster;
  } else {
    return kgm;
  }
}

//! function to give color according to contribution
Color contributionColor(int contribution) {
  if (contribution < 0) {
    return kgm;
  } else if (contribution == 0) {
    return knewbie;
  } else {
    return kpupil;
  }
}

//! function to give color 
Color contestColor(String phase) {
  if(phase == "BEFORE") {
    return kpupil;
  }
  else if(phase == "CODING") {
    return kexpert;
  }
  else {
    return kgm;
  }
}
