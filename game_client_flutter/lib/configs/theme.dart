import 'package:flutter/material.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/utils/utils.dart';

enum DarkOption { dynamic, alwaysOn, alwaysOff }

class AppTheme {
  ///Optional Color
  static Color blueColor = Color.fromRGBO(93, 173, 226, 1);
  static Color pinkColor = Color.fromRGBO(165, 105, 189, 1);
  static Color greenColor = Color.fromRGBO(88, 214, 141, 1);
  static Color yellowColor = Color.fromRGBO(253, 198, 10, 1);

  ///Default font
  static String currentFont = 'ProximaNova';

  ///List Font support
  static List<String> fontSupport = [
    "OpenSans",
    "ProximaNova",
    "Raleway",
    "Roboto",
    "Merriweather",
  ];

  ///Default Theme
  static ThemeModel currentTheme = ThemeModel.fromJson({
    "name": "default",//default
    "color": Color(0xff82B541),
    "fontColor": Colors.white,
    "light": "defaultLight",
    "dark": "defaultDark",
  });

  ///List Theme Support in Application
  static List<ThemeModel> themeSupport = [
    {
      "name": '${AppLanguage().translator(LanguageKeys.THEME_DEFAULT_TEXT)}',
      "color": Color(0xff82B541),
      "fontColor": Colors.white,
      "light": "defaultLight",
      "dark": "defaultDark",
    },
    {
      "name": '${AppLanguage().translator(LanguageKeys.THEME_ORANGE_TEXT)}',
      "color": Color(0xfff4a261),
      "fontColor": Colors.white,
      "light": "orangeLight",
      "dark": "orangeDark",
    },
    {
      "name": '${AppLanguage().translator(LanguageKeys.THEME_MYAPP_TEXT)}',
      "color": Color(0xff01A0C7),
      "fontColor": Colors.white,
      "light": "lvChatLight",
      "dark": "lvChatDark",
    },
  ].map((item) => ThemeModel.fromJson(item)).toList();

  ///Dark Theme option
  static DarkOption darkThemeOption = DarkOption.dynamic;

  static ThemeData lightTheme = CollectionTheme.getCollectionTheme(
    theme: currentTheme.lightTheme,
  );

  static ThemeData darkTheme = CollectionTheme.getCollectionTheme(
    theme: currentTheme.darkTheme,
  );

  Color bubbleColor() {
    Color bubbleColor = Color.fromARGB(49, 255, 255, 255);
    bool darkModeOn = UtilResource.isDarkMode();
    if (AppTheme.darkThemeOption != DarkOption.alwaysOn && !darkModeOn ||
        AppTheme.darkThemeOption == DarkOption.alwaysOff) {
      bubbleColor = Color.fromARGB(34, 106, 106, 106);
    }
    return bubbleColor;
  }

  Color bubbleTextColor() {
    Color color = AppTheme.currentTheme.fontColor;
    bool darkModeOn = UtilResource.isDarkMode();
    if (AppTheme.darkThemeOption != DarkOption.alwaysOn && !darkModeOn ||
        AppTheme.darkThemeOption == DarkOption.alwaysOff) {
      color = Colors.black;
    }
    return color;
  }


  ///Singleton factory
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}
