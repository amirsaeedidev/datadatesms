// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'داده‌تد';

  @override
  String get ok => 'باشه';

  @override
  String get yes => 'بله';

  @override
  String get no => 'خیر';

  @override
  String get cancel => 'انصراف';

  @override
  String get confirm => 'تأیید';

  @override
  String get retry => 'تلاش دوباره';

  @override
  String get refresh => 'بازخوانی';

  @override
  String get close => 'بستن';

  @override
  String get back => 'بازگشت';

  @override
  String get save => 'ذخیره';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'ویرایش';

  @override
  String get loading => 'در حال بارگذاری…';

  @override
  String get processing => 'در حال پردازش…';

  @override
  String get success => 'موفق';

  @override
  String get error => 'خطا';

  @override
  String get errorTitle => 'مشکلی پیش آمد';

  @override
  String get errorGeneric =>
      'خطای غیرمنتظره‌ای رخ داد. لطفاً دوباره تلاش کنید.';

  @override
  String get errorNetwork =>
      'ارتباط با سرور برقرار نشد. اتصال اینترنت را بررسی کنید.';

  @override
  String errorWithCode(String code) {
    return 'خطا با کد: $code';
  }

  @override
  String get emptyTitle => 'موردی برای نمایش نیست';

  @override
  String get emptyGeneric => 'هنوز داده‌ای ثبت نشده است.';
}
