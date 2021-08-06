
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/utils/utils.dart';

abstract class TabGameState {}

class TabGameStateInitial extends TabGameState {}

class TabGameStateFailure extends TabGameState {
  final String error;

  TabGameStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}