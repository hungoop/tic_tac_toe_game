
/*
  JSONObject jShow = new JSONObject();
		jShow.put("ROOM_ID", getId());
		jShow.put("ROOM_NAME", getName());
		jShow.put("ZONE_NAME", getData().getZone());
		jShow.put("ROOM_MAX_PLAYER", getMaxPlayer());
		jShow.put("ROOM_MAX_SPECTATOR", getMaxSpectators());
		jShow.put("ROOM_USER_COUNT", getUserCount());
		jShow.put("ROOM_IS_ACTIVE", isActive());
		jShow.put("ROOM_IS_EMPTY", isEmpty());
		jShow.put("ROOM_NOTIFY_ENTER_ROOM", isNotifyEnterRoom());
		jShow.put("ROOM_NOTIFY_EXIT_ROOM", isNotifyExitRoom());
		jShow.put("ROOM_NOTIFY_USER_LOST", isNotifyEnterRoom());
*/
import 'dart:convert';

import 'package:game_client_flutter/utils/utils.dart';

class RoomRes {
  int rID;
  String rName;
  String zName;
  int uCount;
  bool isActive;
  int maxSpectator;
  int maxPlayer;

  RoomRes({
    required this.rID,
    required this.rName,
    required this.zName,
    required this.uCount,
    required this.isActive,
    required this.maxPlayer,
    required this.maxSpectator
  });


  factory RoomRes.newRes(String zoneName){
    return RoomRes(
      rID: -1,
      rName: GUIDGen.generate(),
      zName: zoneName,
      uCount: 0,
      isActive: false,
      maxPlayer: 8,
      maxSpectator: 100,
    );
  }

  factory RoomRes.fromJson(dynamic json){
    return RoomRes(
      rID: json["ROOM_ID"],
      rName: json["ROOM_NAME"],
      zName: json["ZONE_NAME"],
      uCount: json["ROOM_USER_COUNT"],
      isActive: json["ROOM_IS_ACTIVE"],
      maxPlayer: json["ROOM_MAX_PLAYER"],
      maxSpectator: json["ROOM_MAX_SPECTATOR"],
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map['ROOM_ID'] = this.rID;
    map['ROOM_NAME'] = this.rName;
    map['ZONE_NAME'] = this.zName;
    map['ROOM_USER_COUNT'] = this.uCount;
    map['ROOM_IS_ACTIVE'] = this.isActive;
    map['ROOM_MAX_PLAYER'] = this.maxPlayer;
    map['ROOM_MAX_SPECTATOR'] = this.maxSpectator;
    return map;
  }
  
  @override
  String toString() {
    return jsonEncode(toJson());
  }

}