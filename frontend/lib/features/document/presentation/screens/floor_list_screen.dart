import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paper_cv/core/components/floor_app_bar.dart';
import 'package:paper_cv/core/components/floor_buttons.dart';
import 'package:paper_cv/core/components/floor_card.dart';
import 'package:paper_cv/core/components/floor_dropdown_sort.dart';
import 'package:paper_cv/core/components/floor_icon_button.dart';
import 'package:paper_cv/core/components/floor_layout_body.dart';
import 'package:paper_cv/core/components/floor_wrap_view.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/config/settings_notifier.dart';
import 'package:paper_cv/features/document/domain/models/floor_models.dart';
import 'package:paper_cv/core/components/floor_contact_banner.dart';
import 'package:paper_cv/features/document/presentation/providers/floor_list_provider.dart';
import 'package:paper_cv/features/document/presentation/states/floor_list_state.dart';
import 'package:paper_cv/generated/l10n.dart';
import 'package:paper_cv/core/utils/package_info.dart';
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

class FloorListScreen extends ConsumerStatefulWidget {
  const FloorListScreen({super.key});

  @override
  ConsumerState<FloorListScreen> createState() => _FloorListScreenState();
}

class _FloorListScreenState extends ConsumerState<FloorListScreen> {
  DocumentPreviewDto? _hoverDocumentPreview;
  final ScrollController _scrollController = ScrollController();

  void _deleteSelectedDocuments(BuildContext context, FloorListStateData state) async {
    final alertOption = await showAlertDialog(
      context,
      title: state.selectedDocuments.length == 1
          ? S.current.deleteDocumentsQuestion(state.selectedDocuments.length)
          : S.current.deleteDocumentsPluralQuestion(state.selectedDocuments.length),
      content: state.selectedDocuments.length == 1 ? S.current.documentDeletionWarning : S.current.multipleDocumentDeletionWarning,
      optionData: [
        AlertOptionData.cancel(),
        AlertOptionData.yes(customText: S.current.delete),
      ],
    );
    if (alertOption == AlertOption.yes) {
      context.read<FloorListProvider>().deleteSelectedDocuments();
    }
  }

