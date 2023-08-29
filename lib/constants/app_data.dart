import 'package:doa_driver_app/models/user.dart';
import 'package:flutter/material.dart';


class AppData {
  static const List<Locale> languages = [
    Locale('en'),
    Locale('ar'),
    Locale("ur"),
    Locale("ro"),
    Locale("fr"),
    Locale("de"),
    Locale("it"),
    Locale("id"),
    Locale("es"),
    Locale("sv"),
    Locale("pt"),
    Locale("nl"),
    Locale("br"),
    Locale("pl"),
    Locale("ru"),
    Locale("uk"),
    Locale("vi"),
    Locale("cs"),
    Locale("da"),
    Locale("et"),
    Locale("fil"),
    Locale("el"),
    Locale("hu"),
    Locale("th"),
  ];

  static User? user;
  static String? accessToken;
  static String? sessionId;
  static bool? onlineStatus;

}