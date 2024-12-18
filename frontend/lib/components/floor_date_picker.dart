import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paper_cv/components/floor_icon_button.dart';
import 'package:paper_cv/components/floor_text_field.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/widget_utils.dart';

class FloorDatePicker extends StatefulWidget {
  final DateTime? value;
  final Function(DateTime dateTime) onSetValue;
  final String? labelText;
  final Widget? overlayPicker;

  const FloorDatePicker({super.key, this.value, required this.onSetValue, this.labelText, this.overlayPicker});

  @override
  State<FloorDatePicker> createState() => _FloorDatePickerState();
}

class _FloorDatePickerState extends State<FloorDatePicker> {
  String _toDateString(DateTime date) => DateFormat.yMEd('de').format(date);

  @override
  Widget build(BuildContext context) {
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
        text: widget.value != null ? _toDateString(widget.value!) : null,
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
