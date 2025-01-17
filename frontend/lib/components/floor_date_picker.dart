import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paper_cv/components/floor_icon_button.dart';
import 'package:paper_cv/components/floor_text_field.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/date_format_utils.dart';
import 'package:paper_cv/utils/widget_utils.dart';

import '../config/settings_notifier.dart';

class FloorDatePicker extends ConsumerStatefulWidget {
  final DateTime? value;
  final Function(DateTime dateTime) onSetValue;
  final String? labelText;
  final Widget? overlayPicker;

  const FloorDatePicker({super.key, this.value, required this.onSetValue, this.labelText, this.overlayPicker});

  @override
  ConsumerState<FloorDatePicker> createState() => _FloorDatePickerState();
}

class _FloorDatePickerState extends ConsumerState<FloorDatePicker> {
  String _toDateString(String locale, DateTime date) => dateFormatWeekdayDate(locale).format(date);

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsNotifierProvider);
    void pickDate() async {
      final currentDate = DateTime.now();

      late final DateTime? resultValue;
      if (widget.overlayPicker != null) {
        resultValue = await showDialog<DateTime>(context: context, builder: (context) => widget.overlayPicker!);
      } else {
        resultValue = await showDatePicker(
          context: context,
          fieldHintText: 'TT.MM.JJJJ',
          firstDate: DateTime(2000),
          lastDate: DateTime(2099, 12, 31),
          currentDate: currentDate,
          initialDate: widget.value,
        );
      }

      if (resultValue != null) {
        widget.onSetValue(resultValue);
      }
    }

    return InkWell(
      onTap: () {},
      child: FloorTextField(
        text: widget.value != null ? _toDateString(settings.locale, widget.value!) : null,
        readOnly: true,
        onTap: pickDate,
        style: textTheme.bodyLarge,
        decoration: InputDecoration(
          contentPadding: AppSizes.inputPadding,
          border: OutlineInputBorder(),
          labelText: widget.labelText ?? 'Datum',
          suffixIconConstraints: BoxConstraints(maxWidth: AppSizes.kIconButtonSize + AppSizes.kMinInputGap, maxHeight: AppSizes.kIconButtonSize),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: AppSizes.kMinInputGap),
            child: FloorIconButton(
              iconData: Icons.today,
              tooltip: 'Datum ändern',
              onPressed: pickDate,
            ),
          ),
        ),
      ),
    );
  }
}
