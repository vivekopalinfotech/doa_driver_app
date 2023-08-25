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


}