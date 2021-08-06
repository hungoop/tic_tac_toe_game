import 'package:game_client_flutter/repository/repository.dart';
import 'package:game_client_flutter/utils/utils.dart';

class WebSocketTTTGame {
  static WebSocketTTTGame _webSocketApiNet = new WebSocketTTTGame._internal();
  late WebSocketApi webSocketApi;

  WebSocketTTTGame._internal();

  factory WebSocketTTTGame() => _webSocketApiNet;

  initWebSocketApi(String wsAddress){
    UtilLogger.log('wsAddress', wsAddress);
    webSocketApi = WebSocketApi(wsAddress);
  }

  connectAndLogin(String auth){
    UtilLogger.log('auth', auth);
    webSocketApi.initConnect(auth);
  }

  forcePing(){
    webSocketApi.sendPing();
  }

  forceCheckReConnect({bool isFore = false}) {
    if(isFore){
      webSocketApi.reConnect();
    }
    else {
      webSocketApi.checkOnePingOrRecon();
    }

  }

  destroy() {
    webSocketApi.destroy();
  }

  sendExtData(String cmd, dynamic msg){
    webSocketApi.sendData(cmd, msg);
  }

  void login({
    required String zone,
    required String uname,
    required String upass,
    required Object param
  }){
    webSocketApi.login(zone: zone, uname: uname, upass: upass, param: param);
  }

  void logout() {
    webSocketApi.logout();
  }

  void joinRoom({required int roomId}) {
    webSocketApi.joinRoom(roomId: roomId);
  }

  void createRoom({
    required String roomName,
    int maxPlayer = 10,
    int maxSpectator = 100
  }) {
    webSocketApi.createRoom(
        roomName: roomName,
        maxPlayer: maxPlayer,
        maxSpectator: maxSpectator
    );
  }

  void createOrJoinRoom(
      String roomName, {
        int typeId = -1,
        String? data,
        int maxPlayer = 100,
        int maxSpectator = 100
      }) {
    webSocketApi.createOrJoinRoom(
        roomName,
        data: data,
        typeId: typeId,
        maxPlayer: maxPlayer,
        maxSpectator: maxSpectator
    );
  }

  void leaveRoom({int roomId = -1, String roomName = ""}) {
    webSocketApi.leaveRoom(
        roomId: roomId,
        roomName: roomName
    );
  }

  ////////////////////////////////////////////////////////
  addExtListener(Function callback){
    webSocketApi.addExtListener(callback);
  }
  removeExtListener(Function callback){
    webSocketApi.removeExtListener(callback);
  }
  addSysListener(Function callback){
    webSocketApi.addSysListener(callback);
  }
  removeSysListener(Function callback){
    webSocketApi.removeSysListener(callback);
  }

}