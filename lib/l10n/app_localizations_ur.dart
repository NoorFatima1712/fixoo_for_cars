// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'Fixoo';

  @override
  String get greeting => 'ہیلو';

  @override
  String get testMessage => 'لوکلائزیشن کام کر رہی ہے';

  @override
  String get locationFailed => 'آپ کی لوکیشن حاصل نہیں ہو سکی';

  @override
  String get emergencyRescue => 'ریسکیو 1122';

  @override
  String get emergencyMotorway => 'موٹروے پولیس 130';

  @override
  String get showMoreShops => 'مزید دکانیں دکھائیں';

  @override
  String distanceKm(String distance) {
    return '$distance کلومیٹر';
  }
}
