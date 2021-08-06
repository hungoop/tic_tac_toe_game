
import 'package:game_client_flutter/repository/repository.dart';

class WsExtensionMessage extends WsMessageBase {
  String _cmd;

  String get cmd => _cmd;

  WsExtensionMessage({required String cmd, dynamic data}) :
      _cmd = cmd,
      super(data: data);

  DataPackage getPackage(){
    return DataPackage.fromJson(data);
  }

  @override
  String toString() {
    return '$cmd';
  }
}