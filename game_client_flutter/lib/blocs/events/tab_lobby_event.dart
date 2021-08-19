import 'package:game_client_flutter/models/models.dart';

abstract class TabLobbyEvent{}

class TabLobbyEventFetched extends TabLobbyEvent {}

class TabLobbyEventRoomList extends TabLobbyEvent {
  List<RoomRes> lst;

  TabLobbyEventRoomList(this.lst);

}

class TabLobbyEventJoinRoom extends TabLobbyEvent {
  RoomRes res;

  TabLobbyEventJoinRoom(this.res);

}

class TabLobbyEventCreateRoom extends TabLobbyEvent {}