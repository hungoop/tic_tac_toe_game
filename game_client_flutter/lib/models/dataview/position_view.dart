import 'package:game_client_flutter/models/entity/entity.dart';

class PositionView {
  final PositionRes res;

  bool choose;

  PositionView(this.res, {this.choose = false});

  int getX(){
    return res.x;
  }

  int getY(){
    return res.y;
  }

  int getType(){
    return res.type.getId();
  }

}