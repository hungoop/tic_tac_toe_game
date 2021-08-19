
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/utils/utils.dart';

abstract class FriendListState {}

class FriendListStateInitial extends FriendListState {}

class FriendListStateFailure extends FriendListState {
  final String error;

  FriendListStateFailure({required this.error});

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return AppLanguage().translator(LanguageKeys.ERROR_MY_CLIENT);
  }

}

class FriendListStateSuccess extends FriendListState {
  final List<UserView> views;
  final int countSelected;

  FriendListStateSuccess(this.views, {this.countSelected = 0});

  FriendListStateSuccess cloneWith({
    List<UserView>? views,
    int? countSelected
  }){
    return FriendListStateSuccess(
      views ?? this.views,
      countSelected: countSelected ?? this.countSelected
    );
  }

}
