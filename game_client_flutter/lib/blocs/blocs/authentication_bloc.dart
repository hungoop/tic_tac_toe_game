import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
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
        yield AuthenticationSuccess();

      }

      if(event is OnAuthUpdate){

      }

      if (event is OnClear) {
        yield AuthenticationFail();

      }
    } catch (ex, stacktrace) {
      yield AuthenticationFail();

      UtilLogger.recordError(
          ex,
          stack: stacktrace,
          fatal: true
      );
    }

  }

}