import 'package:intl/intl.dart';

final dateFormatDateTime = DateFormat('dd.MM.yy HH:mm');

DateFormat dateFormatWeekdayDate(String locale) => DateFormat.yMEd(locale);
