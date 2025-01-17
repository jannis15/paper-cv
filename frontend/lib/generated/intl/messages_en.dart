// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(document) => "Delete ${document}?";

  static String m1(count) => "Delete ${count} documents?";

  static String m2(count) => "Delete ${count} document?";

  static String m3(filename) => "Remove \'${filename}\'?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accessDeniedContent": MessageLookupByLibrary.simpleMessage(
            "The app needs permission to access photos from your gallery."),
        "accessDeniedTitle":
            MessageLookupByLibrary.simpleMessage("Access Denied"),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "capture": MessageLookupByLibrary.simpleMessage("Capture"),
        "changeDate": MessageLookupByLibrary.simpleMessage("Change date"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "contactMe": MessageLookupByLibrary.simpleMessage("Contact me!"),
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteDocument": m0,
        "deleteDocumentsPluralQuestion": m1,
        "deleteDocumentsQuestion": m2,
        "doYouLikeWhatYouAreSeeing": MessageLookupByLibrary.simpleMessage(
            "Do you like what you\'re seeing?"),
        "document": MessageLookupByLibrary.simpleMessage("Document"),
        "documentDate": MessageLookupByLibrary.simpleMessage("Document date"),
        "documentDeletionWarning": MessageLookupByLibrary.simpleMessage(
            "The document will be permanently deleted!"),
        "documentSelected":
            MessageLookupByLibrary.simpleMessage("document selected"),
        "documentsSelected":
            MessageLookupByLibrary.simpleMessage("documents selected"),
        "dropHere": MessageLookupByLibrary.simpleMessage("Drop here"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "example": MessageLookupByLibrary.simpleMessage("Example"),
        "generate": MessageLookupByLibrary.simpleMessage("Generate"),
        "header": MessageLookupByLibrary.simpleMessage("Header"),
        "heyThere": MessageLookupByLibrary.simpleMessage("Hey there!"),
        "image": MessageLookupByLibrary.simpleMessage("Image"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "leave": MessageLookupByLibrary.simpleMessage("Leave"),
        "leaveApp": MessageLookupByLibrary.simpleMessage("Leave the app?"),
        "legal": MessageLookupByLibrary.simpleMessage("Legal"),
        "licenses": MessageLookupByLibrary.simpleMessage("Licenses"),
        "list": MessageLookupByLibrary.simpleMessage("List"),
        "modifiedAt": MessageLookupByLibrary.simpleMessage("Modified at"),
        "month": MessageLookupByLibrary.simpleMessage("Month"),
        "multipleDocumentDeletionWarning": MessageLookupByLibrary.simpleMessage(
            "The selected documents will be permanently deleted!"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "noConnectionToServer":
            MessageLookupByLibrary.simpleMessage("No connection to the server"),
        "noDate": MessageLookupByLibrary.simpleMessage("No date"),
        "noDateSelected":
            MessageLookupByLibrary.simpleMessage("No date selected"),
        "noDocumentsExisting":
            MessageLookupByLibrary.simpleMessage("No documents existing"),
        "openSettings": MessageLookupByLibrary.simpleMessage("Open Settings"),
        "ready": MessageLookupByLibrary.simpleMessage("Ready"),
        "recalculate": MessageLookupByLibrary.simpleMessage("Recalculate"),
        "remark": MessageLookupByLibrary.simpleMessage("Remark"),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "removeFile": m3,
        "report": MessageLookupByLibrary.simpleMessage("Report"),
        "scan": MessageLookupByLibrary.simpleMessage("Scan"),
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "selection_required":
            MessageLookupByLibrary.simpleMessage("Selection required"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "table": MessageLookupByLibrary.simpleMessage("Table"),
        "tile": MessageLookupByLibrary.simpleMessage("Tile"),
        "title": MessageLookupByLibrary.simpleMessage("Title"),
        "unknownAlertOption":
            MessageLookupByLibrary.simpleMessage("Unknown AlertOption"),
        "unknownError": MessageLookupByLibrary.simpleMessage("Unknown error"),
        "untitledDocument":
            MessageLookupByLibrary.simpleMessage("Untitled document"),
        "uploadCanceled":
            MessageLookupByLibrary.simpleMessage("Upload was canceled"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes")
      };
}
