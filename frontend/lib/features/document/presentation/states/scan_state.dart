import '../../domain/models/floor_models.dart';

class ScanState {
  String? uuid;
  String refUuid;
  List<double> columnWidthsCm;
  double avgRowHeightCm;
  int rows;
  double tableXCm;
  double tableYCm;
  double imgWidthPx;
  double imgHeightPx;
  List<List<String>> cellTexts;

  ScanState({
    this.uuid,
    required this.refUuid,
    required this.columnWidthsCm,
    required this.avgRowHeightCm,
    required this.rows,
    required this.tableXCm,
    required this.tableYCm,
    required this.imgWidthPx,
    required this.imgHeightPx,
    required this.cellTexts,
  });

  ScanResultDto toDto() => ScanResultDto(
        uuid: this.uuid,
        refUuid: this.refUuid,
        columnWidthsCm: this.columnWidthsCm,
        avgRowHeightCm: this.avgRowHeightCm,
        rows: this.rows,
        tableXCm: this.tableXCm,
        tableYCm: this.tableYCm,
        imgWidthPx: this.imgWidthPx,
        imgHeightPx: this.imgHeightPx,
        cellTexts: this.cellTexts,
      );
}
