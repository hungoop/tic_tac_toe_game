
import 'package:game_client_flutter/repository/repository.dart';

class WsSystemMessage extends WsMessageBase {
  static const ON_CLIENT_ERROR      = -2;
  static const ON_CLIENT_DONE       = -1;
  static const LOGIN                = 1;
  static const LOGOUT               = 2;
  static const JOINT_ROOM           = 4;
  static const CREATE_OR_JOIN_ROOM  = 5;
  static const CREATE_ROOM          = 6;
  static const EXTENSION            = 13;
  static const LEAVE_ROOM           = 14;
  static const ON_USER_ENTER_ROOM   = 41;
  static const ON_USER_LOST         = 43;
  static const ON_ROOM_LOST         = 44;
  static const ON_USER_LEAVE_ROOM   = 45;
  static const ON_USER_PING         = 50;

  int _cmd;

  int get cmd => _cmd;

  WsSystemMessage({required int cmd, dynamic data}):
        _cmd = cmd,
      super(data: data);

  @override
  String toString() {
    return '$cmd';
  }
}