// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static String m0(document) => "${document} löschen?";

  static String m1(count) => "${count} Dokumente löschen?";

  static String m2(count) => "${count} Dokument löschen?";

  static String m3(filename) => "\'${filename}\' entfernen?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accessDeniedContent": MessageLookupByLibrary.simpleMessage(
            "Die App benötigt die Berechtigung, um Fotos aus Ihrer Galerie nutzen zu können."),
        "accessDeniedTitle":
            MessageLookupByLibrary.simpleMessage("Zugriff verweigert"),
        "add": MessageLookupByLibrary.simpleMessage("Hinzufügen"),
        "back": MessageLookupByLibrary.simpleMessage("Zurück"),
        "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "capture": MessageLookupByLibrary.simpleMessage("Aufnahme"),
        "changeDate": MessageLookupByLibrary.simpleMessage("Datum ändern"),
        "close": MessageLookupByLibrary.simpleMessage("Schließen"),
        "confirm": MessageLookupByLibrary.simpleMessage("Bestätigen"),
        "contactMe":
            MessageLookupByLibrary.simpleMessage("Kontaktieren Sie mich!"),
        "create": MessageLookupByLibrary.simpleMessage("Erfassen"),
        "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "deleteDocument": m0,
        "deleteDocumentsPluralQuestion": m1,
        "deleteDocumentsQuestion": m2,
        "doYouLikeWhatYouAreSeeing": MessageLookupByLibrary.simpleMessage(
            "Gefällt Ihnen, was Sie sehen?"),
        "document": MessageLookupByLibrary.simpleMessage("Dokument"),
        "documentDate": MessageLookupByLibrary.simpleMessage("Dokumentdatum"),
        "documentDeletionWarning": MessageLookupByLibrary.simpleMessage(
            "Das Dokument wird dadurch unwiderruflich gelöscht!"),
        "documentSelected":
            MessageLookupByLibrary.simpleMessage("Dokument ausgewählt"),
        "documentsSelected":
            MessageLookupByLibrary.simpleMessage("Dokumente ausgewählt"),
        "dropHere": MessageLookupByLibrary.simpleMessage("Hier ablegen"),
        "error": MessageLookupByLibrary.simpleMessage("Fehler"),
        "example": MessageLookupByLibrary.simpleMessage("Beispiel"),
        "generate": MessageLookupByLibrary.simpleMessage("Generieren"),
        "header": MessageLookupByLibrary.simpleMessage("Kopfzeile"),
        "heyThere": MessageLookupByLibrary.simpleMessage("Moin!"),
        "image": MessageLookupByLibrary.simpleMessage("Bild"),
        "language": MessageLookupByLibrary.simpleMessage("Sprache"),
        "leave": MessageLookupByLibrary.simpleMessage("Verlassen"),
        "leaveApp": MessageLookupByLibrary.simpleMessage("App verlassen?"),
        "legal": MessageLookupByLibrary.simpleMessage("Rechtliches"),
        "licenses": MessageLookupByLibrary.simpleMessage("Lizenzen"),
        "list": MessageLookupByLibrary.simpleMessage("Liste"),
        "modifiedAt":
            MessageLookupByLibrary.simpleMessage("Zuletzt bearbeitet"),
        "month": MessageLookupByLibrary.simpleMessage("Monat"),
        "multipleDocumentDeletionWarning": MessageLookupByLibrary.simpleMessage(
            "Die ausgewählten Dokumente werden dadurch unwiderruflich gelöscht!"),
        "no": MessageLookupByLibrary.simpleMessage("Nein"),
        "noConnectionToServer":
            MessageLookupByLibrary.simpleMessage("Keine Verbindung zum Server"),
        "noDate": MessageLookupByLibrary.simpleMessage("Kein Datum"),
        "noDateSelected":
            MessageLookupByLibrary.simpleMessage("Kein Datum ausgewählt"),
        "noDocumentsExisting":
            MessageLookupByLibrary.simpleMessage("Keine Dokumente vorhanden"),
        "openSettings":
            MessageLookupByLibrary.simpleMessage("Einstellungen öffnen"),
        "ready": MessageLookupByLibrary.simpleMessage("Bereit"),
        "recalculate": MessageLookupByLibrary.simpleMessage("Neu berechnen"),
        "remark": MessageLookupByLibrary.simpleMessage("Bemerkung"),
        "remove": MessageLookupByLibrary.simpleMessage("Entfernen"),
        "removeFile": m3,
        "report": MessageLookupByLibrary.simpleMessage("Bericht"),
        "scan": MessageLookupByLibrary.simpleMessage("Scan"),
        "select": MessageLookupByLibrary.simpleMessage("Auswählen"),
        "selection_required":
            MessageLookupByLibrary.simpleMessage("Selektion erforderlich"),
        "settings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "table": MessageLookupByLibrary.simpleMessage("Tabelle"),
        "tile": MessageLookupByLibrary.simpleMessage("Kachel"),
        "title": MessageLookupByLibrary.simpleMessage("Titel"),
        "unknownAlertOption":
            MessageLookupByLibrary.simpleMessage("AlertOption unbekannt"),
        "unknownError":
            MessageLookupByLibrary.simpleMessage("Unbekannter Fehler"),
        "untitledDocument":
            MessageLookupByLibrary.simpleMessage("Unbenanntes Dokument"),
        "uploadCanceled":
            MessageLookupByLibrary.simpleMessage("Hochladen wurde abgebrochen"),
        "yes": MessageLookupByLibrary.simpleMessage("Ja")
      };
}
