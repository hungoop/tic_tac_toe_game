
import 'dart:convert';
import 'package:game_client_flutter/repository/repository.dart';

class RtcPackage {
  static const String OFFER = "offer";
  static const String ANSWER = "answer";
  static const String CANDIDATE = "candidate";
  static const String LEAVE = "leave";
  static const String STOP = "stop";
  static const String HANDSHAKE = "handshake";

  String vSID;
  int chatID;
  int? from;
  int? to;
  int? receiver;
  String? tokenStr;
  String? sessionId;
  String? media;
  String? reason;
  dynamic rtcData;

  String action;

  RtcPackage(
      this.action,
      this.vSID,
      this.chatID, {
        this.from,
        this.to,
        this.receiver,
        this.tokenStr,
        this.sessionId,
        this.media,
        this.reason,
        this.rtcData
  });

  factory RtcPackage.fromWS(WsExtensionMessage event){
    return RtcPackage.fromJson(event.cmd, event.getPackage().data);
  }

  factory RtcPackage.fromJson(String cmd, dynamic jsonData){
    dynamic rtc;
    if(cmd == CANDIDATE){
      rtc = jsonData["candidate"];
    }
    else {
      rtc = jsonData["description"];
    }

    return RtcPackage(
        cmd,
        jsonData["vSID"],
        jsonData["chatID"],
        from: jsonData["from"],
        to: jsonData["to"]['chatID'] ?? jsonData["to"]['accID'],
        receiver: jsonData["receiver"],
        tokenStr: jsonData["token"],
        sessionId: jsonData["sessionID"],
        media: jsonData["media"],
        reason: jsonData["reason"],
        rtcData: rtc,
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json["action"] = this.action;
    json["vSID"] = this.vSID;
    json["chatID"] = this.chatID;
    json["from"] = this.from;
    json["to"] = this.to;
    json["receiver"] = this.receiver;
    json["token"] = this.tokenStr;
    json["sessionID"] = this.sessionId;
    json["media"] = this.media;
    json["reason"] = this.reason;
    //json["rtcData"] = jsonEncode(rtcData);

    return json;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  bool checkSameChatID(int curChatID){
    return this.chatID == curChatID;
  }

  bool checkSameVSID(String curVSID){
    return this.vSID == curVSID;
  }

}