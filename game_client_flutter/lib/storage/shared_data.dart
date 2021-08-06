
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/utils/util_preferences.dart';
import 'package:game_client_flutter/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  SharedPreferences? _preferences;
  static final SharedData _sharedData = new SharedData._internal();

  SharedData._internal();

  factory SharedData() {
    return _sharedData;
  }

  Future<void> setPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  SharedPreferences getPreferences() {
    //if(_preferences == null){
    //  await setPreferences();
    //}
    return _preferences!;
  }

  //////////////////////////////////
  Future<bool> clear() {
    return getPreferences().clear();
  }

  bool containsKey(String key) {
    return getPreferences().containsKey(key);
  }

  dynamic get(String key) {
    return getPreferences().get(key);
  }

  bool getBool(String key) {
    return getPreferences().getBool(key) ?? false;
  }

  double? getDouble(String key) {
    return getPreferences().getDouble(key);
  }

  int? getInt(String key) {
    return getPreferences().getInt(key);
  }

  Set<String> getKeys() {
    return getPreferences().getKeys();
  }

  String? getString(String key) {
    return getPreferences().getString(key);
  }

  List<String> getStringList(String key) {
    return getPreferences().getStringList(key) ?? [];
  }

  Future<void> reload() {
    return getPreferences().reload();
  }

  Future<bool> remove(String key) {
    return getPreferences().remove(key);
  }

  Future<bool> setBool(String key, bool value) {
    return getPreferences().setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) {
    return getPreferences().setDouble(key, value);
  }

  Future<bool> setInt(String key, int value) {
    return getPreferences().setInt(key, value);
  }

  Future<bool> setString(String key, String value) {
    return getPreferences().setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) {
    return getPreferences().setStringList(key, value);
  }

}