
import 'package:intl/intl.dart';

String getCurrentDay(DateTime dateTime){
  DateTime currentDay = dateTime.subtract(Duration(days: dateTime.weekday - 1));


    var formatter = new DateFormat('yyyy-MM-dd');

    String formatted = formatter.format(currentDay);

    return formatted;
}

String getLastDayOfWeek(DateTime dateTime){
  DateTime currentDay = dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));


    var formatter = new DateFormat('yyyy-MM-dd');

    String formatted = formatter.format(currentDay);

    return formatted;
}

String getLastDayOfMonth(DateTime dateTime){
  DateTime currentDay = DateTime(dateTime.year, dateTime.month + 1, 0);

    var formatter = new DateFormat('yyyy-MM-dd');

    String formatted = formatter.format(currentDay);

    return formatted;
}

