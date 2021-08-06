
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/storage/storage.dart';
import 'package:game_client_flutter/utils/utils.dart';

class UtilPreferences {

  Future<bool> saveToken(String token) {
    return SharedData().setString(Preferences.KEY_TOKEN, token);
  }

  Future<bool> saveListToken(List<String> listToken) {
    return SharedData().setStringList(Preferences.KEY_LIST_TOKEN, listToken);
  }

  List<String> readListToken() {
    return SharedData().getStringList(Preferences.KEY_LIST_TOKEN);
  }

  Future<bool> removeListToken() {
    return SharedData().remove(Preferences.KEY_LIST_TOKEN);
  }

  String? readToken() {
    return SharedData().getString(Preferences.KEY_TOKEN);
  }

  Future<bool> removeToken() {
    return SharedData().remove(Preferences.KEY_TOKEN);
  }

  String? getLang() {
    return SharedData().getString(Preferences.language);
  }

  Future<bool> saveAllowNotify(bool isAllowRun){
    return SharedData().setBool(Preferences.RUN_SERVICE_NOTIFY, isAllowRun);
  }

  bool getAllowNotify(){
    bool isRunService = SharedData().getBool(Preferences.RUN_SERVICE_NOTIFY);
    return isRunService && Utils.platformSupportService();
  }

  Future<bool> saveLoginRes(String loginRes) {
    return SharedData().setString(Preferences.KEY_LOGIN_RES, loginRes);
  }

  String? readLoginRes() {
    return SharedData().getString(Preferences.KEY_LOGIN_RES);
  }

  Future<bool> removeLoginRes() {
    return SharedData().remove(Preferences.KEY_LOGIN_RES);
  }

  ///Singleton factory
  static final UtilPreferences _instance = UtilPreferences._internal();

  factory UtilPreferences() {
    return _instance;
  }

  UtilPreferences._internal();
}
