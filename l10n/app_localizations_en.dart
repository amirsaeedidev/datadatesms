// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DadehTad';

  @override
  String get ok => 'OK';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get retry => 'Try Again';

  @override
  String get refresh => 'Refresh';

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get loading => 'Loading…';

  @override
  String get processing => 'Processing…';

  @override
  String get success => 'Success';

  @override
  String get error => 'Error';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorGeneric => 'An unexpected error occurred. Please try again.';

  @override
  String get errorNetwork =>
      'Could not reach the server. Check your internet connection.';

  @override
  String errorWithCode(String code) {
    return 'Error code: $code';
  }

  @override
  String get emptyTitle => 'Nothing to show';

  @override
  String get emptyGeneric => 'No data has been recorded yet.';
}
