abstract class AppConnectivityState {}

class ConnectivityStateInitial extends AppConnectivityState {}
class ConnectivityStateSuccess extends AppConnectivityState {}
class ConnectivityStateFail extends AppConnectivityState {
  final String errorCode;

  ConnectivityStateFail({required this.errorCode});

}