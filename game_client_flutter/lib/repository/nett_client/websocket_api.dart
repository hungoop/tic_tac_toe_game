import 'dart:async';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/repository/nett_client/nett_socket_client.dart';
import 'package:game_client_flutter/repository/repository.dart';

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
    addExtListener(_onExtMessageReceived);

    _authData = authData;
    String urlAndData = '$_serverAddress?$_authData';
    client.initAndConnect(serverAddress: urlAndData);
    pingServer();
  }

  reConnect({String? authData}){
    _authData = authData ?? _authData;

    String urlAndData = '$_serverAddress?$_authData';
    client.initAndConnect(serverAddress: urlAndData);

    _isNextReconnect = false;
  }

  sendData(String cmd, dynamic data) {
    client?.sendExtension(cmd, data);
  }

  destroy() {
    client?.closeConnect();
    timerStick?.cancel();
    timerStick = null;

    removeExtListener(_onExtMessageReceived);
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
  _onExtMessageReceived(WsExtensionMessage event) async {
    switch(event.cmd) {
      //case WsExtensionMessage.:{
      //  _isNextReconnect = false;
      //}
      //break;
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
    client?.pingServer();
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