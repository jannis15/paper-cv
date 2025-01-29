import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paper_cv/core/components/floor_buttons.dart';
import 'package:paper_cv/core/components/floor_card.dart';
import 'package:paper_cv/core/components/floor_dropdown.dart';
import 'package:paper_cv/core/components/floor_layout_body.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/config/settings_notifier.dart';
import 'package:paper_cv/core/utils/list_utils.dart';

import '../../../../config/supported_locales.dart';
import '../../../../generated/l10n.dart';

class FloorSettingsScreen extends ConsumerWidget {
  const FloorSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);
    final settingsNotifier = ref.watch(settingsNotifierProvider.notifier);

    return FloorLayoutBody(
      title: Text(S.current.settings),
      sideChildren: [
        FloorTransparentButton(
          text: S.current.back,
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
              gap: AppSizes.kGap,
              children: [
                ColumnGap(
                  gap: AppSizes.kSmallGap,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(S.current.language, style: Theme.of(context).textTheme.labelMedium),
                    FloorDropdown<String>(
                      iconData: Icons.language,
                      items: SupportedLocale.values
                          .map(
                            (SupportedLocale locale) => DropdownMenuItem<String>(
                              value: locale.key,
                              child: RowGap(
                                gap: AppSizes.kGap,
                                children: [
                                  Text(
                                    locale.title,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      value: settings.locale,
                      onChanged: (value) {
                        settingsNotifier.setLocale(value!);
                      },
                    ),
                  ],
                ),
                ColumnGap(
                  gap: AppSizes.kSmallGap,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(S.current.legal, style: Theme.of(context).textTheme.labelMedium),
                    SizedBox(
                      height: AppSizes.kComponentHeight + 2 * AppSizes.kSmallGap,
                      child: FloorCard(
                        onTap: () => showLicensePage(context: context),
                        child: Row(
                          children: [
                            Expanded(
                              child: RowGap(
                                gap: AppSizes.kGap,
                                children: [
                                  Icon(Icons.copyright),
                                  Expanded(child: Text(S.current.licenses)),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right, size: AppSizes.kIconSize),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
