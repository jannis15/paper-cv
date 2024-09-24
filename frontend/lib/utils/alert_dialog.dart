import 'package:flutter/material.dart';

enum AlertOption {
  yes,
  no,
  cancel;

  String get optionText {
    switch (this) {
      case AlertOption.yes:
        return 'Ja';
      case AlertOption.no:
        return 'Nein';
      case AlertOption.cancel:
        return 'Abbrechen';
      default:
        throw Exception('AlertOption unbekannt: $this');
    }
  }
}

class AlertOptionData {
  final AlertOption option;
  final String? customText;

  AlertOptionData({
    required this.option,
    this.customText,
  });

  factory AlertOptionData.yes({String? customText}) => AlertOptionData(option: AlertOption.yes, customText: customText);

  factory AlertOptionData.no({String? customText}) => AlertOptionData(option: AlertOption.no, customText: customText);

  factory AlertOptionData.cancel({String? customText}) => AlertOptionData(option: AlertOption.cancel, customText: customText);
}

Future<AlertOption?> showAlertDialog(
  BuildContext context, {
  required String title,
  String? content,
  bool barrierDismissible = true,
  required List<AlertOptionData> optionData,
}) {
  TextButton buildOptionButton(AlertOptionData alertOptionData) => TextButton(
        onPressed: () {
          Navigator.of(context).pop<AlertOption>(alertOptionData.option);
        },
        child: Text(
          alertOptionData.customText ?? alertOptionData.option.optionText,
          textAlign: TextAlign.end,
        ),
      );

  List<TextButton> optionButtons = optionData.map((AlertOptionData optionData) => buildOptionButton(optionData)).toList();

  return showDialog<AlertOption>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) => AlertDialog(
      actions: optionButtons,
      scrollable: true,
      title: Text(title, textAlign: TextAlign.start, softWrap: true),
      content: content != null ? Text(content) : null,
    ),
  );
}
