
import 'package:equatable/equatable.dart';

class SplashScreenState extends Equatable {
  @override
  List<Object> get props => [];

}

class SplashScreenStateInitial extends SplashScreenState {}

class SplashScreenStateFlash extends SplashScreenState {}

class SplashScreenStateShowMessage extends SplashScreenState {
  final String message;

  SplashScreenStateShowMessage({required this.message});

  @override
  List<Object> get props => [message];
}

class SplashScreenStateNewUpdate extends SplashScreenState {}

class SplashScreenStateDownloading extends SplashScreenState {
  final String value;

  SplashScreenStateDownloading({required this.value});

  @override
  List<Object> get props => [value];
}