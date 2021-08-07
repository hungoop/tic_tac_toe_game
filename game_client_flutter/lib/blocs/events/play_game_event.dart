import 'package:equatable/equatable.dart';

abstract class PlayGameEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlayGameEventFetched extends PlayGameEvent {}
class PlayGameEventRefresh extends PlayGameEvent {}
