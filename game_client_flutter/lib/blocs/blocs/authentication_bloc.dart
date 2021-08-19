import 'package:english_words/english_words.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/models/models.dart';
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
        //this.add(OnAuthProcess());
        Application.chatSocket.connectAndLogin('auth=nett');
        yield AuthenticationFail(error: 'First Login');
      }

      if (event is OnAuthProcess) {
        ///authentication process flow
        /*
        String idGen = GUIDGen.generate();
        String userGen = generateWordPairs().take(12).first.first;

        Application.chatSocket.login(
            zone: Application.zoneGameName,
            uname: '${userGen.toUpperCase()} ${idGen.hashCode}',
            upass: GUIDGen.generate(),
            param: {}
        );*/

        yield AuthenticationSuccess();
      }

      if(event is OnAuthUpdate){

      }

      if (event is OnClear) {
        LoginStorage.logout();

        yield AuthenticationFail(
          error: "OnClear"
        );

        Application.chatSocket.logout();

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