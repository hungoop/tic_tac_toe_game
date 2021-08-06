
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:game_client_flutter/exception/exception.dart';

class ImagePackage {
  static const String DATA_KEY = "data";
  static const String HEADERS_KEY = "headers";

  final Uint8List data;
  final Headers resHeaders;

  ImagePackage({required this.data, required this.resHeaders});

  factory ImagePackage.fromRes(Response response){
    return ImagePackage(
      data: response.data,
        resHeaders: response.headers
    );
  }

  String? getImageExt(){
    //return headers["content-type"];
    return resHeaders.value(Headers.contentTypeHeader);
  }

  bool isOK(){
    if(data != null && data.length > 0){
      return true;
    } else {
      return false;
    }
  }

  DataReceiveException getException(){
    return DataReceiveException(
        code: 0,
        data: "",
        message: "SAVE_IMAGE_TO_LOCAL_ERROR"
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json[DATA_KEY] = data;
    json[HEADERS_KEY] = getImageExt();
    return json;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }


}