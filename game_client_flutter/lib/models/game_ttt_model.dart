/*
{"roadMap":[
{"t":0,"x":0,"y":0},{"t":0,"x":0,"y":1},{"t":0,"x":0,"y":2},
{"t":0,"x":0,"y":3},{"t":0,"x":0,"y":4},{"t":0,"x":1,"y":0},
{"t":0,"x":1,"y":1},{"t":0,"x":1,"y":2},{"t":0,"x":1,"y":3},
{"t":0,"x":1,"y":4},{"t":0,"x":2,"y":0},{"t":0,"x":2,"y":1},
{"t":0,"x":2,"y":2},{"t":0,"x":2,"y":3},{"t":0,"x":2,"y":4},
{"t":0,"x":3,"y":0},{"t":0,"x":3,"y":1},{"t":0,"x":3,"y":2},
{"t":0,"x":3,"y":3},{"t":0,"x":3,"y":4},{"t":0,"x":4,"y":0},
{"t":0,"x":4,"y":1},{"t":0,"x":4,"y":2},{"t":0,"x":4,"y":3},
{"t":0,"x":4,"y":4}],
"player":[{"turn":false,"user":{"LOGIN_TIME":"Mon Aug 09 15:59:50 ICT 2021",
"PRIVILEGE":{"role":"0,1,2","id":9,"type":"USER"},"IS_SPECTATOR":false,
"PROPERTIES":{},"IP":"N\/A","HOST":"N\/A","NAME":"27a227b0-f8f0-11eb-8588-13f918288bc2",
"IS_PLAYER":true,"IS_LOGEDIN":true,"ZONE_NAME":"ttt_game","IS_CONNECTED":true,
"IS_JOINING":false,"LAST_REQUEST_TIME":"Mon Aug 09 15:59:56 ICT 2021",
"JOIN_ROOM":[4],"PLAYER_ID":1,"ID":"3c22fbfffee6120a-00002826-00000007-0312f68ff1c3bdab-861aa6f5"}}],
"status":0}
 */

import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/repository/repository.dart';

class GameTTTModel {
  List<PositionView> dataViews;

  GameTTTModel(this.dataViews);

  factory GameTTTModel.fromRes(List<PositionRes> lst){
    List<PositionView> temps = lst.map((e) {
      return PositionView(e);
    }).toList();

    return GameTTTModel(temps);
  }

  static List<PositionRes> parseRes(DataPackage data){
    List<PositionRes> lst = data.dataRoadMap().map((e) {
      return PositionRes.fromJson(e);
    }).toList();

    return lst;
  }

}