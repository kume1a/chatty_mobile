import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class AppLocales {
  static const Locale localeEn = Locale('en', 'US');

  static const Locale defaultLocale = localeEn;
  static const Locale fallbackLocale = localeEn;

  static const List<Locale> supportedLocales = <Locale>[
    localeEn,
  ];

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
}
