import 'dart:async';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/repository/nett_client/nett_socket_client.dart';
import 'package:game_client_flutter/repository/repository.dart';
import 'package:game_client_flutter/utils/utils.dart';

class WebSocketApi {
  static final WebSocketApi _webSocketApi = WebSocketApi._internal();

  Timer? timerStick;
  bool _lock = false;
  String? _serverAddress;
  String? _authData;

  NettSocketClient client;

  bool _isNextReconnect = false;

  WebSocketApi._internal():client = NettSocketClient();

  factory WebSocketApi(String wsAddress) {
    assert(!_webSocketApi._lock, "ERROR_MY_CLIENT");
    _webSocketApi._serverAddress = wsAddress;
    _webSocketApi._lock = true;

    return _webSocketApi;
  }

  initConnect(String authData) {
    addSysListener(_onExtSystemReceived);

    _authData = authData;
    String urlAndData = '$_serverAddress?$_authData';
    client.initAndConnect(serverAddress: urlAndData);
    pingServer();
  }

  reConnect({String? authData}){
    _authData = authData ?? _authData;

    String urlAndData = '$_serverAddress?$_authData';
    client.reConnect(serverAddress: urlAndData);

    _isNextReconnect = false;
  }

  sendData(String cmd, dynamic data) {
    client.sendExtension(cmd, data);
  }

  void login({
    required String zone,
    required String uname,
    required String upass,
    required Object param
  }){
    client.login(zone: zone, uname: uname, upass: upass, param: param);
  }

  void logout() {
    client.logout();
  }

  void joinRoom({required int roomId}) {
    client.joinRoom(roomId: roomId);
  }

  void createRoom({
    required String roomName,
    int maxPlayer = 100,
    int maxSpectator = 100
  }) {
    client.createRoom(
        roomName: roomName,
        maxPlayer: maxPlayer,
        maxSpectator: maxSpectator
    );
  }

  void createOrJoinRoom(
      String roomName,
      {
        int typeId = -1,
        String? data,
        int maxPlayer = 100,
        int maxSpectator = 100
  }) {
    client.createOrJoinRoom(
      roomName,
      data: data,
      typeId: typeId,
      maxPlayer: maxPlayer,
      maxSpectator: maxSpectator
    );
  }

  void leaveRoom({int roomId = -1, String roomName = ""}) {
    client.leaveRoom(
      roomId: roomId,
      roomName: roomName
    );
  }

  destroy() {
    client.closeConnect();
    timerStick?.cancel();
    timerStick = null;

    removeSysListener(_onExtSystemReceived);
  }

  ////////////////////////////////////////////////////////
  addExtListener(Function callback){
    client.addExtListener(callback);
  }
  removeExtListener(Function callback){
    client.removeExtListener(callback);
  }
  addSysListener(Function callback){
    client.addSysListener(callback);
  }
  removeSysListener(Function callback){
    client.removeSysListener(callback);
  }

  //TODO : xu ly bat co reconnect lai cho server Nett
  // xu lý ở onSystemMessageReceived
  _onExtSystemReceived(WsSystemMessage event) async {
    switch(event.cmd) {
      case WsSystemMessage.ON_USER_PING:{
        _isNextReconnect = false;
      }
      break;
      default:{}
    }

  }

  checkOnePingOrRecon(){
    if (_isNextReconnect) {
      reConnect();
    } else {
      sendPing();
    }
  }

  sendPing(){
    _isNextReconnect = true;
    client.pingServer(key: GUIDGen.generate());
  }

  pingServer() {
    timerStick = timerStick ?? Timer.periodic(
        Duration(seconds: Application.delayTimePingReconnectWS),
        (timer) {
          print("${Application.delayTimePingReconnectWS} sec client?.ping(), _isNextReconnect: $_isNextReconnect");

          if (_isNextReconnect) {
            reConnect();
          } else {
            sendPing();
          }
        }
    );
  }

  @override
  String toString() {
    return '_isNextReconnect: $_isNextReconnect'
        ', _serverAddress:$_serverAddress'
        ', __authData:$_authData';
  }
}