import 'dart:math';

import 'package:intl/intl.dart';

class AppUtils{
  static String convertDate(String inputDate) {
    final inputFormat = DateFormat('dd/MM/yy hh:mm:ss a');
    final outputFormat = DateFormat('dd/MM/yyyy');

    final DateTime dateTime = inputFormat.parse(inputDate);
    final String formattedDate = outputFormat.format(dateTime);

    return formattedDate;
  }
  static String convertTime(String inputTime) {
    final inputFormat = DateFormat('hh:mm:ss a');
    final outputFormat = DateFormat('hh:mm a');

    final DateTime dateTime = inputFormat.parse(inputTime);
    final String formattedTime = outputFormat.format(dateTime);

    return formattedTime;
  }

  static String formattedDate(String isoDate) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat('MM/dd/yyyy');

    final DateTime dateTime = inputFormat.parse(isoDate);
    final String formatDate = outputFormat.format(dateTime);

    return formatDate;
  }
  static String splitDate(String isoDate) {
    var data = isoDate.split("/");

    return "${data[1]}/${data[2]}/${data[0]}"; //formatter.add_Hm().format(time);
  }
  static String splitTime(String inputTime) {
    final inputFormat = DateFormat('hh:mm');
    final outputFormat = DateFormat('hh:mm a');

    final DateTime dateTime = inputFormat.parse(inputTime);
    final String formattedTime = outputFormat.format(dateTime);

    return formattedTime;
  }
  static double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }
  static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers

    // Convert latitude and longitude from degrees to radians
    double lat1Rad = degreesToRadians(lat1);
    double lon1Rad = degreesToRadians(lon1);
    double lat2Rad = degreesToRadians(lat2);
    double lon2Rad = degreesToRadians(lon2);

    // Calculate the differences between the coordinates
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    // Calculate the Haversine distance
    double a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance * 1000; // Convert distance to meters
  }

  static double calculateDistanceInMiles(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadiusMiles = 3958.8; // Radius of the Earth in miles

    // Convert latitude and longitude from degrees to radians
    double lat1Rad = degreesToRadians(lat1);
    double lon1Rad = degreesToRadians(lon1);
    double lat2Rad = degreesToRadians(lat2);
    double lon2Rad = degreesToRadians(lon2);

    // Calculate the differences between the coordinates
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    // Calculate the Haversine distance
    double a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadiusMiles * c;

    return distance;
  }
  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }
}

