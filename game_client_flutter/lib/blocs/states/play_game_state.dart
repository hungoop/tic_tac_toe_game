import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/entity/entity.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/utils/utils.dart';

abstract class PlayGameState {}

class PlayGameStateInitial extends PlayGameState {}

class PlayGameStateFailure extends PlayGameState {
  final String error;

  PlayGameStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class PlayGameStateSuccess extends PlayGameState {
  final RoomView dataView;
  final List<UserView> userViews;

  PlayGameStateSuccess(this.dataView, this.userViews);

  PlayGameStateSuccess cloneWith({RoomView? dataView, List<UserView>? userViews}){
    return PlayGameStateSuccess(
        dataView ?? this.dataView,
        userViews ?? this.userViews
    );
  }


}
class PlayGameStateLoading extends PlayGameState {}