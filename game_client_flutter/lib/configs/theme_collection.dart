import 'package:flutter/material.dart';

class CollectionTheme {
  ///Get collection theme

  static ThemeData getCollectionTheme({
    String theme = "defaultLight",
    String? font,
  }) {
    ColorScheme colorScheme;
    switch (theme) {
      case "defaultLight":
        colorScheme = ColorScheme.light(
          primary: Color(0xff82B541),
          primaryVariant: Color(0xff51850a),
          secondary: Color(0xffff8a65),
          secondaryVariant: Color(0xffc75b39),
          surface: Color(0xfff2f2f2),
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        );
        break;
      case "defaultDark":
        colorScheme = ColorScheme.dark(
          primary: Color(0xff82B541),
          primaryVariant: Color(0xff51850a),
          secondary: Color(0xffff8a65),
          secondaryVariant: Color(0xffc75b39),
          surface: Color(0xff121212),
          background: Color(0xff010101),
          error: Colors.red,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.black,
          brightness: Brightness.dark,
        );
        break;
      case "orangeLight":
        colorScheme = ColorScheme.light(
          primary: Color(0xfff4a261),
          primaryVariant: Color(0xffe76f51),
          secondary: Color(0xff2A9D8F),
          secondaryVariant: Color(0xff264653),
          surface: Color(0xfff2f2f2),
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        );
        break;
      case "orangeDark":
        colorScheme = ColorScheme.dark(
          primary: Color(0xfff4a261),
          primaryVariant: Color(0xffe76f51),
          secondary: Color(0xff2A9D8F),
          secondaryVariant: Color(0xff264653),
          surface: Color(0xff121212),
          background: Color(0xff010101),
          error: Colors.red,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.black,
          brightness: Brightness.dark,
        );
        break;
      case "lvChatLight":
        colorScheme = ColorScheme.light(
          primary: Color(0xff01A0C7),
          primaryVariant: Color(0xff51850a),
          secondary: Color(0xffff8a65),
          secondaryVariant: Color(0xffc75b39),
          surface: Color(0xffc1b9b9),
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        );
        break;
      case "lvChatDark":
        colorScheme = ColorScheme.dark(
          primary: Color(0xff01A0C7),
          primaryVariant: Color(0xff51850a),
          secondary: Color(0xffff8a65),
          secondaryVariant: Color(0xffc75b39),
          surface: Color(0xff121212),
          background: Color(0xff010101),
          error: Colors.red,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.black,
          brightness: Brightness.dark,
        );
        break;
      default:
        colorScheme = ColorScheme.light(
          primary: Color(0xff01A0C7),
          primaryVariant: Color(0xff51850a),
          secondary: Color(0xffff8a65),
          secondaryVariant: Color(0xffc75b39),
          surface: Color(0xffc1b9b9),
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        );
    }

    final dark = colorScheme.brightness == Brightness.dark;
    final primaryColor = dark ? colorScheme.surface : colorScheme.primary;
    final appBarColor = dark ? colorScheme.surface : colorScheme.background;
    final indicatorColor = dark ? colorScheme.onSurface : colorScheme.primary;

    final titleAppColor = dark ? colorScheme.onSurface : colorScheme.onSecondary;
    return ThemeData(
      brightness: colorScheme.brightness,
      primaryColor: colorScheme.primary,
      primaryColorBrightness: ThemeData.estimateBrightnessForColor(
        primaryColor,
      ),
      appBarTheme: AppBarTheme(
        color: appBarColor,
        iconTheme: IconThemeData(
          color: titleAppColor,
        ),
      ),

      //primarySwatch: colorScheme.onPrimary,
      primaryTextTheme: TextTheme(
        headline6: TextStyle(
          color: titleAppColor
        )
      ),

      canvasColor: colorScheme.background,
      accentColor: colorScheme.secondary,
      accentColorBrightness: ThemeData.estimateBrightnessForColor(
        colorScheme.secondary,
      ),
      scaffoldBackgroundColor: colorScheme.background,
      bottomAppBarColor: colorScheme.surface,
      cardColor: colorScheme.surface,
      dividerColor: colorScheme.onSurface.withOpacity(0.12),
      backgroundColor: colorScheme.background,
      dialogBackgroundColor: colorScheme.surface,
      errorColor: colorScheme.error,
      indicatorColor: indicatorColor,
      applyElevationOverlayColor: dark,
      colorScheme: colorScheme,
      fontFamily: font,
      buttonColor: colorScheme.primary,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      ),
    );
  }

  ///Singleton factory
  static final CollectionTheme _instance = CollectionTheme._internal();

  factory CollectionTheme() {
    return _instance;
  }

  CollectionTheme._internal();
}
