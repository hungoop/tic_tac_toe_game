
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:package_info/package_info.dart';
import 'package:string_validator/string_validator.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

export 'util_preferences.dart';
export 'guid_gen.dart';
export 'util_logger.dart';
export 'util_file.dart';
export 'util_resource.dart';
export 'util_other.dart';
export 'util_permission.dart';

class Utils {

  static String localeName() {
    if(isWeb()) {
      return "en";
    }
    else {
      return Platform.localeName.split('_').first;
    }

  }

  static String formatLongText(int length, String text) {
    if(Utils.checkDataEmpty(text)){
      return "";
    }
    if(text.length > length) {
      return text.substring(0,length) + '...';
    }
    else {
      return text;
    }
  }

  static randomNext(int min, int max) {
    final _random = new Random();
    return min + _random.nextInt(max - min);
  }

  static String clearFileName(String fileName) {
    return fileName.replaceAll("/", "_");
  }

  static launchUrlUpdateIOS({required String urlPlist}) async {
    launchUrlToBrowser(urlOpen: urlPlist);
  }

  static launchUrlToBrowser({required String urlOpen}) async {
    print(urlOpen);

    if (await canLaunch(urlOpen)) {
      await launch(urlOpen);
    } else {
      throw 'Could not launch $urlOpen';
    }
  }

  static String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  static String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    assert(url.isNotEmpty, 'Url cannot be empty');
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match match = exp.firstMatch(url) as Match;
      if (match.groupCount >= 1) return match.group(1);
    }

    //return null;
  }

  static String getYoutubeThumbnailById(String idVideo) {
    return 'https://img.youtube.com/vi/$idVideo/0.jpg';
  }

  static bool checkIsUrl(String urlStr) {
    if (isEmail(urlStr)) {
      return false;
    }

    return isURL(urlStr);
  }

  static bool checkDataEmpty(String? dataInput) {
    if (dataInput == null ||
        dataInput == "" ||
        dataInput == "null" ||
        dataInput == " " ||
        dataInput == "NULL" ||
        dataInput == "nil" ||
        dataInput == "Null") {
      return true;
    }
    return false;
  }

  static bool checkImageEmpty(String? imgName) {
    if (imgName == null ||
        imgName == "" ||
        imgName == "null" ||
        imgName == " " ||
        imgName == "NULL" ||
        imgName == "nil" ||
        imgName == "Null") {
      return true;
    }
    return false;
  }

  static String encodeComponent(String uri) {
    String encodeData = Uri.encodeQueryComponent(
        uri,
    );
    return encodeData;
  }

  static String decodeComponent(String uri) {
    String decodeData = Uri.decodeQueryComponent(
        uri
    );
    return decodeData;
  }

  static String encodeFull(String uri) {
    return Uri.encodeFull(uri);
  }

  static String decodeFull(String uri) {
    return Uri.decodeFull(uri);
  }

  static isAndroid() {
    if (isWeb()) {
      return false;
    } else {
      return Platform.isAndroid;
    }
  }

  static platformSupportFCM() {
    if (isWeb()) {
      return false;
    }

    if (isIOS()) {
      return true;
    }

    if (isAndroid()) {
      return true;
    }

    return false;
  }

  static platformSupportService() {
    if (isWeb()) {
      return false;
    }

    if (isIOS()) {
      return true;
    }

    if (isAndroid()) {
      return true;
    }

    return false;
  }

  static isWeb() {
    return kIsWeb;
  }

  static isIOS() {
    if (isWeb()) {
      return false;
    } else {
      return Platform.isIOS;
    }
  }

  static isWebPC(double w) {
    if (w >= Application.WIDTH_SCREEN)
      return true;
    else
      return false;
  }

  static isIOSFrom(String platformName) {
    return "ios" == platformName;
  }

  static int round(double data) {
    return data.round();
  }

  static int parseInt(dynamic data, {int valDef = 0}) {
    try {
      return int.parse(data);
    } catch (ex) {
      print('parseInt Error: $ex, $data, ${data.runtimeType}');
    }
    if (data.runtimeType == int) {
      return data;
    } else {
      print('valDef return $valDef');
      return valDef;
    }
  }

  static String parseString(dynamic data, {String valDef = ""}) {
    try {
      return data.toString();
    } catch (ex) {
      print('parseInt Error: $ex, $data, ${data.runtimeType}');
    }
    if (data.runtimeType == int) {
      return '$data';
    } else {
      print('valDef return $valDef');
      return valDef;
    }
  }

  static Future<String> getDeviceId() async {
    if (isWeb()) {
      return "web";
    }
    else {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (isIOS()) {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor ?? ""; // unique ID on iOS
      }
      else {
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.androidId ?? ""; // unique ID on Android
      }
    }
  }

  static Future<String> getDeviceName() async {
    if (isWeb()) {
      return "web";
    } else {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (isIOS()) {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.model ?? "";
      }
      else {
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.model ?? "";
      }
    }
  }

  static Future<String> getOsVersion() async {
    if (isWeb()) {
      return "web";
    }
    else {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (isIOS()) {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.systemVersion ?? "";
      }
      else {
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        print('${androidDeviceInfo.version}');
        return androidDeviceInfo.version.release ?? "";
      }
    }
  }

  static Future<PackageInfo> getPackageInfo() async {
    if (isWeb()) {
      return PackageInfo(
        appName: 'TTT_Web',
        packageName: 'TTT_Game',
        version: '1.0.0',
        buildNumber: '1',
      );
    }
    else {
      return await PackageInfo.fromPlatform();
    }
  }

  static T tryCast<T>(dynamic x, {required T fallback}) {
    try {
      return (x as T);
    }
    on TypeError catch (e) {
      print('${e.toString()}');
      print('TypeError when trying to cast $x to $T!');
      return fallback;
    }
  }

  static String subStr(String source, int end) {
    int max = 0;
    if (source.length < end) {
      max = source.length;
    } else {
      max = end;
    }

    return source.substring(0, max);
  }

  static String parseBinary(int source) {
    return source.toRadixString(8);
  }

  static String getDateTime(dynamic data) {
  if(data!=null) {
    if (data
        .toString()
        .isNotEmpty) {
      var dateUtc = data + '+08:00';
      var dateTime = DateTime.parse(dateUtc);
      return dateTime.toLocal().toString();
    }
  }
    return "";
  }

  static String searchDateFormat(DateTime dateTime){
    var dateFormatted = DateFormat("yyyy-MM-dd");
    return dateFormatted.format(dateTime);
  }

}