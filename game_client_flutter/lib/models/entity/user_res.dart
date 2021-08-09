
/*
    json.put("ID", getId());
		json.put("NAME", getName());
		json.put("SESSION_ID", getSessionToken());
		json.put("PLAYER_ID", getPlayerId());
		json.put("IP", getIpAddress());
		json.put("HOST", getHostName());
		json.put("JOIN_ROOM", getJoinedRooms());
		json.put("LOGIN_TIME", new Date(getLoginTime()));
		json.put("LAST_REQUEST_TIME", new Date(getLastRequestTime()));
		json.put("IS_CONNECTED", isConnected());
		json.put("IS_JOINING", isJoining());
		json.put("IS_LOGEDIN", isLoggedIn());
		json.put("IS_PLAYER", isPlayer());
		json.put("IS_SPECTATOR", isSpectator());
		json.put("ZONE_NAME", getZoneName());
		json.put("PRIVILEGE", getPrivilege());
		json.put("PROPERTIES", toProString());
 */

import 'dart:convert';

class UserRes {
  String uID;
  String uName;
  String sessionID;
  int playerID;
  List<dynamic> joinRoons;
  bool isConnected;
  bool isJoining;
  bool isLoggedIn;
  Map<String, dynamic> property;

  UserRes({
    required this.uID,
    required this.uName,
    required this.sessionID,
    required this.playerID,
    required this.joinRoons,
    required this.isConnected,
    required this.isJoining,
    required this.isLoggedIn,
    required this.property
  });

  factory UserRes.fromJson(dynamic json){
    return UserRes(
      uID: json["ID"],
      uName: json["NAME"],
      sessionID: json["SESSION_ID"] ?? "n/a",
      playerID: json["PLAYER_ID"],
      joinRoons: json["JOIN_ROOM"],
      isConnected: json["IS_CONNECTED"],
      isJoining: json["IS_JOINING"],
      isLoggedIn: json["IS_LOGEDIN"],
      property: json["PROPERTIES"],
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map['ID'] = this.uID;
    map['NAME'] = this.uName;
    map['SESSION_ID'] = this.sessionID;
    map['PLAYER_ID'] = this.playerID;
    map['JOIN_ROOM'] = this.joinRoons;
    map['IS_CONNECTED'] = this.isConnected;
    map['IS_JOINING'] = this.isJoining;
    map['IS_LOGEDIN'] = this.isLoggedIn;
    map['PROPERTIES'] = this.property;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}