import 'package:game_client_flutter/models/models.dart';

class UserView {
  final UserRes res;

  bool choose;

  UserView(this.res, {this.choose = false});


  String title(){
  return res.uName;
  }

  String subTitle(){
  return 'ID:${this.res.uID} - session:${this.res.sessionID}';
  }

}