import 'package:game_client_flutter/models/models.dart';

abstract class FriendListEvent{}

class FriendListEventFetched extends FriendListEvent {}

class FriendListEventUserList extends FriendListEvent {
  List<UserRes> lst;

  FriendListEventUserList(this.lst);

}

class FriendListEventSelected extends FriendListEvent {
  UserRes res;

  FriendListEventSelected(this.res);

}

class FriendListEventInviteJoins extends FriendListEvent {}