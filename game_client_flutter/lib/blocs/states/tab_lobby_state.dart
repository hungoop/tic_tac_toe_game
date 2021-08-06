
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/utils/utils.dart';

abstract class TabLobbyState {}

class TabLobbyStateInitial extends TabLobbyState {}

class TabLobbyStateFailure extends TabLobbyState {
  final String error;

  TabLobbyStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}