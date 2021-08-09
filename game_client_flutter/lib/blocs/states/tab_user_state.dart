
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/utils/utils.dart';

abstract class TabUserState {}

class TabUserStateInitial extends TabUserState {}

class TabUserStateFailure extends TabUserState {
  final String error;

  TabUserStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class TabUserStateSuccess extends TabUserState {
  List<UserView> views;

  TabUserStateSuccess(this.views);

}