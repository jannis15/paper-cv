import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paper_cv/core/components/floor_app_bar.dart';
import 'package:paper_cv/core/components/floor_buttons.dart';
import 'package:paper_cv/core/components/floor_card.dart';
import 'package:paper_cv/core/components/floor_dropdown_sort.dart';
import 'package:paper_cv/core/components/floor_icon_button.dart';
import 'package:paper_cv/core/components/floor_layout_body.dart';
import 'package:paper_cv/core/components/floor_onboarding.dart';
import 'package:paper_cv/core/components/floor_wrap_view.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/config/settings_notifier.dart';
import 'package:paper_cv/features/document/domain/models/floor_models.dart';
import 'package:paper_cv/features/document/data/repositories/floor_repository_impl.dart';
import 'package:paper_cv/core/components/floor_contact_banner.dart';
import 'package:paper_cv/generated/l10n.dart';
import 'package:paper_cv/package_info.dart';
import 'package:paper_cv/features/document/presentation/screens/floor_overview_screen.dart';
import 'package:paper_cv/features/document/presentation/screens/floor_settings_screen.dart';
import 'package:paper_cv/core/utils/alert_dialog.dart';
import 'package:paper_cv/core/utils/date_format_utils.dart';
import 'package:paper_cv/core/utils/list_utils.dart';
import 'package:paper_cv/core/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../../../../core/components/floor_toggle_switch.dart';
import '../../../../core/utils/sort_enums.dart';
import '../../../../core/utils/navigator_utils.dart';

enum _DocumentViewType {
  list,
  grid;

  String get label => switch (this) {
        _DocumentViewType.list => S.current.list,
        _DocumentViewType.grid => S.current.tile,
      };
}

class FloorListScreen extends ConsumerStatefulWidget {
  const FloorListScreen({super.key});

  @override
  ConsumerState<FloorListScreen> createState() => _FloorListScreenState();
}

class _FloorListScreenState extends ConsumerState<FloorListScreen> {
  DocumentPreviewDto? _hoverDocumentPreview;
  List<DocumentPreviewDto>? _documentPreviews;
  bool _isFirstBuild = true;
  late bool _isDesktop;
  GlobalKey? _createKey = GlobalKey();
  final GlobalKey<FloorToggleSwitchState<_DocumentViewType>> _toggleSwitchKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  late Stream<List<DocumentPreviewDto>> _previewStream;
  late bool _showBanner;
  bool _isSelectionMode = false;
  final Set<DocumentPreviewDto> _selectedDocuments = {};
  DocumentSortType _sortType = DocumentSortType.documentDate;
  SortDirection _sortDirection = SortDirection.descending;

  String get _selectedText =>
      '${_selectedDocuments.length} ${_selectedDocuments.length == 1 ? S.current.documentSelected : S.current.documentsSelected}';

