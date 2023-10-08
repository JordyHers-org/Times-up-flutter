import 'package:flutter/material.dart';

class CustomColors {
  static Color indigoPrimary = const Color(0xFF283593);
  static Color indigoDark = const Color(0xFF1a237e);
  static Color indigoDarker = const Color(0xff050738);
  static Color greenPrimary = const Color(0xFF00C853);
  static Color indigoLight = const Color(0xFF9fa8da);
}

class CustomDecoration {
  static BoxDecoration withShadowDecoration = BoxDecoration(
    color: CustomColors.indigoDark,
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    boxShadow: [
      BoxShadow(
        color: CustomColors.indigoPrimary.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ],
  );
}

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
    primarySwatch: buildMaterialColor(CustomColors.indigoDark),
    primaryColor: CustomColors.indigoDark,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: CustomColors.indigoDark),
    brightness: Brightness.light,
    cardTheme: const CardTheme(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.indigo),
    dividerColor: CustomColors.indigoDark,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: CustomColors.greenPrimary,
      foregroundColor: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: buildMaterialColor(CustomColors.indigoDark),
    primaryColor: CustomColors.indigoDark,
    scaffoldBackgroundColor: CustomColors.indigoDarker,
    appBarTheme: AppBarTheme(backgroundColor: CustomColors.indigoDark),
    brightness: Brightness.dark,
    cardTheme: CardTheme(color: CustomColors.indigoDark),
    iconTheme: IconThemeData(color: CustomColors.indigoLight),
    dividerColor: CustomColors.indigoLight,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: CustomColors.indigoLight,
      foregroundColor: CustomColors.indigoDark,
    ),
  );

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);
}

extension PaddingHelper on Widget {
  Padding get p16 => Padding(padding: const EdgeInsets.all(16), child: this);
  Padding get p20 => Padding(padding: const EdgeInsets.all(20), child: this);
  Padding get p8 =>
      Padding(padding: const EdgeInsets.only(top: 8), child: this);
  Padding get p4 => Padding(padding: const EdgeInsets.all(8), child: this);

  /// Set padding according to `value`
  Padding p(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Horizontal Padding 16
  Padding get hP4 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: this);
  Padding get hP8 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: this);
  Padding get hP16 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: this);

  Padding get hP50 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 50), child: this);

  /// Vertical Padding 16
  Padding get vP16 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: this);

  Padding get vP36 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 36), child: this);
  Padding get vP8 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: this);
  Padding get vP4 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: this);
}

/// Other values
/// --------------------------------------------------------------------
Duration kAnimationDuration = const Duration(milliseconds: 200);

class FontSizes {
  static double scale = 1.2;
  static double get body => 14 * scale;
  static double get bodySm => 12 * scale;
  static double get title => 16 * scale;
  static double get titleSmall => 16 * scale;
  static double get titleM => 18 * scale;
  static double get sizeXXl => 28 * scale;
  static double get sizeXl => 17 * scale;
  static double get large => 23 * scale;
}

class TextStyles {
  static TextStyle get title => TextStyle(fontSize: FontSizes.title);
  static TextStyle get titleM => TextStyle(fontSize: FontSizes.titleM);
  static TextStyle get titleSize15 =>
      title.copyWith(fontWeight: FontWeight.w500, fontSize: 15);
  static TextStyle get titleNormal => title.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: FontSizes.titleSmall,
      );
  static TextStyle get titleMedium =>
      titleM.copyWith(fontWeight: FontWeight.w300);
  static TextStyle get h1Style =>
      TextStyle(fontSize: FontSizes.sizeXXl, fontWeight: FontWeight.bold);
  static TextStyle get h2Style => TextStyle(
        fontSize: FontSizes.sizeXl,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );
  static TextStyle get h3Large => TextStyle(
        fontSize: FontSizes.large,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );
  static TextStyle get headTitleColored => TextStyle(
        fontSize: FontSizes.sizeXl,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      );
  static TextStyle get body =>
      TextStyle(fontSize: FontSizes.body, fontWeight: FontWeight.w300);
  static TextStyle get bodySm => body.copyWith(fontSize: FontSizes.bodySm);
}

// This Function creates a material color from HEX color value
MaterialColor buildMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final r = color.red;
  final g = color.green;
  final b = color.blue;

  for (var i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final strength in strengths) {
    final ds = (0.5) - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
