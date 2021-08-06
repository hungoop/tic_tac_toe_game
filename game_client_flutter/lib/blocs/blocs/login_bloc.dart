
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/exception/base_chat_exception.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/utils/util_logger.dart';
import 'package:game_client_flutter/validators/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(): super(LoginStateSuccess());

  _onLoginSuccess(){
    AppBloc.authBloc.add(OnAuthProcess());
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent loginEvent) async* {
    final loginState = state;

    try {
      if(loginEvent is LoginEventStarted ){
        yield LoginStateSuccess();
      }
      else
        if (loginEvent is LoginEventIdentificationChanged){

        if(loginState is LoginStateSuccess){
          yield loginState.cloneWith(
              isValidIdentification:
              Validators.isValidIdentification(
                  loginEvent.identification,
                  loginEvent.loginType
              )
          );
        }
      }
      else if (loginEvent is LoginEventPasswordChanged) {

        if(loginState is LoginStateSuccess){
          yield loginState.cloneWith(isValidPassword: Validators.isValidPassword(loginEvent.password),
              isValidIdentification: Validators.isValidIdentification(loginEvent.identification, loginEvent.loginType));
        }
      }
      else if (loginEvent is LoginEventWithEmailAndPasswordPress) {
        yield LoginStateLoading();

        print('-------LoginStateInitial--------');
        yield LoginStateSuccess();
      }

    } catch (ex, stacktrace) {
      if (ex is BaseChatException) {
        yield LoginStateFailure(error:ex.toString());
      }
      else {
        yield LoginStateFailure(
            error:AppLanguage().translator(LanguageKeys.LOGIN_FAILRURE)
        );
      }

      UtilLogger.recordError(
          ex,
          stack: stacktrace,
          fatal: true
      );
    }

  }

  LOGIN_TYPE detectLoginType(String identify, LOGIN_TYPE sourceType){
    if(sourceType == LOGIN_TYPE.EMAIL_OR_ID){
      if(Validators.isValidEmail(identify)){
        return LOGIN_TYPE.EMAIL;
      } else {
        print('identify:$identify is ID');
        return LOGIN_TYPE.USERNAME_PWD;
      }
    } else {
      return sourceType;
    }
  }

}