import 'package:intl/intl.dart';

String formatterDate(String date){

  final dateType = DateTime.parse(date);

  var formatter = new DateFormat('dd-MM-yyyy');

  String formatted = formatter.format(dateType);

  return formatted;

}