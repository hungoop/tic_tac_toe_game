import 'package:equatable/equatable.dart';
import 'package:game_client_flutter/models/models.dart';

abstract class PlayGameEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlayGameEventFetched extends PlayGameEvent {
  final RoomRes res;

  PlayGameEventFetched(this.res);

  @override
  List<Object> get props => [res];
}
class PlayGameEventCreate extends PlayGameEvent {}

class PlayGameEventUserList extends PlayGameEvent {
  final List<UserRes> lst;

  PlayGameEventUserList(this.lst);

  List<Object> get props => [lst];

}

class PlayGameEventRoadMap extends PlayGameEvent {
  final List<PositionRes> lst;

  PlayGameEventRoadMap(this.lst);

  List<Object> get props => [lst];

}

class PlayGameEventPosChoose extends PlayGameEvent {
  final PositionView pos;

  PlayGameEventPosChoose(this.pos);

  List<Object> get props => [pos];

}
