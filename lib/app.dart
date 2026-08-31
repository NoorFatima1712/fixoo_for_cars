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
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        onToggleLanguage: _toggleLanguage,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.onToggleLanguage,
  });

  final String title;
  final VoidCallback onToggleLanguage;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var text = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [Text(text!.greeting)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onToggleLanguage,
        tooltip: 'switch Language',
        child: const Icon(Icons.switch_left),
      ),
    );
  }
}
