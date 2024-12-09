import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paper_cv/components/floor_app_bar.dart';
import 'package:paper_cv/components/floor_buttons.dart';
import 'package:paper_cv/components/floor_card.dart';
import 'package:paper_cv/components/floor_layout_body.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:paper_cv/utils/widget_utils.dart';

class FloorSettingsScreen extends StatefulWidget {
  const FloorSettingsScreen({super.key});

  @override
  State<FloorSettingsScreen> createState() => _FloorSettingsScreenState();
}

class _FloorSettingsScreenState extends State<FloorSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: useDesktopLayout ? colorScheme.surfaceContainer : null,
      appBar: FloorAppBar(
        title: Text('Einstellungen'),
        showBackButton: !useDesktopLayout,
      ),
      body: FloorLayoutBody(
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
      ),
    );
  }
}
