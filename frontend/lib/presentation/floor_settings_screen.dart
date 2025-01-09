import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paper_cv/components/floor_buttons.dart';
import 'package:paper_cv/components/floor_card.dart';
import 'package:paper_cv/components/floor_layout_body.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/list_utils.dart';

class FloorSettingsScreen extends StatefulWidget {
  const FloorSettingsScreen({super.key});

  @override
  State<FloorSettingsScreen> createState() => _FloorSettingsScreenState();
}

class _FloorSettingsScreenState extends State<FloorSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return FloorLayoutBody(
      title: Text('Einstellungen'),
      sideChildren: [
        FloorTransparentButton(
          text: 'Zurück',
          iconData: Icons.chevron_left,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.kGap),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: AppSizes.kDesktopWidth,
            child: ColumnGap(
              gap: AppSizes.kSmallGap,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FloorCard(
                  onTap: () => showLicensePage(context: context),
                  child: RowGap(
                    gap: AppSizes.kGap,
                    children: [
                      Icon(FontAwesomeIcons.award),
                      Expanded(child: Text('Lizenzen')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
