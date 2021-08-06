
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/utils/utils.dart';

abstract class TabSettingState {}

class TabSettingStateInitial extends TabSettingState {}

class TabSettingStateFailure extends TabSettingState {
  final String error;

  TabSettingStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class TabSettingStateSuccess extends TabSettingState {
  final dataView;

  TabSettingStateSuccess(this.dataView);

}
class TabSettingStateLoading extends TabSettingState {}