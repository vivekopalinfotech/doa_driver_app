import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          duration: const Duration(milliseconds: 3000),
          content: Center(
              child: Text(message, textScaleFactor: 1,
                textAlign: TextAlign.center,
                style:  const TextStyle(
                    color: Colors.white),))));
}