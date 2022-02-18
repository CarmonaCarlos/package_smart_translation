import 'package:flutter/material.dart';
import 'package:smart_translation/src/localization/localization.dart';


class SmartAppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final List<String>? supportedLanguages;

  SmartAppLocalizationsDelegate({this.supportedLanguages});

  @override
  bool isSupported(Locale locale) {
    return supportedLanguages!.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(SmartAppLocalizationsDelegate old) => false;
}
