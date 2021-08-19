
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/utils/utils.dart';

class AppStateBloc extends Bloc<AppStateEvent, AppState> {
  AppStateBloc() : super(AppStateInitial());

  @override
  Stream<AppState> mapEventToState(AppStateEvent event) async* {
    var currState = state;

    try {
      if(currState is AppStateInitial){
        // ???
      }

      if (event is OnResume) {
        if(currState is Background){
          Application.chatSocket.forceCheckReConnect();
        }

        yield Active();
      }

      if (event is OnBackground) {
        yield Background();
      }

      if(event is OnLoginDoneNotify){

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


