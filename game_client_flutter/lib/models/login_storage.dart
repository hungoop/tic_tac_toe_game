import 'dart:convert';
import 'package:game_client_flutter/utils/utils.dart';

class LoginStorage {
  String identification;
  String? token;

  LoginStorage(this.identification, {this.token});

  factory LoginStorage.fromString(String data){
    dynamic json = jsonDecode(data);
    return LoginStorage.fromJson(json);
  }

  factory LoginStorage.fromJson(dynamic json){
    return LoginStorage(
      json["identification"],
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map['identification'] = this.identification;
    map['token'] = this.token;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  static LoginStorage? read(){
    String? dataLogin = UtilPreferences().readLoginRes();

    if(dataLogin != null){
      return LoginStorage.fromString(dataLogin);
    }
    return null;
  }

  static logout(){
    UtilPreferences().removeLoginRes();
  }

  void save(){
    UtilPreferences().saveLoginRes(this.toString());
  }

  void delete(){
    UtilPreferences().removeLoginRes();
  }

  void update({String? identification, String? token}){
    if(identification != null){
      this.identification = identification;
    }
    if(token != null){
      this.token = token;
    }
  }

  void updateAndSave({String? identification, String? token}){
    update(identification: identification, token: token);
    save();
  }

}