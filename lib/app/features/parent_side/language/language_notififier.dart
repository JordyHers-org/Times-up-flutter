import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class LanguageNotifier extends ChangeNotifier {
  late String _selectedLanguage = '🇺🇸 English󠁢';
  late Locale _locale = const Locale('en');

  String get selectedLanguage => _selectedLanguage;
  Locale get locale => _locale;

  List<String> languages = [
    '🇫🇷 Français󠁢',
    '🇪🇸 Español',
    '🇹🇷 Turkish',
    '🇩🇪 Deutsch',
  ];

  void selectLanguage(String language) {
    languages.insert(languages.indexOf(language), _selectedLanguage);
    _selectedLanguage = language;
    languages.removeWhere((element) => element == _selectedLanguage);
    _locale = setLocale(_selectedLanguage);
    HapticFeedback.heavyImpact();
    notifyListeners();
  }

  Locale setLocale(String selectedLanguage) {
    switch (selectedLanguage) {
      case '🇫🇷 Français󠁢':
        return const Locale('fr');
      case '🇺🇸 English󠁢':
        return const Locale('en');
      case '🇪🇸 Español':
        return const Locale('es');
      case '🇹🇷 Turkish':
        return const Locale('tr');
      case '🇩🇪 Deutsch󠁢':
        return const Locale('de');
      default:
        return const Locale('en');
    }
  }
}
