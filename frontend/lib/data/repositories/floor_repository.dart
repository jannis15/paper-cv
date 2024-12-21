import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/data/sources/local/database.dart';
import 'package:paper_cv/data/sources/remote/floor_cv_api.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:paper_cv/utils/file_picker_models.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

abstract class FloorRepository {
  static Stream<List<DocumentPreviewDto>> watchDocumentPreviews({
    required DocumentSortType sortType,
    required SortDirection sortDirection,
  }) =>
      FloorDatabase.instance.watchDocumentPreviews(
        sortType: sortType,
        sortDirection: sortDirection,
      );

  static Future<void> deleteDocumentById(String documentId) => FloorDatabase.instance.deleteDocumentById(documentId);

  static Future<DocumentForm> getDocumentFormById(String documentId) => FloorDatabase.instance.getDocumentFormById(documentId);

  static Future<void> saveDocumentForm(DocumentForm form) => FloorDatabase.instance.saveDocumentForm(form);

  static Future<ScanPropertiesDto> scanCapture(SelectedFile capture, SelectionDto selection, {CancelToken? cancelToken}) =>
      FloorCvApi.instance.scanCapture(capture, selection, cancelToken: cancelToken);

  static Future<Uint8List> createPdf(List<ScanPropertiesDto> dtoList) async {
    final pdf = pw.Document();
    for (final dto in dtoList) {
      const a4HeightCm = 29.7;
      const a4HWidthCm = 21;
      const documentMarginCm = 1.0;

      // constranin the table width
      final maxTableWidthCm = a4HWidthCm - (documentMarginCm * 2);
      final columnWidthsCm = List.of(dto.columnWidthsCm);
      final tableWidthCm = columnWidthsCm.reduce((a, b) => a + b);
      final constrainedTableWidthCm = min(maxTableWidthCm, tableWidthCm);
      if (tableWidthCm != constrainedTableWidthCm) {
        final double shrinkingWidthFactor = constrainedTableWidthCm / tableWidthCm;
        for (int i = 0; i < columnWidthsCm.length; i++) {
          columnWidthsCm[i] = columnWidthsCm[i] * shrinkingWidthFactor;
        }
      }
      final widths = columnWidthsCm.map((width) => pw.FixedColumnWidth(width * PdfPageFormat.cm)).toList();

      // constrain the table height
      final maxTableHeightCm = a4HeightCm - (documentMarginCm * 2);
      final tableHeightCm = dto.rows * (dto.avgRowHeightCm);
      final constrainedTableHeightCm = min(maxTableHeightCm, tableHeightCm);
      double shrinkingHeightFactor = 1.0;
      if (tableHeightCm != constrainedTableHeightCm) {
        shrinkingHeightFactor = constrainedTableHeightCm / tableHeightCm;
      }
      final double scaledAvgRowHeight = dto.avgRowHeightCm * shrinkingHeightFactor * PdfPageFormat.cm;

      final fontSize = 8.0;

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.zero,
          build: (context) => pw.Stack(
            children: [
              pw.Positioned(
                left: dto.tableX * PdfPageFormat.cm,
                top: dto.tableY * PdfPageFormat.cm,
                child: pw.Table(
                  tableWidth: pw.TableWidth.min,
                  columnWidths: {
                    for (int i = 0; i < widths.length; i++) i: widths[i],
                  },
                  border: pw.TableBorder.all(),
                  children: dto.cellTexts
                      .mapIndexed(
                        (y, row) => pw.TableRow(
                          children: row
                              .mapIndexed(
                                (x, text) => pw.Container(
                                  alignment: y == 0 ? pw.Alignment.bottomCenter : pw.Alignment.bottomRight,
                                  padding: pw.EdgeInsets.all(.5 * PdfPageFormat.mm),
                                  height: scaledAvgRowHeight,
                                  child: pw.Text(text, style: pw.TextStyle(fontSize: fontSize)),
                                ),
                              )
                              .toList(),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return pdf.save();
  }
}
