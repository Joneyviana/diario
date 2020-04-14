import 'package:intl/intl.dart';

String formatData(DateTime date) {
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }