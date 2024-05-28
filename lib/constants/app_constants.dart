// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class AppConstants {
  static const STATUS_SUCCESS = "Success";
  static const STATUS_ERROR = "Error";
  static const kGoogleApiKey = "AIzaSyCNaxwGDO4Wg6GFWKpp0Z8Dagiwx0QnafA";

  static getDirection(lat,lng) async {
    if (Platform.isAndroid) {
      var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
      if (await canLaunchUrl(uri)) {
        await launch(uri.toString());
      } else {
        throw 'Could not launch Maps';
      }
    } else if (Platform.isIOS) {
      var url = Uri.parse('https://maps.apple.com/?q=$lat,$lng');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch Maps';
      }
    }
  }

  static googleMap(lat,lng) async {
    var url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch Maps';
    }
  }
}
