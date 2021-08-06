
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class AppConnectivityEvent {}

class ConnectivityEventConnect extends AppConnectivityEvent {
  final ConnectivityResult result;

  ConnectivityEventConnect({required this.result});

}

class ConnectivityEventWsError extends AppConnectivityEvent {
  final String errorCode;

  ConnectivityEventWsError({required this.errorCode});

}

class ConnectivityEventWsPingSuccess extends AppConnectivityEvent {}