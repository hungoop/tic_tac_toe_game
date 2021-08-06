import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/storage/storage.dart';
import 'package:game_client_flutter/utils/utils.dart';

class UtilResource {

  static String getGlobalCountryCode(String code, String countryCode) {
    switch (code) {
      case 'en':
        return 'EN'; // 'English';
      case 'vi':
        return 'VN'; //'Vietnamese';
      case 'zh':
        if (countryCode == "TW") {
          return 'TW';
        }
        else {
          return 'CN';
        }
        break;
      default:
        return '';
    }
  }

  static String getDefaultDialCode() {
    var dialCode = SharedData().getString(Preferences.countryCode);

    if(!Utils.checkDataEmpty(dialCode)) {
        return dialCode ?? '';
    }
    else {
        return getDefaultCountryCode();
    }
  }

  static String getDefaultCountryCode() {
    switch (AppLanguage.defaultLocale.languageCode) {
      case 'en':
        return 'EN'; // 'English';
      case 'vi':
        return 'VN'; //'Vietnamese';
      case 'zh':
        if (AppLanguage.defaultLocale.countryCode != null) {
          return 'TW';
        }
        else {
          return 'CN';
        }
        break;
      default:{
          return Utils.localeName().toUpperCase();
        }
    }
  }


  static String getGlobalLanguageName(String code, String countryCode) {
    switch (code) {
      case 'en':
        return AppLanguage().translator(LanguageKeys.ENGLISH);// 'English';
      case 'vi':
        return AppLanguage().translator(LanguageKeys.VIETNAM); //'Vietnamese';
      case 'zh':
        if(countryCode=="TW") {
          return AppLanguage().translator(LanguageKeys.TAIWAN); //'Chinese Traditional';
        }
        else {
          return AppLanguage().translator(LanguageKeys.CHINA);
        }
      break;
      case 'ar':
        return 'Arabic';
      case 'da':
        return 'Danish';
      case 'de':
        return 'German';
      case 'el':
        return 'Greek';
      case 'fr':
        return 'French';
      case 'he':
        return 'Hebrew';
      case 'id':
        return 'Indonesian';
      case 'ja':
        return 'Japanese';
      case 'ko':
        return 'Korean';
      case 'lo':
        return 'Lao';
      case 'nl':
        return 'Dutch';
      case 'fa':
        return 'Iran';
      case 'km':
        return 'Cambodian';
      case 'ru':
        return 'Russian';
      default:
        return 'Unknown';
    }
  }

  static bool isRTL() {
    switch (AppLanguage.defaultLocale.languageCode) {
      case "ar":
      case "he":
        return true;
      default:
        return false;
    }
  }

  static String exportLangTheme(DarkOption option) {
    switch (option) {
      case DarkOption.dynamic:
        return AppLanguage().translator(LanguageKeys.SETTING_DYNAMIC_THEME);
      case DarkOption.alwaysOff:
        return AppLanguage().translator(LanguageKeys.SETTING_ALWAYS_OFF);
      default:
        return AppLanguage().translator(LanguageKeys.SETTING_ALWAYS_ON);
    }
  }

  static Future<void> clearCacheAvatar(String urlImg) async {
    if (!Utils.checkImageEmpty(urlImg)) {
      await CachedNetworkImage.evictFromCache(urlImg);
    }
  }

  static bool isDarkMode() {
    SchedulerBinding? schedulerBinding = SchedulerBinding.instance;
    if(schedulerBinding != null){
      var brightness = schedulerBinding.window.platformBrightness;
      bool darkModeOn = brightness == Brightness.dark;
      return darkModeOn;
    }

    return false;
  }
}