import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:paper_cv/components/floor_buttons.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/date_format_utils.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:paper_cv/utils/widget_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class FloorDatePickerDialog extends StatefulWidget {
  final DateTime? selectedDay;
  final List<DateTime>? holidays;

  const FloorDatePickerDialog({super.key, this.selectedDay, this.holidays});

  @override
  State<FloorDatePickerDialog> createState() => _FloorDatePickerDialogState();
}

class _FloorDatePickerDialogState extends State<FloorDatePickerDialog> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay = widget.selectedDay ?? DateTime.now();
  late DateTime? _selectedDay = widget.selectedDay;
  late final List<DateTime> _holidays = widget.holidays ?? [];

  bool _isHoliday(DateTime day) => _holidays.firstWhereOrNull((element) => isSameDay(element, day)) != null;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(AppSizes.kGap),
      child: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.kGap),
          child: ColumnGap(
            gap: AppSizes.kGap,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ColumnGap(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                gap: AppSizes.kSmallGap,
                children: [
                  Text(
                    _selectedDay != null ? dateFormatWeekdayDate.format(_selectedDay!) : 'Kein Datum ausgewählt',
                    style: textTheme.titleMedium?.copyWith(color: _selectedDay != null ? colorScheme.onSurface : colorScheme.outlineVariant),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - (AppSizes.kGap * 2),
                    height: 300,
                    child: TableCalendar(
                      locale: 'de',
                      rowHeight: 40,
                      calendarFormat: _calendarFormat,
                      availableCalendarFormats: {CalendarFormat.month: 'Monat'},
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        titleTextStyle: textTheme.titleMedium!.copyWith(overflow: TextOverflow.ellipsis),
                        headerMargin: EdgeInsets.zero,
                        headerPadding: EdgeInsets.zero,
                        leftChevronPadding: EdgeInsets.all(AppSizes.kSmallGap),
                        leftChevronMargin: EdgeInsets.zero,
                        rightChevronPadding: EdgeInsets.all(AppSizes.kSmallGap),
                        rightChevronMargin: EdgeInsets.zero,
                      ),
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      holidayPredicate: _isHoliday,
                      onDaySelected: (selectedDay, focusedDay) {
                        _selectedDay = selectedDay;
                        setState(() {});
                      },
                      calendarStyle: CalendarStyle(
                        todayDecoration: ShapeDecoration(
                            shape: CircleBorder(side: BorderSide(color: colorScheme.primary)),
                            color: _isHoliday(DateTime.now()) ? Colors.amber : Colors.transparent),
                        todayTextStyle: TextStyle(color: _isHoliday(DateTime.now()) ? Colors.black : colorScheme.onSurface),
                        selectedDecoration: ShapeDecoration(shape: CircleBorder(), color: colorScheme.primary),
                        selectedTextStyle: TextStyle(color: colorScheme.onPrimary),
                        holidayDecoration: ShapeDecoration(shape: CircleBorder(), color: Colors.amber),
                        holidayTextStyle: TextStyle(color: Colors.black),
                      ),
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                      firstDay: DateTime.utc(2000, 1, 1),
                      lastDay: DateTime.utc(2099, 12, 31),
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      focusedDay: _focusedDay,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloorTransparentButton(
                        foregroundColor: colorScheme.primary,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Abbrechen',
                      ),
                      FloorTransparentButton(
                        foregroundColor: colorScheme.primary,
                        onPressed: () {
                          Navigator.of(context).pop(_selectedDay);
                        },
                        text: 'Bestätigen',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
