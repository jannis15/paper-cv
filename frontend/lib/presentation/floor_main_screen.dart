import 'package:flutter/services.dart';
import 'package:paper_cv/components/floor_app_bar.dart';
import 'package:paper_cv/components/floor_card.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/data/repositories/floor_repository.dart';
import 'package:paper_cv/components/floor_contact_banner.dart';
import 'package:paper_cv/presentation/floor_overview_screen.dart';
import 'package:paper_cv/presentation/floor_settings_screen.dart';
import 'package:paper_cv/utils/alert_dialog.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:paper_cv/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class FloorMainScreen extends StatefulWidget {
  const FloorMainScreen({super.key});

  @override
  State<FloorMainScreen> createState() => _FloorMainScreenState();
}

class _FloorMainScreenState extends State<FloorMainScreen> {
  final ScrollController _scrollController = ScrollController();
  late final _previewStream = FloorRepository.watchDocumentPreviews();
  bool _showBanner = true;
  bool _isSelectionMode = false;
  final Set<DocumentPreviewDto> _selectedDocuments = {};

  void _disableSelectionMode() {
    _isSelectionMode = false;
    _selectedDocuments.clear();
  }

  void _selectDocument(DocumentPreviewDto document) {
    if (_selectedDocuments.contains(document)) {
      _selectedDocuments.remove(document);
    } else {
      _selectedDocuments.add(document);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildPreviewCard(DocumentPreviewDto documentPreview) => FloorCard(
          onLongPress: () {
            _isSelectionMode = !_isSelectionMode;
            if (_isSelectionMode) {
              _selectDocument(documentPreview);
            } else {
              _selectedDocuments.clear();
            }
            setState(() {});
          },
          onTap: _isSelectionMode
              ? () {
                  _selectDocument(documentPreview);
                  setState(() {});
                }
              : () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => FloorOverviewScreen(
                        documentId: documentPreview.uuid,
                      ),
                    ),
                  );
                },
          child: RowGap(
            gap: AppSizes.kGap,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 56,
                width: 56,
                child: _isSelectionMode
                    ? Checkbox(
                        value: _selectedDocuments.contains(documentPreview),
                        onChanged: (_) {
                          _selectDocument(documentPreview);
                          setState(() {});
                        },
                      )
                    : Container(
                        padding: EdgeInsets.all(AppSizes.kGap),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.kBorderRadius),
                          color: colorScheme.secondaryContainer,
                        ),
                        child: Icon(
                          Icons.article,
                          size: AppSizes.kIconSize,
                          color: colorScheme.onSecondaryContainer,
                        ),
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
          confirmDismiss: _isSelectionMode
              ? null
              : (dismissDirection) async {
                  final alertOption = await showAlertDialog(
                    context,
                    title: "'${documentPreview.title.trim().isNotEmpty ? documentPreview.title : 'Gescanntes Dokument'}' löschen?",
                    content: 'Das Dokument wird dadurch unwiderruflich gelöscht!',
                    optionData: [
                      AlertOptionData.cancel(),
                      AlertOptionData.yes(customText: 'Löschen'),
                    ],
                  );
                  return alertOption == AlertOption.yes;
                },
          onDismissed: _isSelectionMode
              ? null
              : (dismissDirection) async {
                  if (documentPreview.uuid != null) {
                    await FloorRepository.deleteDocumentById(documentPreview.uuid!);
                  }
                },
        );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          if (_isSelectionMode) {
            _disableSelectionMode();
            setState(() {});
            return;
          }
          final alertResult = await showAlertDialog(
            context,
            title: 'App verlassen?',
            optionData: [
              AlertOptionData.cancel(),
              AlertOptionData.yes(customText: 'Verlassen'),
            ],
          );
          if (alertResult == AlertOption.yes) {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        appBar: FloorAppBar(
          title: Text(
            _isSelectionMode ? '${_selectedDocuments.length} ${_selectedDocuments.length == 1 ? 'Dokument' : 'Dokumente'} ausgewählt' : 'PaperCV',
          ),
          actions: [
            FloorAppBarIconButton(
              tooltip: 'Einstellungen',
              iconData: Icons.settings,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => FloorSettingsScreen()));
              },
            ),
          ],
        ),
        floatingActionButton: _isSelectionMode
            ? RowGap(
                mainAxisAlignment: MainAxisAlignment.end,
                gap: AppSizes.kSmallGap,
                children: [
                  FloatingActionButton.extended(
                    heroTag: UniqueKey(),
                    icon: Icon(Icons.delete),
                    label: Text('Löschen'),
                    backgroundColor: _selectedDocuments.isEmpty ? Color.alphaBlend(colorScheme.surface.withOpacity(.75), Colors.red) : Colors.red,
                    foregroundColor: _selectedDocuments.isEmpty ? Color.alphaBlend(colorScheme.surface.withOpacity(.75), Colors.white) : Colors.white,
                    onPressed: _selectedDocuments.isEmpty
                        ? null
                        : () async {
                            final alertOption = await showAlertDialog(
                              context,
                              title: '${_selectedDocuments.length} ${_selectedDocuments.length == 1 ? 'Dokument' : 'Dokumente'} löschen?',
                              content:
                                  '${_selectedDocuments.length == 1 ? 'Das Dokument wird' : 'Die Dokumente werden'} dadurch unwiderruflich gelöscht!',
                              optionData: [
                                AlertOptionData.cancel(),
                                AlertOptionData.yes(customText: 'Löschen'),
                              ],
                            );
                            if (alertOption == AlertOption.yes) {
                              try {
                                for (final document in _selectedDocuments) {
                                  await FloorRepository.deleteDocumentById(document.uuid!);
                                }
                              } finally {
                                _disableSelectionMode();
                                if (mounted) setState(() {});
                              }
                            }
                          },
                  ),
                  FloatingActionButton.extended(
                    heroTag: UniqueKey(),
                    icon: Icon(Icons.cancel),
                    label: Text('Abbrechen'),
                    backgroundColor: colorScheme.surfaceContainer,
                    foregroundColor: colorScheme.onSurface,
                    onPressed: () {
                      _disableSelectionMode();
                      setState(() {});
                    },
                  ),
                ],
              )
            : FloatingActionButton.extended(
                heroTag: UniqueKey(),
                icon: Icon(Icons.post_add),
                label: Text('Erfassen'),
                onPressed: () async {
                  await Navigator.of(context).push(MaterialPageRoute(builder: (_) => FloorOverviewScreen()));
                },
              ),
        body: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.all(AppSizes.kGap),
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: AppSizes.kDesktopWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedSize(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    child: _showBanner
                        ? Padding(
                            padding: EdgeInsets.only(bottom: AppSizes.kGap),
                            child: FloorContactBanner(
                                onCloseBanner: () => setState(() {
                                      _showBanner = false;
                                    })),
                          )
                        : SizedBox(),
                  ),
                  StreamBuilder(
                    stream: _previewStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString(), style: TextStyle(color: colorScheme.error));
                      } else if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        final documentPreviews = snapshot.data!;
                        if (documentPreviews.isEmpty) {
                          return Text('Keine Dokumente vorhanden');
                        } else {
                          return ColumnGap(
                            gap: AppSizes.kSmallGap,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ...documentPreviews.map(buildPreviewCard),
                              SizedBox(height: 64),
                            ],
                          );
                        }
                      }
                    },
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
