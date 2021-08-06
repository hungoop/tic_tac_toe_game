
import 'package:equatable/equatable.dart';
import 'package:ota_update/ota_update.dart';

class SplashScreenEvent extends Equatable {

  @override
  List<Object> get props => [];

}

class SplashScreenEventStart extends SplashScreenEvent{}

class SplashScreenEventGotoLogin extends SplashScreenEvent{}

class SplashScreenEventShowMessage extends SplashScreenEvent{
  final String message;

  SplashScreenEventShowMessage({required this.message});

  @override
  List<Object> get props => [message];

}

class SplashScreenEventNewUpdate extends SplashScreenEvent{}

class SplashScreenEventDownloadConfirm extends SplashScreenEvent{}

class SplashScreenEventUpdateStatus extends SplashScreenEvent{
  final OtaStatus status;
  final String value;

  SplashScreenEventUpdateStatus({required this.status, required this.value});

  @override
  List<Object> get props => [status, value];
}

