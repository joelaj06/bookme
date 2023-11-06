import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

abstract class DataFormatter{

  static String getVerboseDateTimeRepresentation(DateTime dateTime) {
    final DateTime now = DateTime.now();
    final DateTime justNow = DateTime.now().subtract(const Duration(minutes: 1));
    final DateTime localDateTime = dateTime.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return 'Just now';
    }

    final String roughTimeString = DateFormat('jm').format(dateTime);
    if (localDateTime.day == now.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return roughTimeString;
    }

    final DateTime yesterday = now.subtract(const Duration(days: 1));

    if (localDateTime.day == yesterday.day && localDateTime.month == yesterday.month && localDateTime.year == yesterday.year) {
      return 'Yesterday, $roughTimeString';
    }

    if (now.difference(localDateTime).inDays < 4) {
      final String weekday = DateFormat('EEEE').format(localDateTime);

      return '$weekday, $roughTimeString';
    }

    return '${DateFormat('yMd').format(dateTime)}, $roughTimeString';

  }

  static NumberFormat getLocalCurrencyFormatter(BuildContext context, {bool includeSymbol = true}){
    final NumberFormat formatter = NumberFormat.currency(
        locale: Localizations.localeOf(context).toString(),name:'Ghana Cedis',
        symbol: includeSymbol ? 'GH¢ ' : '',decimalDigits: 2);
    return formatter;
  }

  ///2022-01-21T05:00:00Z
  static String formatDate(String dateString){
    if(dateString.isEmpty) {
      return dateString;
    }else{
      final DateTime now = DateTime.parse(dateString);
      final String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
      return formattedDate;

    }
  }

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