import 'package:intl/intl.dart';

abstract class DateFormatter{

  ///Eg: "2023-06-30" -> 30th June, 2023
  static String dateToString(String inputDate){
    if(inputDate.isEmpty) {
      return '';
    }
    final DateTime dateTime = DateTime.parse(inputDate);
    final String formattedDate = DateFormat('d MMMM, y').format(dateTime);
    return formattedDate;
  }
}