import 'package:flutter/material.dart';
import 'package:paper_cv/components/floor_app_bar.dart';
import 'package:paper_cv/components/floor_card.dart';
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
    return Scaffold(
      appBar: FloorAppBar(
        title: Text('Einstellungen'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.kGap),
        child: ColumnGap(
          gap: AppSizes.kSmallGap,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FloorCard(
              onTap: () => showLicensePage(context: context),
              child: RowGap(
                gap: AppSizes.kGap,
                children: [
                  Expanded(child: Text('Lizenzen')),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
