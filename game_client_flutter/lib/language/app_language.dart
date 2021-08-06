import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/storage/storage.dart';
import 'package:game_client_flutter/utils/utils.dart';

class AppLanguage {
  ///Default Lang
  static LANG defaultLANG = LANG.TW;

  static Locale defaultLocale = getSupportLocale();

  ///List Language support in Application
  static List<Locale> supportLanguage = [
    const Locale('en'),
    const Locale('vi'),
    const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'), // 'zh_Hant_TW'
    const Locale.fromSubtags(languageCode: 'zh'), // generic Chinese 'zh'
  ];

  static Locale getSupportLocale() {
    String? langCode = SharedData().getString(Preferences.languageCode);
    print('getSupportLocale languageCode: $langCode');

    if (!Utils.checkDataEmpty(langCode)) {
      return const Locale.fromSubtags(
          languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW');
    }
    else {
      String? lang = SharedData().getString(Preferences.language);
      print('getSupportLocale language: $lang');

      if (!Utils.checkDataEmpty(lang)) {
        if (lang!.toLowerCase() == LANG.EN.getLanguageCode().toLowerCase()) {
          return Locale('en');
        }
        else
        if (lang.toLowerCase() == LANG.VN.getLanguageCode().toLowerCase()) {
          return Locale('vi');
        }
        else
        if (lang.toLowerCase() == LANG.CN.getLanguageCode().toLowerCase()) {
          return Locale.fromSubtags(languageCode: 'zh');
        }
      }
    }

    String systemLang = Utils.localeName();
    if (systemLang.toLowerCase() != LANG.CN.getLanguageCode().toLowerCase()) {
      return Locale(systemLang.toLowerCase());
    }
    else {
      return const Locale.fromSubtags(languageCode: 'zh');
    }
  }

  ///Singleton factory
  static final AppLanguage _instance = AppLanguage._internal();

  factory AppLanguage() {
    return _instance;
  }

  AppLanguage._internal();

  String translator(String key) {
    try {
      if(langDataJson != null){
        return langDataJson[key] ?? key;
      }
      else {
        //return key.tr() ?? key;
        return key;
      }
    }
    catch (ex) {
      print('getLanguage key: $key ex: $ex');
      return key;
    }
  }

  // TODO xử lý language for service background
  dynamic langDataJson;

  String getPathLangResource(Locale locale){
    String pathStr = 'assets/translations/zh-Hant-TW.json';
    if(locale.languageCode == 'vi'){
      pathStr = 'assets/translations/vi.json';
    }
    else if(locale.languageCode == 'en') {
      pathStr = 'assets/translations/en.json';
    }
    else if(locale.languageCode == 'zh') {
      if(locale.countryCode == 'TW'){
        pathStr = 'assets/translations/zh-Hant-TW.json';
      } else {
        pathStr = 'assets/translations/zh.json';
      }
    }

    return pathStr;
  }

   Future<void> loadDataJson() async {
     Locale locale = AppLanguage.getSupportLocale();

     UtilLogger.log('loadDataJson locale', '$locale');

    String langStr = await UtilFile().readStringFromRoot(
        getPathLangResource(locale)
    );

    UtilLogger.log('loadDataJson', '${getPathLangResource(locale)}');

    if(langStr != null){
      langDataJson = jsonDecode(langStr);
    }

  }

}

enum LANG {
  EN,
  VN,
  CN,
  TW
}

extension LANG_EXT on LANG {
  static String _countryCode(LANG key){
    switch (key) {
      case LANG.EN: {
        return "EN";
      }
      break;
      case LANG.VN: {
        return "VN";
      }
      break;
      case LANG.TW: {
        return "TW";
      }
      break;
      case LANG.CN: {
        return "CN";
      }
      break;
      default:{
        return AppLanguage.defaultLANG.getCountryCode();
      }
      break;
    }
  }

  static String _languageCode(LANG key){
    switch (key) {
      case LANG.EN: {
        return "en";
      }
      break;
      case LANG.VN: {
        return "vi";
      }
      break;
      case LANG.TW: {
        return "zh";
      }
      break;
      case LANG.CN: {
        return "zh";
      }
      break;
      default:{
        return AppLanguage.defaultLANG.getLanguageCode();
      }
      break;
    }
  }

  String getCountryCode(){
    return _countryCode(this);
  }

  String getLanguageCode(){
    return _languageCode(this);
  }

  static LANG parseFromCountryCode(String cCode){
    return LANG.values.firstWhere((element) {
      return element.getCountryCode() == cCode.toUpperCase();
    }, orElse: () => AppLanguage.defaultLANG);
  }

  static LANG parseFromLanguageCode(String lCode){
    return LANG.values.firstWhere((element) {
      return element.getLanguageCode() == lCode;
    }, orElse: () => AppLanguage.defaultLANG);
  }
}