  void _openOverviewScreen() async => pushNoAnimation(context, widget: FloorOverviewScreen());

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsNotifierProvider);
    final settingsNotifier = ref.watch(settingsNotifierProvider.notifier);

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

    Widget buildTimeago(DocumentPreviewDto documentPreview, {Color? color}) => Timeago(
          builder: (context, value) {
            return Text(value, style: textTheme.labelMedium?.copyWith(color: color));
          },
          date: documentPreview.modifiedAt,
          allowFromNow: true,
          locale: settings.locale,
        );

    Widget buildCheckbox(
      BuildContext context,
      FloorListStateData state,
      DocumentPreviewDto documentPreview, {
      Color? activeColor,
      Color? checkColor,
    }) =>
        Checkbox(
          value: state.selectedDocuments.contains(documentPreview),
          activeColor: activeColor,
          checkColor: checkColor,
          onChanged: (_) => context.read<FloorListProvider>().selectDocument(documentPreview),
        );

    Widget buildListView(
      BuildContext context,
      FloorListStateData state,
      List<DocumentPreviewDto> documentPreviews,
    ) {
      Widget _buildTableCell(Widget widget) => widget is Text
          ? Text(
              widget.data ?? '',
              style: TextStyle(),
              textAlign: TextAlign.start,
            )
          : widget;

      DataRow _buildDataRow(DocumentPreviewDto documentPreview) {
        final bool isRowSelected = state.isSelectionMode && state.selectedDocuments.contains(documentPreview);
        return DataRow(
          onLongPress: useDesktopLayout
              ? null
              : () {
                  context.read<FloorListProvider>().selectDocument(documentPreview);
                },
          selected: isRowSelected,
          onSelectChanged: state.isSelectionMode
              ? (_) => context.read<FloorListProvider>().selectDocument(documentPreview)
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
              if (state.sortType == sortType)
                Icon(
                  state.sortDirection == SortDirection.ascending ? Icons.arrow_upward : Icons.arrow_downward,
                  size: AppSizes.kSubIconSize,
                  color: colorScheme.secondary,
                ),
              Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          onSort: (_, __) => context.read<FloorListProvider>().sortDocumentPreviews(sortType),
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
                    sortAscending: state.sortDirection == SortDirection.ascending,
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
                    showCheckboxColumn: state.isSelectionMode,
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

    Widget buildGridView(BuildContext context, FloorListStateData state, List<DocumentPreviewDto> documentPreviews) {
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
                  color: state.selectedDocuments.contains(documentPreview) ? colorScheme.primary : Colors.transparent,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.all(Radius.circular(AppSizes.kBorderRadius)),
              ),
              child: FloorCard(
                onLongPress: useDesktopLayout ? null : () => context.read<FloorListProvider>().toggleSelectionMode(documentPreview),
                onTap: state.isSelectionMode
                    ? () {
                        context.read<FloorListProvider>().selectDocument(documentPreview);
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
                              opacity: state.isSelectionMode || _hoverDocumentPreview == documentPreview ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 200),
                              child: buildCheckbox(context, state, documentPreview),
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
            endGap: useDesktopLayout ? null : SizedBox(height: 64),
          );
        },
      );
    }

    return BlocProvider<FloorListProvider>(
      create: (context) => FloorListProvider(),
      child: BlocBuilder<FloorListProvider, FloorListState>(
        builder: (context, state) => PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (!didPop) {
              if (state is FloorListStateData && state.isSelectionMode) {
                context.read<FloorListProvider>().disableSelectionMode();
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
            title: state is FloorListStateData && state.isSelectionMode && !useDesktopLayout
                ? Text(state.selectedText)
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
            floatingActionButton: useDesktopLayout
                ? null
                : state is FloorListStateData && state.isSelectionMode
                    ? RowGap(
                        mainAxisAlignment: MainAxisAlignment.end,
                        gap: AppSizes.kSmallGap,
                        children: [
                          FloatingActionButton.extended(
                            heroTag: UniqueKey(),
                            icon: Icon(Icons.delete),
                            label: Text(S.current.delete),
                            backgroundColor:
                                state.selectedDocuments.isEmpty ? Color.alphaBlend(colorScheme.surface.withOpacity(.75), Colors.red) : Colors.red,
                            foregroundColor:
                                state.selectedDocuments.isEmpty ? Color.alphaBlend(colorScheme.surface.withOpacity(.75), Colors.white) : Colors.white,
                            onPressed: state.selectedDocuments.isEmpty ? null : () => _deleteSelectedDocuments(context, state),
                          ),
                          FloatingActionButton.extended(
                            heroTag: UniqueKey(),
                            icon: Icon(Icons.cancel),
                            label: Text(S.current.cancel),
                            backgroundColor: colorScheme.surfaceContainer,
                            foregroundColor: colorScheme.onSurface,
                            onPressed: context.read<FloorListProvider>().disableSelectionMode,
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
                            onPressed: _openOverviewScreen,
                            icon: Icon(Icons.post_add),
                            label: Text(S.current.create),
                          )
                        ],
                      ),
            sideChildren: [
              FloorOutlinedButton(
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
                        child: settings.showAdBanner
                            ? Padding(
                                padding: EdgeInsets.only(bottom: AppSizes.kGap),
                                child: FloorContactBanner(
                                  onCloseBanner: () => settingsNotifier.setShowAdBanner(false),
                                ),
                              )
                            : SizedBox(),
                      ),
                      AnimatedSize(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                        child: state is FloorListStateData && state.isSelectionMode && useDesktopLayout
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
                                          onPressed: context.read<FloorListProvider>().disableSelectionMode,
                                        ),
                                        Text(state.selectedText, style: textTheme.labelLarge),
                                        FloorIconButton(
                                          backgroundColor: Colors.transparent,
                                          iconData: Icons.delete,
                                          onPressed: state.selectedDocuments.isEmpty ? null : () => _deleteSelectedDocuments(context, state),
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
                          if (state is FloorListStateData)
                            if (state.documentViewType == DocumentViewType.grid)
                              Flexible(
                                child: SizedBox(
                                  width: 200,
                                  child: FloorDropdownSort<DocumentSortType>(
                                    options: DocumentSortType.values,
                                    labels: {for (final sortType in DocumentSortType.values) sortType: sortType.name},
                                    value: state.sortType,
                                    sortDirection: state.sortDirection,
                                    onOptionChanged: context.read<FloorListProvider>().sortDocumentPreviews,
                                  ),
                                ),
                              )
                            else if (!state.isSelectionMode && useDesktopLayout)
                              FloorOutlinedButton(
                                text: S.current.select,
                                onPressed: context.read<FloorListProvider>().setSelectionMode,
                              )
                            else
                              SizedBox(),
                          if (state is FloorListStateData)
                            FloorToggleSwitch<DocumentViewType>(
                              icons: [Icons.list, Icons.grid_view],
                              options: DocumentViewType.values,
                              initialOption: state.documentViewType,
                              labels: DocumentViewType.values.map((value) => value.label).toList(),
                              onOptionChanged: context.read<FloorListProvider>().setDocumentViewType,
                            ),
                        ],
                      ),
                      SizedBox(height: AppSizes.kGap),
                      state.when(
                        data: (documentPreviews, isSelectionMode, selectedDocuments, documentViewType, sortType, sortDirection) =>
                            documentPreviews.isEmpty
                                ? Text(S.current.noDocumentsExisting)
                                : documentViewType == DocumentViewType.grid
                                    ? buildGridView(context, state as FloorListStateData, documentPreviews)
                                    : buildListView(context, state as FloorListStateData, documentPreviews),
                        error: (error) => Text(error.toString(), style: TextStyle(color: colorScheme.error)),
                        loading: () => Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
