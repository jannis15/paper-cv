import 'package:intl/intl.dart';

DateFormat dateFormatDateTime(String locale) => DateFormat.yMd(locale).add_jm();

DateFormat dateFormatWeekdayDate(String locale) => DateFormat.yMEd(locale);
