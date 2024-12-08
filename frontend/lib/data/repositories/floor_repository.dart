import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/data/sources/local/database.dart';
import 'package:paper_cv/data/sources/remote/floor_cv_api.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:paper_cv/utils/file_picker_models.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

abstract class FloorRepository {
  static Stream<List<DocumentPreviewDto>> watchDocumentPreviews() => FloorDatabase.instance.watchDocumentPreviews();

  static Future<void> deleteDocumentById(String documentId) => FloorDatabase.instance.deleteDocumentById(documentId);

  static Future<DocumentForm> getDocumentFormById(String documentId) => FloorDatabase.instance.getDocumentFormById(documentId);

  static Future<void> saveDocumentForm(DocumentForm form) => FloorDatabase.instance.saveDocumentForm(form);

  static Future<ScanPropertiesDto> scanCapture(SelectedFile capture) => FloorCvApi.instance.scanCapture(capture);

  static Future<Uint8List> createPdf(ScanPropertiesDto dto) async {
    final pdf = pw.Document();
    final List<pw.FractionColumnWidth> widths = dto.columnWidths.map((width) => pw.FractionColumnWidth(width)).toList();
    const a4HeightCm = 29.7 * PdfPageFormat.cm;
    const documentMarginCm = 1.5 * PdfPageFormat.cm;
    final maxTableHeightCm = a4HeightCm - (documentMarginCm * 2);
    final tableHeightCm = dto.rows * dto.avgRowHeight; // implying that avgRowHeight is in cm
    final constrainedTableHeightCm = min(maxTableHeightCm, tableHeightCm);
    late final double shrinkingFactor;
    if (tableHeightCm != constrainedTableHeightCm) {
      shrinkingFactor = constrainedTableHeightCm / tableHeightCm;
    } else {
      shrinkingFactor = 1.0;
    }
    final scaledAvgRowHeight = dto.avgRowHeight * shrinkingFactor;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(documentMarginCm),
        build: (context) => pw.Table(
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
                          padding: pw.EdgeInsets.all(2 * PdfPageFormat.point),
                          height: scaledAvgRowHeight,
                          child: pw.Text(text),
                        ),
                      )
                      .toList(),
                ),
              )
              .toList(),
        ),
      ),
    );
    return pdf.save();
  }
}
