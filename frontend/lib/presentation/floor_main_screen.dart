import 'package:flutter/services.dart';
import 'package:paper_cv/components/floor_app_bar.dart';
import 'package:paper_cv/components/floor_buttons.dart';
import 'package:paper_cv/components/floor_card.dart';
import 'package:paper_cv/components/floor_dropdown_sort.dart';
import 'package:paper_cv/components/floor_icon_button.dart';
import 'package:paper_cv/components/floor_layout_body.dart';
import 'package:paper_cv/components/floor_wrap_view.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/data/repositories/floor_repository.dart';
import 'package:paper_cv/components/floor_contact_banner.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:paper_cv/package_info.dart';

// import 'package:paper_cv/presentation/floor_info_screen.dart';
import 'package:paper_cv/presentation/floor_overview_screen.dart';
import 'package:paper_cv/presentation/floor_settings_screen.dart';
import 'package:paper_cv/utils/alert_dialog.dart';
import 'package:paper_cv/utils/date_format_utils.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:paper_cv/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../components/floor_toggle_switch.dart';
import '../utils/navigator_utils.dart';

class FloorMainScreen extends StatefulWidget {
  const FloorMainScreen({super.key});

  @override
  State<FloorMainScreen> createState() => _FloorMainScreenState();
}

class _FloorMainScreenState extends State<FloorMainScreen> {
  DocumentPreviewDto? _hoverDocumentPreview;
  List<DocumentPreviewDto>? _documentPreviews;
  final GlobalKey<FloorToggleSwitchState<DocumentViewType>> _toggleSwitchKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  late Stream<List<DocumentPreviewDto>> _previewStream;
  bool _showBanner = true;
  bool _isSelectionMode = false;
  final Set<DocumentPreviewDto> _selectedDocuments = {};
  DocumentSortType _sortType = DocumentSortType.documentDate;
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

  // void _seeInfo() async => showDialog(context: context, barrierLabel: 'ewfiji', builder: (_) => FloorInfoScreen());

  void _openOverviewScreen() async => pushNoAnimation(context, widget: FloorOverviewScreen());

