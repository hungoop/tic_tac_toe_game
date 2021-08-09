import 'package:game_client_flutter/models/models.dart';

class RoomView{
  final RoomRes res;

  bool choose;

  RoomView(this.res, {this.choose = false});

  String title(){
    return res.rName;
  }

  String subTitle(){
    return 'ID:${this.res.rID} - totalUser:${this.res.uCount}';
  }

}