  @override
  void initState() {
    super.initState();
    _assignPreviewStream();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (mounted) setState(() {}); // important for re-checking _toggleSwitchKey.currentContext
      },
    );
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
      title: _selectedDocuments.length == 1
          ? S.current.deleteDocumentsQuestion(_selectedDocuments.length)
          : S.current.deleteDocumentsPluralQuestion(_selectedDocuments.length),
      content: _selectedDocuments.length == 1 ? S.current.documentDeletionWarning : S.current.multipleDocumentDeletionWarning,
      optionData: [
        AlertOptionData.cancel(),
        AlertOptionData.yes(customText: S.current.delete),
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

  void _openOverviewScreen() async => pushNoAnimation(context, widget: FloorOverviewScreen());

  @override
  Widget build(BuildContext context) {
    if (_isFirstBuild) {
      _isDesktop = useDesktopLayout;
      _isFirstBuild = false;
    } else {
      if (_isDesktop != useDesktopLayout) {
        _isDesktop = !_isDesktop;
        _createKey = null;
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            if (mounted)
              setState(() {
                _createKey = GlobalKey();
              });
          },
        );
      }
    }
    final settings = ref.watch(settingsNotifierProvider);
    final settingsNotifier = ref.watch(settingsNotifierProvider.notifier);
    _showBanner = settings.showAdBanner;

    Widget buildExampleContainer(DocumentPreviewDto documentPreview, {required TextStyle? textStyle}) => Container(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.kSmallGap),
          decoration: ShapeDecoration(
            shape: StadiumBorder(side: BorderSide(color: colorScheme.outline)),
          ),
          child: Text(
            S.current.example,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: textStyle?.copyWith(color: colorScheme.outline),
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
          locale: settings.locale,
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
          onLongPress: _isDesktop
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
                  Text(documentPreview.title.isNotEmpty ? documentPreview.title : S.current.untitledDocument),
                  if (documentPreview.isExample) buildExampleContainer(documentPreview, textStyle: textTheme.titleSmall),
                ],
              ),
            )),
            DataCell(_buildTableCell(buildTimeago(documentPreview))),
            DataCell(
              _buildTableCell(
                Text(documentPreview.documentDate != null
                    ? dateFormatWeekdayDate(settings.locale).format(documentPreview.documentDate!)
                    : S.current.noDate),
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
                        label: S.current.title,
                        sortType: DocumentSortType.title,
                        documentPreviews: documentPreviews,
                      ),
                      buildSortColumn(
                        label: S.current.modifiedAt,
                        sortType: DocumentSortType.modifiedAt,
                        documentPreviews: documentPreviews,
                      ),
                      buildSortColumn(
                        label: S.current.documentDate,
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
          if (!_isDesktop) SizedBox(height: 64),
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
                onLongPress: _isDesktop
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
                                  documentPreview.title.trim().isNotEmpty ? documentPreview.title : S.current.untitledDocument,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.titleMedium,
                                ),
                              ),
                              if (documentPreview.isExample) buildExampleContainer(documentPreview, textStyle: textTheme.titleMedium)
                            ],
                          ),
                        ),
                        Text(
                          documentPreview.documentDate != null
                              ? dateFormatWeekdayDate(settings.locale).format(documentPreview.documentDate!)
                              : S.current.noDate,
                          style: textTheme.titleMedium?.copyWith(color: colorScheme.outline),
                        ),
                      ],
                    )
                  ],
                ),
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
            endGap: _isDesktop ? null : SizedBox(height: 64),
          );
        },
      );
    }

    return FloorOnboarding(
      child: PopScope(
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
              title: S.current.leaveApp,
              optionData: [
                AlertOptionData.cancel(),
                AlertOptionData.yes(customText: S.current.leave),
              ],
            );
            if (alertResult == AlertOption.yes) {
              SystemNavigator.pop();
            }
          }
        },
        child: FloorLayoutBody(
          title: _isSelectionMode && !_isDesktop
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
              tooltip: S.current.settings,
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
          floatingActionButton: _isDesktop
              ? null
              : _isSelectionMode
                  ? RowGap(
                      mainAxisAlignment: MainAxisAlignment.end,
                      gap: AppSizes.kSmallGap,
                      children: [
                        FloatingActionButton.extended(
                          heroTag: UniqueKey(),
                          icon: Icon(Icons.delete),
                          label: Text(S.current.delete),
                          backgroundColor:
                              _selectedDocuments.isEmpty ? Color.alphaBlend(colorScheme.surface.withOpacity(.75), Colors.red) : Colors.red,
                          foregroundColor:
                              _selectedDocuments.isEmpty ? Color.alphaBlend(colorScheme.surface.withOpacity(.75), Colors.white) : Colors.white,
                          onPressed: _selectedDocuments.isEmpty ? null : _deleteSelectedDocuments,
                        ),
                        FloatingActionButton.extended(
                          heroTag: UniqueKey(),
                          icon: Icon(Icons.cancel),
                          label: Text(S.current.cancel),
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
                          key: _createKey,
                          heroTag: UniqueKey(),
                          onPressed: _openOverviewScreen,
                          icon: Icon(Icons.post_add),
                          label: Text(S.current.create),
                        )
                      ],
                    ),
          sideChildren: [
            FloorOutlinedButton(
              key: _createKey,
              text: S.current.create,
              iconData: Icons.post_add,
              onPressed: _openOverviewScreen,
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
                                onCloseBanner: () async {
                                  await settingsNotifier.setShowAdBanner(false);
                                  _showBanner = false;
                                  setState(() {});
                                },
                              ),
                            )
                          : SizedBox(),
                    ),
                    AnimatedSize(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                      child: _isSelectionMode && _isDesktop
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
                        if (_toggleSwitchKey.currentState?.selectedOption == _DocumentViewType.grid)
                          Flexible(
                            child: SizedBox(
                              width: 200,
                              child: FloorDropdownSort<DocumentSortType>(
                                options: DocumentSortType.values,
                                labels: {for (final sortType in DocumentSortType.values) sortType: sortType.name},
                                value: _sortType,
                                sortDirection: _sortDirection,
                                onOptionChanged: (value) {
                                  sortDocumentPreviews(_documentPreviews!, sortType: value);
                                },
                              ),
                            ),
                          )
                        else if (_toggleSwitchKey.currentState != null && !_isSelectionMode && _isDesktop)
                          FloorOutlinedButton(
                            text: S.current.select,
                            onPressed: () {
                              _isSelectionMode = true;
                              setState(() {});
                            },
                          )
                        else
                          SizedBox(),
                        FloorToggleSwitch<_DocumentViewType>(
                          key: _toggleSwitchKey,
                          icons: [Icons.list, Icons.grid_view],
                          options: _DocumentViewType.values,
                          initialOption: _DocumentViewType.grid,
                          labels: _DocumentViewType.values.map((value) => value.label).toList(),
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
                            return Text(S.current.noDocumentsExisting);
                          } else {
                            return _toggleSwitchKey.currentState?.selectedOption == _DocumentViewType.list
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
      ),
    );
  }
}
