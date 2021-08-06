
import 'package:equatable/equatable.dart';

abstract class TabSettingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TabSettingEventFetched extends TabSettingEvent {}
class TabSettingEventRefresh extends TabSettingEvent {}

class TabSettingEventBlockStranger extends TabSettingEvent {}

class TabSettingEventNewUpdate extends TabSettingEvent {}

class TabSettingEventServiceNotify extends TabSettingEvent {
  final bool isRun;

  TabSettingEventServiceNotify(this.isRun);

  @override
  List<Object> get props => [isRun];

}