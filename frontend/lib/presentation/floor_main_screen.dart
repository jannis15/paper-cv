import 'package:floor_cv/components/floor_app_bar.dart';
import 'package:floor_cv/components/floor_dismissible_card.dart';
import 'package:floor_cv/config/config.dart';
import 'package:floor_cv/data/models/floor_dto_models.dart';
import 'package:floor_cv/data/repositories/floor_repository.dart';
import 'package:floor_cv/utils/alert_dialog.dart';
import 'package:floor_cv/utils/list_utils.dart';
import 'package:floor_cv/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class FloorMainScreen extends StatefulWidget {
  const FloorMainScreen({super.key});

  @override
  State<FloorMainScreen> createState() => _FloorMainScreenState();
}

class _FloorMainScreenState extends State<FloorMainScreen> {
  final ScrollController _scrollController = ScrollController();
  late final _previewStream = FloorRepository.watchDocumentPreviews();

  @override
  Widget build(BuildContext context) {
    Widget buildPreviewCard(DocumentPreviewDto documentPreview) => FloorDismissibleCard(
          onTap: () {},
          child: RowGap(
            gap: AppSizes.kGap,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.kGap),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.kBorderRadius),
                  color: colorScheme.secondaryContainer,
                ),
                child: Icon(
                  Icons.description,
                  size: AppSizes.kIconSize,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(documentPreview.title.trim().isNotEmpty ? documentPreview.title : 'Gescanntes Dokument', style: textTheme.titleMedium),
                    Timeago(
                      builder: (context, value) {
                        return Text(value, style: textTheme.titleMedium?.copyWith(color: colorScheme.outline));
                      },
                      date: documentPreview.modifiedAt,
                      allowFromNow: true,
                      locale: 'de',
                    ),
                  ],
                ),
              ),
            ],
          ),
          confirmDismiss: (dismissDirection) async {
            final alertOption = await showAlertDialog(
              context,
              title: "'${documentPreview.title.trim().isNotEmpty ? documentPreview.title : 'Gescanntes Dokument'}' löschen?",
              content: 'Das Dokument wird dadurch unwiderruflich gelöscht!',
              optionData: [AlertOptionData.yes(customText: 'Löschen'), AlertOptionData.cancel()],
            );
            return alertOption == AlertOption.yes;
          },
          onDismissed: (dismissDirection) async {
            if (documentPreview.uuid != null) {
              await FloorRepository.deleteDocumentById(documentPreview.uuid!);
            }
          },
        );

    return Scaffold(
      appBar: FloorAppBar(
        title: Text('Demo'),
      ),
      floatingActionButton: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: RowGap(
          gap: AppSizes.kSmallGap,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              heroTag: UniqueKey(),
              icon: Icon(Icons.image),
              label: Text('Galerie'),
              onPressed: () async {
                final XFile? photo = await ImagePicker().pickImage(source: ImageSource.gallery);
              },
            ),
            FloatingActionButton.extended(
              heroTag: UniqueKey(),
              icon: Icon(Icons.camera_alt),
              label: Text('Kamera'),
              onPressed: () async {
                final XFile? photo = await ImagePicker().pickImage(source: ImageSource.camera);
              },
            )
          ],
        ),
      ),
      body: StreamBuilder(
        stream: _previewStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString(), style: TextStyle(color: colorScheme.error));
          } else if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            final documentPreviews = snapshot.data!;
            return SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.all(AppSizes.kGap),
              child: ColumnGap(
                gap: AppSizes.kSmallGap,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...documentPreviews.map(buildPreviewCard),
                  SizedBox(height: 64),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
