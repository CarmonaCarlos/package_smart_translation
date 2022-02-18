import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_common_shared/smart_common_shared.dart';
import 'dart:developer' as dev;
String devName = '[package]-smart_translation';

class AppLocalizations {
  final Locale locale;

  AppLocalizations({required this.locale});

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  late Map<String, dynamic> _localizedStrings;

  Future load() async {
    dev.log('load()', name: devName);
    String jsonString;
    try {
      jsonString = await rootBundle
          .loadString('assets/languages/${locale.languageCode}.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = jsonMap.map((String key, dynamic value) {
        return MapEntry(key, value);
      });
    } catch (e) {
      dev.log('Fail to load language file', name: devName, error: e);
    }
  }

  String translate(SmartApplications application, String key) {
    try {
      String appName = application.toString().toLowerCase().split('.')[1];
      if (_localizedStrings[appName][key] != null) {
        return _localizedStrings[appName][key];
      } else {
        return key;
      }
    } catch (e) {
      return key;
    }
  }
}

Locale getLocaleResolution(Locale? locale, Iterable<Locale> supportedLocales) {
  dev.log('_getLocalResolution', name: devName);
  if (locale != null) {
    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode) {
        dev.log('Local found: languageCode = ${supportedLocale.languageCode}, countryCode = ${supportedLocale.countryCode}', name: devName);
        return supportedLocale;
      }
    }
    dev.log('Local not found, return first', name: devName);
    return supportedLocales.first;
  } else {
    return const Locale('en', 'US');
  }
}


