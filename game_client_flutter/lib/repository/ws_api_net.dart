import 'package:game_client_flutter/repository/repository.dart';
import 'package:game_client_flutter/utils/utils.dart';

class WebSocketApiNet {
  static WebSocketApiNet _webSocketApiNet = new WebSocketApiNet._internal();
  late WebSocketApi webSocketApi;

  WebSocketApiNet._internal();

  factory WebSocketApiNet() => _webSocketApiNet;

  initWebSocketApi(String wsAddress){
    UtilLogger.log('wsAddress', wsAddress);
    webSocketApi = WebSocketApi(wsAddress);
  }

  connectAndLogin(String auth){
    UtilLogger.log('auth', auth);
    webSocketApi?.initConnect(auth);
  }

  forcePing(){
    webSocketApi?.sendPing();
  }

  forceCheckReConnect({bool isFore = false}) {
    if(isFore){
      webSocketApi?.reConnect();
    }
    else {
      webSocketApi?.checkOnePingOrRecon();
    }

  }

  destroy() {
    webSocketApi?.destroy();
  }

  sendChatMSG(String cmd, dynamic msg){
    webSocketApi?.sendData(cmd, msg);
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