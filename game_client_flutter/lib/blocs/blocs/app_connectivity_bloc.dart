
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/utils/utils.dart';

class AppConnectivityBloc extends Bloc<AppConnectivityEvent, AppConnectivityState> {
  AppConnectivityBloc() : super(ConnectivityStateInitial());

  @override
  Stream<AppConnectivityState> mapEventToState(AppConnectivityEvent event) async* {
    var curr = state;
    try {
      if(event is ConnectivityEventConnect) {
        switch (event.result) {
          case ConnectivityResult.wifi:
          case ConnectivityResult.mobile:{
            if(curr is ConnectivityStateFail){
              Application.chatSocket.forceCheckReConnect(isFore: true);
            }
            yield ConnectivityStateSuccess();
          }
          break;
          case ConnectivityResult.none:{
            if(curr is ConnectivityStateSuccess){
              Application.chatSocket.forcePing();
            }
            yield ConnectivityStateFail(
                errorCode: LanguageKeys.DEVICE_OFF_NETWORK_ERROR
            );
          }
          break;
          default:
            if(curr is ConnectivityStateInitial){
              yield ConnectivityStateSuccess();
            }
            break;
        }
      }
      else if (event is ConnectivityEventWsError) {
        if(curr is ConnectivityStateSuccess){
          yield ConnectivityStateFail(errorCode: event.errorCode);
        }

      }
      else if (event is ConnectivityEventWsPingSuccess) {
        if(curr is ConnectivityStateFail){
          yield ConnectivityStateSuccess();
        }
      }
    } catch (ex, stacktrace) {
      UtilLogger.recordError(
          ex,
          stack: stacktrace,
          fatal: true
      );
    }

  }

}