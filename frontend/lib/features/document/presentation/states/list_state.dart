import '../../../../generated/l10n.dart';

enum DocumentViewType {
  list,
  grid;

  String get label => switch (this) {
        DocumentViewType.list => S.current.list,
        DocumentViewType.grid => S.current.tile,
      };
}
