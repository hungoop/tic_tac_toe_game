import 'dart:collection';

import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/repository/repository.dart';
import 'package:game_client_flutter/utils/utils.dart';

class UserListModel {
  List<UserView> dataViews;

  UserListModel(this.dataViews);

  factory UserListModel.fromRes(List<UserRes> lst){
    List<UserView> temps = lst.map((e) {
      return UserView(e);
    }).toList();

    return UserListModel(temps);
  }

  static List<UserRes> parseRes(DataPackage data){
    List<UserRes> lst = data.dataToList().map((e) {
      return UserRes.fromJson(e);
    }).toList();

    return lst;
  }

  UserView? updateSelected(UserRes res){
    UserView? userView;
    try{
      userView = getUserByRes(res);
      userView.choose = !userView.choose;
      return userView;
    } catch (ex, st) {
      UtilLogger.recordError(
        ex,
        stack: st
      );
    }

    return userView;
  }

  UserView getUserByRes(UserRes res){
    return dataViews.firstWhere((element) {
      return (element.res.uID == res.uID);
    });
  }

  int countSelected(){
    return dataViews.where((element) {
      return element.choose;
    }).toList().length;
  }

  List<UserView> friendsSelected() {
    return dataViews.where((element) {
      return element.choose;
    }).toList();
  }

  List<String> idsSelected() {
    List<String> rs = [];
    for(UserView v in friendsSelected()){
      rs.add(v.res.uID);
    }
    return rs;
  }

}