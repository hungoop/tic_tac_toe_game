import 'package:equatable/equatable.dart';
import 'package:game_client_flutter/models/models.dart';

abstract class PlayGameEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlayGameEventFetched extends PlayGameEvent {}

class PlayGameEventUserList extends PlayGameEvent {
  final List<UserRes> lst;

  PlayGameEventUserList(this.lst);

  List<Object> get props => [lst];

}
