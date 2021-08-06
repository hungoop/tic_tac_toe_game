
import 'dart:io';
import 'dart:math';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class UtilFile {

  static Future<String> getTempFilePath() async {
    Directory appTempDirectory  = await getTemporaryDirectory();
    return appTempDirectory.path;
  }

  static Future<String> _getApplicationSupportFilePath() async {
    Directory appDocumentsDirectory = await getApplicationSupportDirectory();

    print(appDocumentsDirectory);

    return appDocumentsDirectory.path;
  }

  static Future<String> _getExternalStorageFilePathWith({required StorageDirectory type}) async {
    List<Directory>? appDocumentsDirectory = await getExternalStorageDirectories(type: type);

    print(appDocumentsDirectory);
    if(appDocumentsDirectory != null){
      return appDocumentsDirectory[0].path;
    }
    else {
      return "";
    }

  }

  static Future<String> _getExternalStorageFilePath() async {
    List<Directory>? appDocumentsDirectory = await getExternalStorageDirectories();

    print(appDocumentsDirectory);

    print(appDocumentsDirectory);
    if(appDocumentsDirectory != null){
      return appDocumentsDirectory[0].path;
    }
    else {
      return "";
    }
  }

  static Future<String> _getDocumentsFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    return appDocumentsDirectory.path;
  }

  static Future<String> _getDownloadFilePath() async {
    Directory? appDownloadsDirectory = await getDownloadsDirectory();

    if(appDownloadsDirectory != null){
      return appDownloadsDirectory.path;
    }
    else {
      return "";
    }
  }

  static Future<String> createTempFilePath(String nameFile) async {
    String tempDirectoryPath = await getTempFilePath();
    return '$tempDirectoryPath/$nameFile';
  }

  static Future<String> createApplicationSupportFilePath(String nameFile) async {
    String downloadsDirectoryPath = await _getApplicationSupportFilePath();
    return '$downloadsDirectoryPath/$nameFile';
  }

  static Future<String> createExternalStorageFilePathWith(String nameFile, {required StorageDirectory type}) async {
    String downloadsDirectoryPath = await _getExternalStorageFilePathWith(type: type);
    return '$downloadsDirectoryPath/$nameFile';
  }

  static Future<String> createExternalStorageFilePath(String nameFile) async {
    String downloadsDirectoryPath = await _getExternalStorageFilePath();
    return '$downloadsDirectoryPath/$nameFile';
  }

  static Future<String> createDocumentsFilePath(String nameFile) async {
    String downloadsDirectoryPath = await _getDocumentsFilePath();
    return '$downloadsDirectoryPath/$nameFile';
  }

  static Future<String> createDownloadFilePath(String nameFile) async {
    String downloadsDirectoryPath = await _getDownloadFilePath();
    return '$downloadsDirectoryPath/$nameFile';
  }

  static Future<File> saveStringToFile(String path, {String data = ""}) async {
    File file = File(path);
    return await file.writeAsString(data);
  }

  static Future<File> saveBytesToFile(String path, {required List<int> data}) async {
    File file = File(path);
    return await file.writeAsBytes(data);
  }

  static Future<String> readStringFile(String path) async {
    File file = File(path);
    return await file.readAsString();
  }



  static Future<String> getPathStorageTempFile(String fileName) async {
    return createTempFilePath(fileName);
  }


  static Future<bool> checkFileExisted(String fullPath) async {
    return await File(fullPath).exists();
  }

  Future<String> readStringFromRoot(String pathKey) async {
    return await rootBundle.loadString(pathKey);
  }

  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
  }

  static bool checkBigFileSize(int bytes){
    int maxSize = (pow(1024, 2) * Application.MAX_FILE_SIZE_UPLOAD).round();
    UtilLogger.log('checkBigFileSize', '$maxSize');
    return  bytes > maxSize;
  }

}