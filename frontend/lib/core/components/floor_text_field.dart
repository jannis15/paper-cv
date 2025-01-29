import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/core/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

InputDecoration outlinedInputDecoration({String? labelText}) => InputDecoration(
      labelText: labelText,
      alignLabelWithHint: true,
      border: OutlineInputBorder(),
      contentPadding: AppSizes.inputPadding,
    );

class FloorTextField extends StatefulWidget {
  final String? text;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String value)? onChanged;
  final void Function(String value)? onEditingComplete;
  final void Function(String value)? onSubmitted;
  final void Function(String value)? onTapOutSide;
  final TextInputAction? textInputAction;
  final InputDecoration? decoration;
  final void Function()? onTap;
  final bool? readOnly;
  final int? minLines;
  final int? maxLines;

  final TextStyle? style;

  const FloorTextField({
    super.key,
    this.text,
    this.controller,
    this.onChanged,
    this.decoration,
    this.onTap,
    this.readOnly,
    this.style,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTapOutSide,
    this.keyboardType,
    this.inputFormatters,
    this.focusNode,
    this.minLines,
    this.maxLines = 1,
    this.textInputAction,
  });

  @override
  State<FloorTextField> createState() => _FloorTextFieldState();
}

class _FloorTextFieldState extends State<FloorTextField> {
  bool _firstBuild = true;
  late final TextEditingController _controller;
  late final Debouncer? _debouncer = widget.onChanged != null ? Debouncer(milliseconds: 300) : null;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController(text: widget.text);
    if (widget.controller != null && widget.text != null) {
      _controller.text = widget.text!;
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_firstBuild && widget.text != null) {
      _controller.text = widget.text!;
    }
    _firstBuild = false;
    return TextField(
      controller: _controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      onEditingComplete: widget.onEditingComplete != null ? () => widget.onEditingComplete!(_controller.text) : null,
      onSubmitted: widget.onSubmitted != null ? (value) => widget.onSubmitted!(_controller.text) : null,
      onTap: widget.onTap,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged != null
          ? (value) {
              _debouncer?.run(() => widget.onChanged!(value));
            }
          : null,
      onTapOutside: (event) {
        if (widget.onTapOutSide != null) {
          widget.onTapOutSide!(_controller.text);
        }
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textInputAction: widget.textInputAction,
      decoration: widget.decoration,
      readOnly: widget.readOnly ?? false,
      style: widget.style,
    );
  }
}
