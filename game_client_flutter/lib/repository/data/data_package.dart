
import 'dart:convert';
import 'package:game_client_flutter/exception/exception.dart';

class DataPackage {
  static const String STATUS_CODE = "code";
  static const String DATA_KEY = "data";
  static const String MSG_KEY = "msg";

  final int bitOK;
  final String errorMsg;
  final dynamic data;

  dynamic dataToJson() {
    return jsonDecode(data);
  }

  List<dynamic> dataToList() {
    return jsonDecode(data) as List;
  }

  List<dynamic> dataAsList() {
    return data as List;
  }

  List<dynamic> dataRoadMap() {
    return dataToJson()["roadMap"] as List;
  }

  DataReceiveException getException(){
    return DataReceiveException(
        code: bitOK,
        data: data,
        message: 'DATA_RECEIVE_ERROR'
    );
  }

  bool isOK({int iSuccess = 1}){
    //bitOK java = 1, .Net = 0 is OK
    if(bitOK == iSuccess){
      return true;
    } else {
      return false;
    }
  }


  DataPackage({required this.bitOK, this.data, required this.errorMsg});

  factory DataPackage.fromStr(String strData){
    dynamic objData = jsonDecode(strData);
    return DataPackage(
        bitOK: objData[STATUS_CODE] ?? 0,
        data: objData[DATA_KEY],
        errorMsg: objData[MSG_KEY]
    );
  }

  factory DataPackage.fromJson(dynamic objData){
    return DataPackage(
        bitOK: objData[STATUS_CODE] ?? 0,
        data: objData[DATA_KEY],
        errorMsg: objData[MSG_KEY]
    );
  }

  @override
  String toString() {
    return '''
              bitOK: $bitOK,
              errorMsg: $errorMsg,
              data: $data
        ''';
  }

}