import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/utils/utils.dart';

abstract class AuthState {}

class InitialAuthenticationState extends AuthState {}

class AuthenticationSuccess extends AuthState {}

class AuthenticationFail extends AuthState {
  final String error;

  AuthenticationFail({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }
}