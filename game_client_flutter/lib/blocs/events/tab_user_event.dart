import 'package:game_client_flutter/models/models.dart';

abstract class TabUserEvent{}

class TabUserEventFetched extends TabUserEvent {}

class TabUserEventUserList extends TabUserEvent {
  List<UserRes> lst;

  TabUserEventUserList(this.lst);

}

class TabUserEventJoinRoom extends TabUserEvent {
  UserRes res;

  TabUserEventJoinRoom(this.res);

}