  @override
  Widget build(BuildContext context) {
    Widget buildExampleContainer(DocumentPreviewDto documentPreview) => Container(
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
        );

    void sortDocumentPreviews(List<DocumentPreviewDto> documentPreviews, {required DocumentSortType sortType}) {
      _sortDirection = sortType == _sortType ? _sortDirection.opposite : _sortDirection;
      _sortType = sortType;
      documentPreviews.sort((a, b) {
        final sortA = _sortDirection == SortDirection.ascending ? a : b;
        final sortB = _sortDirection == SortDirection.ascending ? b : a;
        switch (_sortType) {
          case DocumentSortType.title:
            return sortA.title.toLowerCase().compareTo(sortB.title.toLowerCase());
          case DocumentSortType.modifiedAt:
            return sortA.modifiedAt.compareTo(sortB.modifiedAt);
          case DocumentSortType.documentDate:
            return sortA.documentDate != null && sortB.documentDate != null ? sortA.documentDate!.compareTo(sortB.documentDate!) : 0;
          default:
            return 0;
        }
      });
      setState(() {});
    }

    Widget buildTimeago(DocumentPreviewDto documentPreview, {Color? color}) => Timeago(
          builder: (context, value) {
            return Text(value, style: textTheme.labelMedium?.copyWith(color: color));
          },
          date: documentPreview.modifiedAt,
          allowFromNow: true,
          locale: 'de',
        );

    Widget buildCheckbox(DocumentPreviewDto documentPreview, {Color? activeColor, Color? checkColor}) => Checkbox(
          value: _selectedDocuments.contains(documentPreview),
          activeColor: activeColor,
          checkColor: checkColor,
          onChanged: (_) {
            _selectDocument(documentPreview);
            setState(() {});
          },
        );

    Widget buildListView(List<DocumentPreviewDto> documentPreviews) {
      Widget _buildTableCell(Widget widget) => widget is Text
          ? Text(
              widget.data ?? '',
              style: TextStyle(),
              textAlign: TextAlign.start,
            )
          : widget;

      DataRow _buildDataRow(DocumentPreviewDto documentPreview) {
        final bool isRowSelected = _isSelectionMode && _selectedDocuments.contains(documentPreview);
        return DataRow(
          onLongPress: useDesktopLayout
              ? null
              : () {
                  _selectDocument(documentPreview);
                  setState(() {});
                },
          selected: isRowSelected,
          onSelectChanged: _isSelectionMode
              ? (selected) {
                  setState(() {
                    if (selected != null && selected) {
                      _selectedDocuments.add(documentPreview);
                    } else {
                      _selectedDocuments.remove(documentPreview);
                      if (_selectedDocuments.isEmpty) _disableSelectionMode();
                    }
                  });
                }
              : (selected) async {
                  if (!(selected ?? true)) return;
                  await pushNoAnimation(context, widget: FloorOverviewScreen(documentId: documentPreview.uuid));
                },
          cells: [
            DataCell(_buildTableCell(
              RowGap(
                gap: AppSizes.kSmallGap,
                children: [
                  Text(documentPreview.title.isNotEmpty ? documentPreview.title : 'Unbenanntes Dokument'),
                  if (documentPreview.isExample) buildExampleContainer(documentPreview),
                ],
              ),
            )),
            DataCell(_buildTableCell(buildTimeago(documentPreview))),
            DataCell(
              _buildTableCell(
                Text(documentPreview.documentDate != null ? dateFormatWeekdayDate.format(documentPreview.documentDate!) : 'Kein Datum'),
              ),
            ),
          ],
        );
      }

      DataColumn buildSortColumn({
        required String label,
        required DocumentSortType sortType,
        required List<DocumentPreviewDto> documentPreviews,
      }) {
        return DataColumn(
          label: RowGap(
            gap: AppSizes.kSmallGap,
            children: [
              if (_sortType == sortType)
                Icon(
                  _sortDirection == SortDirection.ascending ? Icons.arrow_upward : Icons.arrow_downward,
                  size: AppSizes.kSubIconSize,
                  color: colorScheme.secondary,
                ),
              Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          onSort: (_, __) => sortDocumentPreviews(documentPreviews, sortType: sortType),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                  ),
                  child: DataTable(
                    sortAscending: _sortDirection == SortDirection.ascending,
                    columnSpacing: AppSizes.kSmallGap,
                    headingRowHeight: AppSizes.kComponentHeight,
                    dataRowMinHeight: AppSizes.kComponentHeight,
                    dividerThickness: 1,
                    columns: [
                      buildSortColumn(
                        label: 'Titel',
                        sortType: DocumentSortType.title,
                        documentPreviews: documentPreviews,
                      ),
                      buildSortColumn(
                        label: 'Zuletzt bearbeitet',
                        sortType: DocumentSortType.modifiedAt,
                        documentPreviews: documentPreviews,
                      ),
                      buildSortColumn(
                        label: 'Dokumentdatum',
                        sortType: DocumentSortType.documentDate,
                        documentPreviews: documentPreviews,
                      ),
                    ],
                    showCheckboxColumn: _isSelectionMode,
                    rows: documentPreviews.map((documentPreview) => _buildDataRow(documentPreview)).toList(),
                  ),
                ),
              );
            },
          ),
          if (!useDesktopLayout) SizedBox(height: 64),
        ],
      );
    }

    Widget buildGridView(List<DocumentPreviewDto> documentPreviews) {
      Widget _buildPreviewCard(DocumentPreviewDto documentPreview) => MouseRegion(
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
                        await pushNoAnimation(context, widget: FloorOverviewScreen(documentId: documentPreview.uuid));
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
                          Ink(
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.all(
                                Radius.circular(AppSizes.kBorderRadius),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.article,
                            size: 48,
                            color: colorScheme.secondary,
                          ),
                          Positioned(
                            bottom: AppSizes.kSmallGap / 2,
                            right: AppSizes.kSmallGap / 2,
                            child: RowGap(
                              gap: AppSizes.kSmallGap / 2,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: colorScheme.outline,
                                  size: AppSizes.kSubIconSize,
                                ),
                                buildTimeago(documentPreview, color: colorScheme.outline),
                              ],
                            ),
                          ),
                          Positioned(
                            top: AppSizes.kSmallGap / 2,
                            left: AppSizes.kSmallGap / 2,
                            child: AnimatedOpacity(
                              opacity: _isSelectionMode || _hoverDocumentPreview == documentPreview ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 200),
                              child: buildCheckbox(documentPreview),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: textTheme.titleMedium!.fontSize! * textTheme.titleMedium!.height!,
                          child: RowGap(
                            gap: AppSizes.kSmallGap,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Flexible(
                                child: Text(
                                  documentPreview.title.trim().isNotEmpty ? documentPreview.title : 'Unbenanntes Dokument',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.titleMedium,
                                ),
                              ),
                              if (documentPreview.isExample) buildExampleContainer(documentPreview)
                            ],
                          ),
                        ),
                        Text(
                          documentPreview.documentDate != null ? dateFormatWeekdayDate.format(documentPreview.documentDate!) : 'Kein Datum',
                          style: textTheme.titleMedium?.copyWith(color: colorScheme.outline),
                        ),
                      ],
                    )
                  ],
                ),
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

      return LayoutBuilder(
        builder: (context, constraints) {
          double availableWidth = constraints.maxWidth;
          int itemsPerRow = (availableWidth / 250).floor();
          itemsPerRow = itemsPerRow < 1 ? 1 : itemsPerRow;

          return FloorWrapView(
            itemsPerRow: itemsPerRow,
            aspectRatio: 29.7 / 21,
            children: documentPreviews.map(_buildPreviewCard).toList(),
            endGap: useDesktopLayout ? null : SizedBox(height: 64),
          );
        },
      );
    }

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
                      // FloatingActionButton.extended(
                      //   heroTag: UniqueKey(),
                      //   backgroundColor: colorScheme.surfaceContainer,
                      //   foregroundColor: colorScheme.onSurface,
                      //   onPressed: _seeInfo,
                      //   icon: Icon(Icons.info),
                      //   label: Text('Info'),
                      // ),
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
          // FloorTransparentButton(
          //   text: 'Mehr erfahren',
          //   iconData: Icons.info,
          //   onPressed: _seeInfo,
          // ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_toggleSwitchKey.currentState?.selectedOption == DocumentViewType.grid)
                        FloorDropdownSort<DocumentSortType>(
                          options: DocumentSortType.values,
                          labels: {for (final sortType in DocumentSortType.values) sortType: sortType.name},
                          value: _sortType,
                          sortDirection: _sortDirection,
                          onOptionChanged: (value) {
                            sortDocumentPreviews(_documentPreviews!, sortType: value);
                          },
                        )
                      else if (_toggleSwitchKey.currentState != null && !_isSelectionMode && useDesktopLayout)
                        FloorOutlinedButton(
                          text: 'Auswählen',
                          onPressed: () {
                            _isSelectionMode = true;
                            setState(() {});
                          },
                        )
                      else
                        SizedBox(),
                      FloorToggleSwitch<DocumentViewType>(
                        key: _toggleSwitchKey,
                        icons: [Icons.list, Icons.grid_view],
                        options: DocumentViewType.values,
                        initialOption: DocumentViewType.grid,
                        labels: DocumentViewType.values.map((value) => value.label).toList(),
                        onOptionChanged: (value) {
                          setState(() {});
                        },
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
                        _documentPreviews = snapshot.data!;
                        if (_documentPreviews!.isEmpty) {
                          return Text('Keine Dokumente vorhanden');
                        } else {
                          return _toggleSwitchKey.currentState?.selectedOption == DocumentViewType.list
                              ? buildListView(_documentPreviews!)
                              : buildGridView(_documentPreviews!);
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
