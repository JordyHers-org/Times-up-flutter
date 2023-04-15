import 'package:flutter/material.dart';


class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
      backgroundColor: Colors.white,
      primarySwatch: Colors.indigo,
      brightness: Brightness.light,
      cardTheme: CardTheme(color: Colors.white),
      textTheme: TextTheme(headline4: TextStyle(color: Colors.indigo)),
      iconTheme: IconThemeData(color: Colors.indigo),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.indigo),
      bottomAppBarColor: Colors.indigo,
      dividerColor: Colors.indigo,
      primaryTextTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)));

  static ThemeData DarkTheme = ThemeData(
      backgroundColor: Colors.black,
      primarySwatch: Colors.indigo,
      brightness: Brightness.light,
      cardTheme: CardTheme(color: Colors.white),
      textTheme: TextTheme(headline4: TextStyle(color: Colors.indigo)),
      iconTheme: IconThemeData(color: Colors.white),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.indigo),
      bottomAppBarColor: Colors.white,
      dividerColor: Colors.grey.shade200,
      primaryTextTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)));

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);
}


extension PaddingHelper on Widget {
  Padding get p16 => Padding(padding: EdgeInsets.all(16), child: this);
  Padding get p8 => Padding(padding: EdgeInsets.only(top: 8), child: this);
  Padding get p4 => Padding(padding: EdgeInsets.all(8), child: this);

  /// Set padding according to `value`
  Padding p(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Horizontal Padding 16
  Padding get hP4 => Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: this);
  Padding get hP8 => Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: this);
  Padding get hP16 => Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: this);

  /// Vertical Padding 16
  Padding get vP16 =>
      Padding(padding: EdgeInsets.symmetric(vertical: 16), child: this);
  Padding get vP8 =>
      Padding(padding: EdgeInsets.symmetric(vertical: 8), child: this);
  Padding get vP4 =>
      Padding(padding: EdgeInsets.symmetric(vertical: 8), child: this);
}

/// Other values
/// --------------------------------------------------------------------
Duration kAnimationDuration = Duration(milliseconds: 200);

class FontSizes {
  static double scale = 1.2;
  static double get body => 14 * scale;
  static double get bodySm => 12 * scale;
  static double get title => 16 * scale;
  static double get titleSmall => 16 * scale;
  static double get titleM => 18 * scale;
  static double get sizeXXl => 28 * scale;
  static double get sizeXl => 17 * scale;
  static double get Large => 23 * scale;
}

class TextStyles {
  static TextStyle get title =>TextStyle(fontSize: FontSizes.title);
  static TextStyle get titleM =>TextStyle(fontSize: FontSizes.titleM);
  static TextStyle get titleSize15 => title.copyWith(fontWeight: FontWeight.w500,fontSize: 15);
  static TextStyle get titleNormal => title.copyWith(fontWeight: FontWeight.w500,fontSize: FontSizes.titleSmall);
  static TextStyle get titleMedium => titleM.copyWith(fontWeight: FontWeight.w300);
  static TextStyle get h1Style => TextStyle(fontSize: FontSizes.sizeXXl, fontWeight: FontWeight.bold);
  static TextStyle get h2Style => TextStyle(fontSize: FontSizes.sizeXl, fontWeight: FontWeight.bold,color: Colors.black);
  static TextStyle get h3Large => TextStyle(fontSize: FontSizes.Large, fontWeight: FontWeight.bold,color: Colors.black);
  static TextStyle get headTitleColored=> TextStyle(fontSize: FontSizes.sizeXl, fontWeight: FontWeight.bold,color: Colors.blueAccent);
  static TextStyle get body => TextStyle(fontSize: FontSizes.body, fontWeight: FontWeight.w300);
  static TextStyle get bodySm => body.copyWith(fontSize: FontSizes.bodySm);
}





