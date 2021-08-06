

import 'package:game_client_flutter/repository/repository.dart';

class LocalMessage extends WsMessageBase {
  static const String LIST_FRIEND_DELETE      = "list_friend_delete";
  static const String LIST_ROOM_DELETE        = "list_room_delete";

  String _cmd;

  String get cmd => _cmd;

  LocalMessage({required String cmd, dynamic data}) :
        _cmd = cmd,
        super(data: data);

  @override
  String toString() {
    return '$cmd';
  }

}