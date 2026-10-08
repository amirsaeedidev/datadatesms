import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
  ];

  /// نام نمایشی اپ — در AppBar، عنوان پنجره و Splash
  ///
  /// In fa, this message translates to:
  /// **'داده‌تد'**
  String get appTitle;

  /// دکمه تأیید دیالوگ‌ها
  ///
  /// In fa, this message translates to:
  /// **'باشه'**
  String get ok;

  /// پاسخ مثبت دیالوگ تأیید
  ///
  /// In fa, this message translates to:
  /// **'بله'**
  String get yes;

  /// پاسخ منفی دیالوگ تأیید
  ///
  /// In fa, this message translates to:
  /// **'خیر'**
  String get no;

  /// لغو عملیات جاری
  ///
  /// In fa, this message translates to:
  /// **'انصراف'**
  String get cancel;

  /// تأیید عملیات جاری
  ///
  /// In fa, this message translates to:
  /// **'تأیید'**
  String get confirm;

  /// دکمه Retry در ErrorView و حالات خطای Providerها
  ///
  /// In fa, this message translates to:
  /// **'تلاش دوباره'**
  String get retry;

  /// Pull-to-refresh و دکمه Refresh صفحات
  ///
  /// In fa, this message translates to:
  /// **'بازخوانی'**
  String get refresh;

  /// بستن صفحه یا دیالوگ
  ///
  /// In fa, this message translates to:
  /// **'بستن'**
  String get close;

  /// بازگشت به صفحه قبل
  ///
  /// In fa, this message translates to:
  /// **'بازگشت'**
  String get back;

  /// ذخیره فرم (Parser Rule و تنظیمات)
  ///
  /// In fa, this message translates to:
  /// **'ذخیره'**
  String get save;

  /// حذف رکورد — همیشه با دیالوگ تأیید
  ///
  /// In fa, this message translates to:
  /// **'حذف'**
  String get delete;

  /// ویرایش رکورد
  ///
  /// In fa, this message translates to:
  /// **'ویرایش'**
  String get edit;

  /// پیام LoadingView و حالت Loading همه Providerها
  ///
  /// In fa, this message translates to:
  /// **'در حال بارگذاری…'**
  String get loading;

  /// پیام حین عملیات فعال (Sync، Parsing و …)
  ///
  /// In fa, this message translates to:
  /// **'در حال پردازش…'**
  String get processing;

  /// برچسب وضعیت موفق
  ///
  /// In fa, this message translates to:
  /// **'موفق'**
  String get success;

  /// عنوان عمومی خطا
  ///
  /// In fa, this message translates to:
  /// **'خطا'**
  String get error;

  /// عنوان ErrorView
  ///
  /// In fa, this message translates to:
  /// **'مشکلی پیش آمد'**
  String get errorTitle;

  /// پیام پیش‌فرض ErrorView وقتی Failure پیام مشخصی ندارد
  ///
  /// In fa, this message translates to:
  /// **'خطای غیرمنتظره‌ای رخ داد. لطفاً دوباره تلاش کنید.'**
  String get errorGeneric;

  /// پیام خطای شبکه در ErrorView
  ///
  /// In fa, this message translates to:
  /// **'ارتباط با سرور برقرار نشد. اتصال اینترنت را بررسی کنید.'**
  String get errorNetwork;

  /// نمایش کد خطای Typed Failure در ErrorView
  ///
  /// In fa, this message translates to:
  /// **'خطا با کد: {code}'**
  String errorWithCode(String code);

  /// عنوان EmptyView
  ///
  /// In fa, this message translates to:
  /// **'موردی برای نمایش نیست'**
  String get emptyTitle;

  /// زیرعنوان پیش‌فرض EmptyView
  ///
  /// In fa, this message translates to:
  /// **'هنوز داده‌ای ثبت نشده است.'**
  String get emptyGeneric;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
