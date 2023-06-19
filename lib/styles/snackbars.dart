import 'package:flutter/material.dart';

SnackBar makeSnackBar({required String text, required Color color, required BuildContext context}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  return SnackBar(
    content: Center(child: Text(text)),
    backgroundColor: color,
    dismissDirection: DismissDirection.horizontal,
  );
}

