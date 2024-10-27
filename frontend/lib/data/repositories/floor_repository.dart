import 'package:collection/collection.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/data/sources/local/database.dart';
import 'package:paper_cv/data/sources/remote/floor_cv_api.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:pdf/widgets.dart' as pw;

abstract class FloorRepository {
  static Stream<List<DocumentPreviewDto>> watchDocumentPreviews() => FloorDatabase.instance.watchDocumentPreviews();

  static Future<void> deleteDocumentById(String documentId) => FloorDatabase.instance.deleteDocumentById(documentId);

  static Future<DocumentForm> getDocumentFormById(String documentId) => FloorDatabase.instance.getDocumentFormById(documentId);

  static Future<void> saveDocumentForm(DocumentForm form) => FloorDatabase.instance.saveDocumentForm(form);

  static Future<ScanPropertiesDto> scanCapture(FileDto capture) => PaperCvApi.instance.scanCapture(capture);

  static pw.Document createPdf(ScanPropertiesDto dto) {
    final pdf = pw.Document();
    final List<pw.FractionColumnWidth> widths = dto.columnWidths.map((width) => pw.FractionColumnWidth(width)).toList();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table(
            columnWidths: {
              for (int i = 0; i < widths.length; i++) i: widths[i],
            },
            border: pw.TableBorder.all(),
            children: List<pw.TableRow>.generate(
              dto.rows,
              (y) => pw.TableRow(
                children: dto.columnWidths
                    .mapIndexed(
                      (x, columnWidth) => pw.Container(
                        height: dto.avgRowHeight,
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          dto.cellTexts[y][x],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );

    return pdf;
  }
}
