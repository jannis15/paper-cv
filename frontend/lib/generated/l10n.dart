// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Legal`
  String get legal {
    return Intl.message(
      'Legal',
      name: 'legal',
      desc: '',
      args: [],
    );
  }

  /// `Licenses`
  String get licenses {
    return Intl.message(
      'Licenses',
      name: 'licenses',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Document date`
  String get documentDate {
    return Intl.message(
      'Document date',
      name: 'documentDate',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Modified at`
  String get modifiedAt {
    return Intl.message(
      'Modified at',
      name: 'modifiedAt',
      desc: '',
      args: [],
    );
  }

  /// `List`
  String get list {
    return Intl.message(
      'List',
      name: 'list',
      desc: '',
      args: [],
    );
  }

  /// `Tile`
  String get tile {
    return Intl.message(
      'Tile',
      name: 'tile',
      desc: '',
      args: [],
    );
  }

  /// `Example`
  String get example {
    return Intl.message(
      'Example',
      name: 'example',
      desc: '',
      args: [],
    );
  }

  /// `Document`
  String get document {
    return Intl.message(
      'Document',
      name: 'document',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `No documents existing`
  String get noDocumentsExisting {
    return Intl.message(
      'No documents existing',
      name: 'noDocumentsExisting',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Unknown AlertOption`
  String get unknownAlertOption {
    return Intl.message(
      'Unknown AlertOption',
      name: 'unknownAlertOption',
      desc: '',
      args: [],
    );
  }

  /// `document selected`
  String get documentSelected {
    return Intl.message(
      'document selected',
      name: 'documentSelected',
      desc: '',
      args: [],
    );
  }

  /// `documents selected`
  String get documentsSelected {
    return Intl.message(
      'documents selected',
      name: 'documentsSelected',
      desc: '',
      args: [],
    );
  }

  /// `Hey there!`
  String get heyThere {
    return Intl.message(
      'Hey there!',
      name: 'heyThere',
      desc: '',
      args: [],
    );
  }

  /// `Do you like what you're seeing?`
  String get doYouLikeWhatYouAreSeeing {
    return Intl.message(
      'Do you like what you\'re seeing?',
      name: 'doYouLikeWhatYouAreSeeing',
      desc: '',
      args: [],
    );
  }

  /// `Contact me!`
  String get contactMe {
    return Intl.message(
      'Contact me!',
      name: 'contactMe',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `The document will be permanently deleted!`
  String get documentDeletionWarning {
    return Intl.message(
      'The document will be permanently deleted!',
      name: 'documentDeletionWarning',
      desc: '',
      args: [],
    );
  }

  /// `The selected documents will be permanently deleted!`
  String get multipleDocumentDeletionWarning {
    return Intl.message(
      'The selected documents will be permanently deleted!',
      name: 'multipleDocumentDeletionWarning',
      desc: '',
      args: [],
    );
  }

  /// `Untitled document`
  String get untitledDocument {
    return Intl.message(
      'Untitled document',
      name: 'untitledDocument',
      desc: '',
      args: [],
    );
  }

  /// `No date`
  String get noDate {
    return Intl.message(
      'No date',
      name: 'noDate',
      desc: '',
      args: [],
    );
  }

  /// `Leave the app?`
  String get leaveApp {
    return Intl.message(
      'Leave the app?',
      name: 'leaveApp',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get leave {
    return Intl.message(
      'Leave',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `Delete {count} document?`
  String deleteDocumentsQuestion(Object count) {
    return Intl.message(
      'Delete $count document?',
      name: 'deleteDocumentsQuestion',
      desc: '',
      args: [count],
    );
  }

  /// `Delete {count} documents?`
  String deleteDocumentsPluralQuestion(Object count) {
    return Intl.message(
      'Delete $count documents?',
      name: 'deleteDocumentsPluralQuestion',
      desc: '',
      args: [count],
    );
  }

  /// `Delete {document}?`
  String deleteDocument(Object document) {
    return Intl.message(
      'Delete $document?',
      name: 'deleteDocument',
      desc: '',
      args: [document],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message(
      'Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Calculate`
  String get calculate {
    return Intl.message(
      'Calculate',
      name: 'calculate',
      desc: '',
      args: [],
    );
  }

  /// `Recalculate`
  String get recalculate {
    return Intl.message(
      'Recalculate',
      name: 'recalculate',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get scan {
    return Intl.message(
      'Scan',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `Header`
  String get header {
    return Intl.message(
      'Header',
      name: 'header',
      desc: '',
      args: [],
    );
  }

  /// `Table`
  String get table {
    return Intl.message(
      'Table',
      name: 'table',
      desc: '',
      args: [],
    );
  }

  /// `Capture`
  String get capture {
    return Intl.message(
      'Capture',
      name: 'capture',
      desc: '',
      args: [],
    );
  }

  /// `Remark`
  String get remark {
    return Intl.message(
      'Remark',
      name: 'remark',
      desc: '',
      args: [],
    );
  }

  /// `Selection required`
  String get selection_required {
    return Intl.message(
      'Selection required',
      name: 'selection_required',
      desc: '',
      args: [],
    );
  }

  /// `Ready`
  String get ready {
    return Intl.message(
      'Ready',
      name: 'ready',
      desc: '',
      args: [],
    );
  }

  /// `Generate`
  String get generate {
    return Intl.message(
      'Generate',
      name: 'generate',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Upload was canceled`
  String get uploadCanceled {
    return Intl.message(
      'Upload was canceled',
      name: 'uploadCanceled',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `No date selected`
  String get noDateSelected {
    return Intl.message(
      'No date selected',
      name: 'noDateSelected',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Change date`
  String get changeDate {
    return Intl.message(
      'Change date',
      name: 'changeDate',
      desc: '',
      args: [],
    );
  }

  /// `No connection to the server`
  String get noConnectionToServer {
    return Intl.message(
      'No connection to the server',
      name: 'noConnectionToServer',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknownError {
    return Intl.message(
      'Unknown error',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Remove '{filename}'?`
  String removeFile(Object filename) {
    return Intl.message(
      'Remove \'$filename\'?',
      name: 'removeFile',
      desc: '',
      args: [filename],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Drop here`
  String get dropHere {
    return Intl.message(
      'Drop here',
      name: 'dropHere',
      desc: '',
      args: [],
    );
  }

  /// `Access Denied`
  String get accessDeniedTitle {
    return Intl.message(
      'Access Denied',
      name: 'accessDeniedTitle',
      desc: '',
      args: [],
    );
  }

  /// `The app needs permission to access photos from your gallery.`
  String get accessDeniedContent {
    return Intl.message(
      'The app needs permission to access photos from your gallery.',
      name: 'accessDeniedContent',
      desc: '',
      args: [],
    );
  }

  /// `Open Settings`
  String get openSettings {
    return Intl.message(
      'Open Settings',
      name: 'openSettings',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
