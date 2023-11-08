import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:times_up_flutter/services/shared_preferences.dart';

class LanguageNotifier extends ChangeNotifier {
  static const String english = '🇺🇸 English󠁢';
  static const String french = '🇫🇷 Français󠁢󠁢';
  static const String german = '🇩🇪 Deutsch';
  static const String turkish = '🇹🇷 Turkish';
  static const String spanish = '🇪🇸 Español󠁢';

  late String _selectedLanguage = english;
  late Locale _locale = const Locale('en');

  String get selectedLanguage => _selectedLanguage;
  Locale get locale => _locale;

  List<String> languages = [
    english,
    french,
    spanish,
    turkish,
    german,
  ];

  Future<void> initLocalization() async {
    _locale = await CacheService.getLocale();
    _setLanguageString();
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

  void _setLanguageString() {
    switch (_locale.languageCode) {
      case 'en':
        _selectedLanguage = english;
        break;
      case 'fr':
        _selectedLanguage = french;
        break;
      case 'es':
        _selectedLanguage = spanish;
        break;
      case 'de':
        _selectedLanguage = german;
        break;
      case 'tr':
        _selectedLanguage = turkish;
        break;
    }
  }

  Locale setLocale(String selectedLanguage) {
    switch (selectedLanguage) {
      case french:
        return const Locale('fr');
      case english:
        return const Locale('en');
      case spanish:
        return const Locale('es');
      case turkish:
        return const Locale('tr');
      case german:
        return const Locale('de');
      default:
        return _locale;
    }
  }
}
