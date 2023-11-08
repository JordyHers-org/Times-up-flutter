import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:times_up_flutter/services/shared_preferences.dart';

class LanguageNotifier extends ChangeNotifier {
  late String _selectedLanguage = '🇺🇸 English󠁢';
  late Locale _locale = const Locale('en');

  String get selectedLanguage => _selectedLanguage;
  Locale get locale => _locale;

  List<String> languages = [
    '🇺🇸 English󠁢',
    '🇫🇷 Français󠁢',
    '🇪🇸 Español',
    '🇹🇷 Turkish',
    '🇩🇪 Deutsch',
  ];

  Future<void> initLocalization() async {
    _locale = await CacheService.getLocale();
    switch (_locale.languageCode) {
      case 'en':
        _selectedLanguage = '🇺🇸 English󠁢';
        break;
      case 'fr':
        _selectedLanguage = '🇫🇷 Français󠁢';
        break;
      case 'es':
        _selectedLanguage = '🇪🇸 Español';
        break;
      case 'de':
        _selectedLanguage = '🇩🇪 Deutsch';
        break;
      case 'tr':
        _selectedLanguage = '🇹🇷 Turkish󠁢';
        break;
    }

    languages
      ..insert(languages.indexOf(_selectedLanguage), _selectedLanguage)
      ..removeWhere((element) => element == _selectedLanguage);
    notifyListeners();
  }

  void selectLanguage(String language) {
    languages.insert(languages.indexOf(language), _selectedLanguage);
    _selectedLanguage = language;
    languages.removeWhere((element) => element == _selectedLanguage);
    _locale = setLocale(_selectedLanguage);
    CacheService.setLocale(value: _locale);
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
