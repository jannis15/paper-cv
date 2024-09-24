import 'package:floor_cv/components/floor_app_bar.dart';
import 'package:floor_cv/components/floor_attachment_card.dart';
import 'package:floor_cv/components/floor_card.dart';
import 'package:floor_cv/components/floor_file_picker.dart';
import 'package:floor_cv/components/floor_loader_overlay.dart';
import 'package:floor_cv/components/floor_text_field.dart';
import 'package:floor_cv/config/config.dart';
import 'package:floor_cv/utils/file_picker_models.dart';
import 'package:floor_cv/utils/list_utils.dart';
import 'package:floor_cv/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class FloorOverviewScreen extends StatefulWidget {
  const FloorOverviewScreen({super.key});

  @override
  State<FloorOverviewScreen> createState() => _FloorOverviewScreenState();
}

class _FloorOverviewScreenState extends State<FloorOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FloorAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.kGap),
        child: ColumnGap(
          gap: AppSizes.kGap,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ColumnGap(
              gap: AppSizes.kSmallGap,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RowGap(
                  gap: 4,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.edit,
                      color: colorScheme.outline,
                      size: AppSizes.kSubIconSize,
                    ),
                    Text(
                      'vor 12 Minuten',
                      style: textTheme.labelMedium?.copyWith(color: colorScheme.outline),
                    ),
                  ],
                ),
                FloorCard(
                  child: ColumnGap(
                    gap: AppSizes.kGap,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Kopfdaten', style: textTheme.titleLarge),
                      ColumnGap(
                        gap: AppSizes.kSmallGap,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FloorTextField(
                            decoration: outlinedInputDecoration(labelText: 'Titel'),
                          ),
                          FloorTextField(
                            decoration: outlinedInputDecoration(labelText: 'Notizen'),
                            minLines: 4,
                            maxLines: null,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FloorAttachmentCard(
              title: 'Aufnahme',
              iconData: Icons.add_a_photo,
              onPickFiles: () async {
                final file = await FloorFilePicker.pickFile(context, pickerOption: FilePickerOption.camera);
                return [file].whereType<SelectedFile>().toList();
              },
              onRemoveFile: (file) {},
            ),
            IntrinsicHeight(
              child: FloorLoaderOverlay(
                loading: true,
                loadingWidget: const SizedBox(),
                child: FloorAttachmentCard(
                  title: 'Scan',
                  iconData: Icons.document_scanner,
                  iconText: 'Scannen',
                  onPickFiles: () async => null,
                  onRemoveFile: (file) {},
                ),
              ),
            ),
            IntrinsicHeight(
              child: FloorLoaderOverlay(
                loading: true,
                loadingWidget: const SizedBox(),
                child: FloorAttachmentCard(
                  title: 'Bericht',
                  iconData: Icons.preview,
                  iconText: 'Vorschau',
                  onPickFiles: () async => null,
                  onRemoveFile: (file) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
