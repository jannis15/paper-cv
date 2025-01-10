import 'package:flutter/material.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/widget_utils.dart';

class FloorToggleSwitch<E extends Enum> extends StatefulWidget {
  final List<E> options;
  final List<String> labels;
  final List<IconData> icons;
  final E initialOption;
  final ValueChanged<E> onOptionChanged;

  FloorToggleSwitch({
    super.key,
    required this.options,
    required this.labels,
    required this.icons,
    required this.initialOption,
    required this.onOptionChanged,
  })  : assert(icons.length == 2),
        assert(options.length == 2),
        assert(labels.length == 2);

  @override
  FloorToggleSwitchState<E> createState() => FloorToggleSwitchState<E>();
}

class FloorToggleSwitchState<E extends Enum> extends State<FloorToggleSwitch<E>> {
  static const double _kOptionWidth = 60;

  late E selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialOption;
  }

  void _onOptionTapped(E option) {
    setState(() {
      selectedOption = option;
    });
    widget.onOptionChanged(option);
  }

  Widget _buildOption(int index) {
    final borderRadius = AppSizes.kComponentHeight / 2;
    final isSelected = selectedOption == widget.options[index];
    final iconColor = isSelected ? colorScheme.onSecondary : colorScheme.onSurface;
    final checkIcon = isSelected ? Icon(Icons.check, color: colorScheme.onSecondary) : SizedBox.shrink();
    final optionColor = isSelected ? colorScheme.secondary : Colors.transparent;

    final borderRadiusValue = BorderRadius.only(
      topLeft: index == 0 ? Radius.circular(borderRadius) : Radius.zero,
      bottomLeft: index == 0 ? Radius.circular(borderRadius) : Radius.zero,
      topRight: index == 1 ? Radius.circular(borderRadius) : Radius.zero,
      bottomRight: index == 1 ? Radius.circular(borderRadius) : Radius.zero,
    );

    return Tooltip(
      message: widget.labels[index],
      child: InkWell(
        onTap: () => _onOptionTapped(widget.options[index]),
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: _kOptionWidth,
          height: AppSizes.kComponentHeight,
          decoration: BoxDecoration(
            color: optionColor,
            borderRadius: borderRadiusValue,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              checkIcon,
              Icon(
                widget.icons[index],
                color: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: AppSizes.kComponentHeight,
      decoration: ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(color: theme.colorScheme.outline),
        ),
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(0),
          Container(
            width: 1.0,
            color: theme.colorScheme.outline,
            height: AppSizes.kComponentHeight,
          ),
          _buildOption(1),
        ],
      ),
    );
  }
}
