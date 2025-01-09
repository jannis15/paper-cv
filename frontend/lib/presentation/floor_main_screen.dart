import 'package:flutter/services.dart';
import 'package:paper_cv/components/floor_app_bar.dart';
import 'package:paper_cv/components/floor_buttons.dart';
import 'package:paper_cv/components/floor_card.dart';
import 'package:paper_cv/components/floor_chip.dart';
import 'package:paper_cv/components/floor_icon_button.dart';
import 'package:paper_cv/components/floor_layout_body.dart';
import 'package:paper_cv/components/floor_wrap_view.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/data/repositories/floor_repository.dart';
import 'package:paper_cv/components/floor_contact_banner.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:paper_cv/package_info.dart';
import 'package:paper_cv/presentation/floor_info_screen.dart';
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
  DocumentPreviewDto? _hoverDocumentPreview;
  final ScrollController _scrollController = ScrollController();
  late Stream<List<DocumentPreviewDto>> _previewStream;
  bool _showBanner = true;
  bool _isSelectionMode = false;
  final Set<DocumentPreviewDto> _selectedDocuments = {};
  DocumentSortType _sortType = DocumentSortType.modifiedAt;
  SortDirection _sortDirection = SortDirection.descending;

  String get _selectedText => '${_selectedDocuments.length} ${_selectedDocuments.length == 1 ? 'Dokument' : 'Dokumente'} ausgewählt';

  @override
  void initState() {
    super.initState();
    _assignPreviewStream();
  }

  void _assignPreviewStream() {
    _previewStream = FloorRepository.watchDocumentPreviews(sortType: _sortType, sortDirection: _sortDirection);
  }

  void _disableSelectionMode() {
    _isSelectionMode = false;
    _selectedDocuments.clear();
    _hoverDocumentPreview = null;
  }

  void _selectDocument(DocumentPreviewDto document) {
    if (_selectedDocuments.contains(document)) {
      _selectedDocuments.remove(document);
      if (_selectedDocuments.length == 0) {
        _disableSelectionMode();
        setState(() {});
      }
    } else {
      _selectedDocuments.add(document);
      if (_selectedDocuments.length == 1) {
        _isSelectionMode = true;
        setState(() {});
      }
    }
  }

  void _deleteSelectedDocuments() async {
    final alertOption = await showAlertDialog(
      context,
      title: '${_selectedDocuments.length} ${_selectedDocuments.length == 1 ? 'Dokument' : 'Dokumente'} löschen?',
      content: '${_selectedDocuments.length == 1 ? 'Das Dokument wird' : 'Die Dokumente werden'} dadurch unwiderruflich gelöscht!',
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
  }

  void _seeInfo() async => showDialog(context: context, barrierLabel: 'ewfiji', builder: (_) => FloorInfoScreen());

  void _openOverviewScreen() async => await Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => FloorOverviewScreen(),
          transitionDuration: Duration(seconds: 0),
        ),
      );

  void _changeSortType(DocumentSortType newSortType) {
    if (_sortType == newSortType) {
      _sortDirection = _sortDirection.opposite;
    } else {
      _sortType = newSortType;
    }
    _assignPreviewStream();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget buildPreviewCard(DocumentPreviewDto documentPreview) => MouseRegion(
          onEnter: (event) {
            _hoverDocumentPreview = documentPreview;
            setState(() {});
          },
          onExit: (event) {
            _hoverDocumentPreview = null;
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: _selectedDocuments.contains(documentPreview) ? colorScheme.primary : Colors.transparent,
                width: 1.5,
              ),
              borderRadius: BorderRadius.all(Radius.circular(AppSizes.kBorderRadius)),
            ),
            child: FloorCard(
              onLongPress: useDesktopLayout
                  ? null
                  : () {
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
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => FloorOverviewScreen(documentId: documentPreview.uuid),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                    },
              child: ColumnGap(
                gap: AppSizes.kSmallGap,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSizes.kBorderRadius),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.article,
                          size: AppSizes.kComponentHeight,
                          color: colorScheme.secondary,
                        ),
                        Positioned(
                          top: AppSizes.kSmallGap / 2,
                          left: AppSizes.kSmallGap / 2,
                          child: AnimatedOpacity(
                            opacity: _isSelectionMode || _hoverDocumentPreview == documentPreview ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 200),
                            child: Checkbox(
                              value: _selectedDocuments.contains(documentPreview),
                              onChanged: (_) {
                                _selectDocument(documentPreview);
                                setState(() {});
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RowGap(
                        gap: AppSizes.kSmallGap,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Flexible(
                            child: Text(
                              documentPreview.title.trim().isNotEmpty ? documentPreview.title : 'Gescanntes Dokument',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleMedium,
                            ),
                          ),
                          if (documentPreview.isExample)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: AppSizes.kSmallGap),
                              decoration: ShapeDecoration(
                                shape: StadiumBorder(side: BorderSide(color: colorScheme.outline)),
                              ),
                              child: Text(
                                'Beispiel',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: textTheme.titleMedium?.copyWith(color: colorScheme.outline),
                              ),
                            ),
                        ],
                      ),
                      Timeago(
                        builder: (context, value) {
                          return Text(value, style: textTheme.titleMedium?.copyWith(color: colorScheme.outline));
                        },
                        date: documentPreview.modifiedAt,
                        allowFromNow: true,
                        locale: 'de',
                      ),
                    ],
                  )
                ],
              ),
              // child: RowGap(
              //   gap: AppSizes.kGap,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //       height: 56,
              //       width: 56,
              //       child: _isSelectionMode
              //           ? Checkbox(
              //               value: _selectedDocuments.contains(documentPreview),
              //               onChanged: (_) {
              //                 _selectDocument(documentPreview);
              //                 setState(() {});
              //               },
              //             )
              //           : MouseRegion(
              //               onEnter: (event) {
              //                 _hoverDocumentPreview = documentPreview;
              //                 setState(() {});
              //               },
              //               onExit: (event) {
              //                 _hoverDocumentPreview = null;
              //                 setState(() {});
              //               },
              //               child: GestureDetector(
              //                 onTap: () {
              //                   _isSelectionMode = true;
              //                   _selectDocument(documentPreview);
              //                   setState(() {});
              //                 },
              //                 child: Container(
              //                   padding: EdgeInsets.all(AppSizes.kGap),
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(AppSizes.kBorderRadius),
              //                     color: colorScheme.secondary,
              //                   ),
              //                   child: Icon(
              //                     useDesktopLayout && _hoverDocumentPreview == documentPreview ? Icons.check_box_outline_blank : Icons.article,
              //                     size: AppSizes.kIconSize,
              //                     color: colorScheme.onSecondary,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //     ),
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           RowGap(
              //             gap: AppSizes.kSmallGap,
              //             crossAxisAlignment: CrossAxisAlignment.baseline,
              //             children: [
              //               Text(
              //                 documentPreview.title.trim().isNotEmpty ? documentPreview.title : 'Gescanntes Dokument',
              //                 style: textTheme.titleMedium,
              //               ),
              //               if (documentPreview.isExample)
              //                 Container(
              //                   padding: EdgeInsets.symmetric(horizontal: AppSizes.kSmallGap),
              //                   decoration: ShapeDecoration(
              //                     shape: StadiumBorder(side: BorderSide(color: colorScheme.outline)),
              //                   ),
              //                   child: Text('Beispiel', style: textTheme.titleMedium?.copyWith(color: colorScheme.outline)),
              //                 ),
              //             ],
              //           ),
              //           Timeago(
              //             builder: (context, value) {
              //               return Text(value, style: textTheme.titleMedium?.copyWith(color: colorScheme.outline));
              //             },
              //             date: documentPreview.modifiedAt,
              //             allowFromNow: true,
              //             locale: 'de',
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              confirmDismiss: _isSelectionMode || useDesktopLayout
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
              onDismissed: _isSelectionMode || useDesktopLayout
                  ? null
                  : (dismissDirection) async {
                      if (documentPreview.uuid != null) {
                        await FloorRepository.deleteDocumentById(documentPreview.uuid!);
                      }
                    },
            ),
          ),
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
      child: FloorLayoutBody(
        title: _isSelectionMode && !useDesktopLayout
            ? Text(_selectedText)
            : RowGap(
                gap: AppSizes.kSmallGap,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text('PaperCV'),
                  Text(
                    '${packageInfo.version}+${packageInfo.buildNumber}',
                    style: textTheme.labelMedium?.copyWith(color: colorScheme.outline),
                  ),
                ],
              ),
        actions: [
          FloorAppBarIconButton(
            tooltip: 'Einstellungen',
            iconData: Icons.settings,
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => FloorSettingsScreen(),
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
          ),
        ],
        floatingActionButton: useDesktopLayout
            ? null
            : _isSelectionMode
                ? RowGap(
                    mainAxisAlignment: MainAxisAlignment.end,
                    gap: AppSizes.kSmallGap,
                    children: [
                      FloatingActionButton.extended(
                        heroTag: UniqueKey(),
                        icon: Icon(Icons.delete),
                        label: Text('Löschen'),
                        backgroundColor: _selectedDocuments.isEmpty ? Color.alphaBlend(colorScheme.surface.withOpacity(.75), Colors.red) : Colors.red,
                        foregroundColor:
                            _selectedDocuments.isEmpty ? Color.alphaBlend(colorScheme.surface.withOpacity(.75), Colors.white) : Colors.white,
                        onPressed: _selectedDocuments.isEmpty ? null : _deleteSelectedDocuments,
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
                : ColumnGap(
                    gap: AppSizes.kGap,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        heroTag: UniqueKey(),
                        backgroundColor: colorScheme.surfaceContainer,
                        foregroundColor: colorScheme.onSurface,
                        onPressed: _seeInfo,
                        icon: Icon(Icons.info),
                        label: Text('Info'),
                      ),
                      FloatingActionButton.extended(
                        heroTag: UniqueKey(),
                        onPressed: _openOverviewScreen,
                        icon: Icon(Icons.post_add),
                        label: Text('Erfassen'),
                      )
                    ],
                  ),
        sideChildren: [
          FloorOutlinedButton(
            text: 'Erfassen',
            iconData: Icons.post_add,
            onPressed: _openOverviewScreen,
          ),
          FloorTransparentButton(
            text: 'Mehr erfahren',
            iconData: Icons.info,
            onPressed: _seeInfo,
          ),
        ],
        child: SingleChildScrollView(
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
                  AnimatedSize(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    child: _isSelectionMode && useDesktopLayout
                        ? Padding(
                            padding: EdgeInsets.only(bottom: AppSizes.kGap),
                            child: FloorCard(
                              usePadding: false,
                              child: Padding(
                                padding: EdgeInsets.all(AppSizes.kSmallGap),
                                child: RowGap(
                                  gap: AppSizes.kGap,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FloorIconButton(
                                      backgroundColor: Colors.transparent,
                                      iconData: Icons.close,
                                      onPressed: () {
                                        _disableSelectionMode();
                                        if (mounted) setState(() {});
                                      },
                                    ),
                                    Text(_selectedText, style: textTheme.labelLarge),
                                    FloorIconButton(
                                      backgroundColor: Colors.transparent,
                                      iconData: Icons.delete,
                                      onPressed: _selectedDocuments.isEmpty ? null : _deleteSelectedDocuments,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
                  RowGap(
                    gap: AppSizes.kSmallGap,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Sortiert nach',
                        style: textTheme.labelMedium,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(width: AppSizes.kSmallGap),
                              RowGap(
                                  gap: AppSizes.kSmallGap,
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  children: DocumentSortType.values
                                      .map(
                                        (sortType) => AnimatedSize(
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.easeIn,
                                          child: FloorChip(
                                            iconData: sortType != _sortType
                                                ? null
                                                : _sortDirection == SortDirection.ascending
                                                    ? Icons.arrow_upward
                                                    : Icons.arrow_downward,
                                            text: sortType.name,
                                            isSelected: sortType == _sortType,
                                            onPressed: () => _changeSortType(sortType),
                                          ),
                                        ),
                                      )
                                      .toList()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.kGap),
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
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              double availableWidth = constraints.maxWidth;
                              int itemsPerRow = (availableWidth / 250).floor();
                              itemsPerRow = itemsPerRow < 1 ? 1 : itemsPerRow;

                              return FloorWrapView(
                                itemsPerRow: itemsPerRow,
                                aspectRatio: 29.7 / 21,
                                children: documentPreviews.map(buildPreviewCard).toList(),
                                endGap: useDesktopLayout ? null : SizedBox(height: 64),
                              );
                            },
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
