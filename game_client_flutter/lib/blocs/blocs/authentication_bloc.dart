import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/utils/utils.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthenticationState());

  bool _hasOldToken() {
    return !Utils.checkDataEmpty(UtilPreferences().readToken());
  }

  _onLoginSuccess(){
    AppBloc.authBloc.add(OnAuthProcess());
  }

  @override
  Stream<AuthState> mapEventToState(event) async* {
    try{
      if (event is OnAuthCheck) {
        ///authentication check flow
        this.add(OnAuthProcess());
      }

      if (event is OnAuthProcess) {
        ///authentication process flow
        Application.chatSocket.connectAndLogin('auth=nett');

        Application.chatSocket.login(
            zone: Application.zoneGameName,
            uname: GUIDGen.generate(),
            upass: GUIDGen.generate(),
            param: {}
        );

        yield AuthenticationSuccess();
      }

      if(event is OnAuthUpdate){

      }

      if (event is OnClear) {
        yield AuthenticationFail(
          error: "OnClear"
        );

      }
    }
    catch (ex, st) {
      print('connectAndLogin $ex');
      print('connectAndLogin $st');

      yield AuthenticationFail(
        error: ex.toString()
      );

      UtilLogger.recordError(
          ex,
          stack: st,
          fatal: true
      );
    }

  }

}