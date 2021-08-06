
import 'package:game_client_flutter/exception/exception.dart';

class DataReceiveException extends BaseChatException {
  final int code;
  final String data;

  DataReceiveException({this.code = -1, this.data = "", String message = ""}) : super(message);

}