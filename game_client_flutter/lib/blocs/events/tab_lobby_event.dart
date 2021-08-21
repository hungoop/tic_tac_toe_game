import 'package:game_client_flutter/models/models.dart';

abstract class TabLobbyEvent{}

class TabLobbyEventFetched extends TabLobbyEvent {}

class TabLobbyEventRoomList extends TabLobbyEvent {
  List<RoomRes> lst;

  TabLobbyEventRoomList(this.lst);

}

class TabLobbyEventJoinRoom extends TabLobbyEvent {
  final RoomRes res;
  final bool isAccept;

  TabLobbyEventJoinRoom(this.res, this.isAccept);

}

class TabLobbyEventCreateRoom extends TabLobbyEvent {}

class TabLobbyEventInvitedJoin extends TabLobbyEvent {
  RoomRes res;

  TabLobbyEventInvitedJoin(this.res);

}