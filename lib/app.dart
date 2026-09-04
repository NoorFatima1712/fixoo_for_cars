import 'package:fixoo_for_cars/features/booking/presentation/browse_shops_screen.dart';
import 'package:fixoo_for_cars/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void _toggleLanguage() {
    setState(() {
      _locale = _locale?.languageCode == 'ur'
          ? const Locale('en')
          : const Locale('ur');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: ShopListScreen(onToggleLanguage: _toggleLanguage),
    );
  }
}
