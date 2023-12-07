import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  void handleNotification() {
    // Trigger refresh in the page
    notifyListeners();
  }
}