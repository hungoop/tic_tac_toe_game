
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:game_client_flutter/exception/exception.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/repository/repository.dart';
import 'package:game_client_flutter/utils/utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const String CONTROLLER_KEY    = "cid";
const String REQUEST_KEY       = "rid";
const String MESSAGE_KEY       = "mes";

class NettSocketClient {
  ObserverList<Function> _extListeners = new ObserverList<Function>();
  ObserverList<Function> _sysListeners = new ObserverList<Function>();

  //------------------Observer handler ext message------------------//
  addExtListener(Function callback){
    if(!_extListeners.contains(callback)){
      _extListeners.add(callback);
    }

  }
  removeExtListener(Function callback){
    if(_extListeners.contains(callback)){
      _extListeners.remove(callback);
    }
  }
  _onReceptionOfExtMessageFromServer(WsExtensionMessage message){
    _extListeners.forEach((Function extCallback){
      extCallback(message);
    });
  }
  //------------------Observer handler ext message------------------//
  addSysListener(Function callback){
    if(!_sysListeners.contains(callback)){
      _sysListeners.add(callback);
    }
  }
  removeSysListener(Function callback){
    if(_sysListeners.contains(callback)){
      _sysListeners.remove(callback);
    }
  }
  _onReceptionOfSysMessageFromServer(WsSystemMessage message){
    _sysListeners.forEach((Function sysCallback){
      sysCallback(message);
    });
  }

  ////////////////////////////////////////////////////////////////////
  static const COMMAND_KEY       = "c";
  static const EXT_DATA_KEY      = "p";
  static const ERROR_CODE_KEY    = "ec";
  static const ERROR_CONTENT_KEY = "ep";

  static const CID_SYSTEM        = 0;
  static const CID_EXTEND        = 1;

  var socket;

  NettSocketClient();

  void initAndConnect({required String serverAddress}) {
    if(socket != null){
      closeConnect();
      socket = null;
    }

    if(!Utils.checkDataEmpty(serverAddress)){
      print('$serverAddress');
      socket = WebSocketChannel.connect(
          Uri.parse(serverAddress)
      );
    }
    else {
      throw WebsocketException(
          LanguageKeys.WS_INIT_FAILURE
      );
    }
    socket.stream.listen((dynamic message) {
          receiveMessage(message);
        },
        onDone: () {
          print('=>>IOWebSocket onDone=>>');

          _onReceptionOfSysMessageFromServer(
              WsSystemMessage(cmd: WsSystemMessage.ON_CLIENT_DONE, data: "OK")
          );
        },
        onError: (dynamic error) {
          print('=>>IOWebSocket onError=>> $error');

          _onReceptionOfSysMessageFromServer(
              WsSystemMessage(
                  cmd: WsSystemMessage.ON_CLIENT_ERROR,
                  data: LanguageKeys.WS_REQ_FAILURE
              )
          );
        },
    );

  }

  void reConnect({required String serverAddress}) {
    initAndConnect(serverAddress: serverAddress);

    print('SYSTEM CLIENT => RECONNECT NOTIFY => OK');
    _onReceptionOfSysMessageFromServer(
        WsSystemMessage(
            cmd: WsSystemMessage.ON_RECONNECT,
            data: 'OK'
        )
    );
  }

  void login({required String zone, required String uname, required String upass, required Object param}){
    var mes = {};
    mes["un"] = uname;
    mes["pw"] = upass;
    mes["zn"] = zone;
    mes["ld"] = param;

    this._sendSys(WsSystemMessage.LOGIN, mes);
  }
  void logout() {
    this._sendSys(WsSystemMessage.LOGOUT, {});
  }
  void joinRoom({required int roomId}) {
    var mes = {};
    mes["i"] = roomId;
    mes["f"] = true;

    this._sendSys(WsSystemMessage.JOINT_ROOM, mes);
  }
  void createRoom({required String roomName, int maxPlayer = 100, int maxSpectator = 100}) {
    var mes = {};
    mes["n"] = roomName;
    mes["mu"] = maxPlayer;
    mes["ms"] = maxSpectator;

    this._sendSys(WsSystemMessage.CREATE_ROOM, mes);
  }

  void createOrJoinRoom(
      String roomName,
      {int typeId = -1,
        String? data,
        int maxPlayer = 100,
        int maxSpectator = 100
      }
  ) {
    var mes = {};
    mes["n"] = roomName;
    mes["mu"] = maxPlayer;
    mes["ms"] = maxSpectator;

    if(typeId != -1){
      mes["t"] = typeId;
    }

    if(!Utils.checkDataEmpty(data)){
      mes["d"] = data;
    }

    this._sendSys(WsSystemMessage.CREATE_OR_JOIN_ROOM, mes);
  }

  void leaveRoom({int roomId = -1, String roomName = ""}) {
    var mes = {};
    if(roomId != -1){
      mes["r"] = roomId;
    } else if (roomName != ""){
      mes["n"] = roomName;
    }
    this._sendSys(WsSystemMessage.LEAVE_ROOM, mes);
  }

  void pingServer({dynamic key = 0}){
    var mes = {};
    mes["p"] = key;
    this._sendSys(WsSystemMessage.ON_USER_PING, mes);
  }

  void sendExtension(command, data) {
    this._sendExt(command, data);
  }

  void _sendExt(String cmd, Object mes){
    var mesExt = {};
    mesExt[COMMAND_KEY] = cmd;
    mesExt[EXT_DATA_KEY] = mes;

    JMsg jo = JMsg(
        cid:CID_EXTEND,
        rid:WsSystemMessage.EXTENSION,
        data:json.encode(mesExt));

    this._sendMessage(jo.toJson());
  }

  void _sendSys(int id, Object mes){
    JMsg jo = JMsg(
        cid:CID_SYSTEM,
        rid:id,
        data:json.encode(mes));

    this._sendMessage(jo.toJson());
  }

  void _sendMessage(String msg){
    if(socket != null){
      try{
        //UtilLogger.log('_sendMessage', '$msg');
        socket.sink.add(msg);
      }
      catch (ex, st){
        UtilLogger.recordError(
            ex,
            stack: st
        );
        //print('-sendMesage-> $ex');
      }
    }
  }

  void receiveMessage(message){
    if (socket != null) {
      var obj = json.decode(message);

      final int controllerId = (obj[CONTROLLER_KEY]);
      final int requestId = (obj[REQUEST_KEY]);
      final content = obj[MESSAGE_KEY];

      if (controllerId == CID_SYSTEM) {
        this.internalMessageHandler(rId: requestId, data: content);
      }
      else if (controllerId == CID_EXTEND) {
        final cmd = content[COMMAND_KEY];
        final jObject = content[EXT_DATA_KEY];
        this.extensionMessageHandler(command: cmd, data:  jObject);
      }
      else {
        print("CONTROLLER NOT SUPPORT.");
      }
    }
  }

  void closeConnect(){
    // TODO  ko clear all kieu nay dc.
    //_extListeners = new ObserverList<Function>();
    //_sysListeners = new ObserverList<Function>();

    // TODO: neu disconnect - thuc hien re connect
    // toàn bộ màn hình ko thay đổi, remove chổ này
    // logic sẽ sai, do các Callback của các màn hình đã bị remove
    /*
    _extListeners.forEach((Function extCallback) {
        _extListeners.remove(extCallback);
      }
    );

    _sysListeners.forEach((Function extCallback) {
        _sysListeners.remove(extCallback);
      }
    );*/

    if(socket != null && socket.sink != null){
      socket.sink.close();
    }
  }

  /////////////////////////////////////
  //  SERVER RESPONSE
  /////////////////////////////////////
  void internalMessageHandler({required int rId, dynamic data}) {
    try {
      switch (rId) {
        case WsSystemMessage.ON_USER_PING: {
          print('SYSTEM CLIENT => ON_USER_PING => $data');

          _onReceptionOfSysMessageFromServer(
              WsSystemMessage(
                  cmd: WsSystemMessage.ON_USER_PING,
                  data: data["p"]
              )
          );
        }
        break;
        case WsSystemMessage.LOGIN: {
          if (data[ERROR_CONTENT_KEY] != null) {
            print('SYSTEM CLIENT => LOGIN_FAIL => $data[$ERROR_CONTENT_KEY], $data');

            _onReceptionOfSysMessageFromServer(
                WsSystemMessage(
                    cmd: WsSystemMessage.LOGIN,
                    data: data[ERROR_CONTENT_KEY]
                )
            );
          }
          else {
            print('SYSTEM CLIENT => LOGIN_SUCCESS => $data');
            _onReceptionOfSysMessageFromServer(
                WsSystemMessage(
                    cmd: WsSystemMessage.LOGIN,
                    data: 'OK'
                )
            );
          }
        }
        break;
        case WsSystemMessage.LOGOUT: {
          print('SYSTEM CLIENT => LOGOUT => $data');
          _onReceptionOfSysMessageFromServer(
              WsSystemMessage(
                  cmd: WsSystemMessage.LOGOUT,
                  data: data
              )
          );
        }
        break;
        case WsSystemMessage.CREATE_ROOM: {
          print('SYSTEM CLIENT => CREATE_ROOM => $data');
          _onReceptionOfSysMessageFromServer(
              WsSystemMessage(
                  cmd: WsSystemMessage.CREATE_ROOM,
                  data: data
              )
          );
        }
        break;
        case WsSystemMessage.JOINT_ROOM: {
          print('SYSTEM CLIENT => JOINT_ROOM => $data');
          _onReceptionOfSysMessageFromServer(
              WsSystemMessage(
                  cmd: WsSystemMessage.JOINT_ROOM,
                  data: data
              )
          );
        }
        break;
        case WsSystemMessage.LEAVE_ROOM: {
          print('SYSTEM CLIENT => LEAVE_ROOM => $data');
          _onReceptionOfSysMessageFromServer(
              WsSystemMessage(
                  cmd: WsSystemMessage.LEAVE_ROOM,
                  data: data
              )
          );
        }
        break;
        case WsSystemMessage.ON_ROOM_LOST: {
          print('SYSTEM CLIENT => ON_ROOM_LOST => $data');
          _onReceptionOfSysMessageFromServer(
              WsSystemMessage(
                  cmd: WsSystemMessage.ON_ROOM_LOST,
                  data: data
              )
          );
        }
        break;
        case WsSystemMessage.ON_USER_LOST: {
          print('SYSTEM CLIENT => ON_USER_LOST => $data');
          _onReceptionOfSysMessageFromServer(
              WsSystemMessage(
                  cmd: WsSystemMessage.ON_USER_LOST,
                  data: data
              )
          );
        }
        break;
        case WsSystemMessage.ON_USER_ENTER_ROOM: {
          print('SYSTEM CLIENT => ON_USER_ENTER_ROOM => $data');
          _onReceptionOfSysMessageFromServer(
              WsSystemMessage(
                  cmd: WsSystemMessage.ON_USER_ENTER_ROOM,
                  data: data
              )
          );
        }
        break;
        case WsSystemMessage.ON_USER_LEAVE_ROOM: {
          print('SYSTEM CLIENT => ON_USER_LEAVE_ROOM => $data');
          _onReceptionOfSysMessageFromServer(
              WsSystemMessage(
                  cmd: WsSystemMessage.ON_USER_LEAVE_ROOM,
                  data: data
              )
          );
        }
        break;
        default: {
          print('SYSTEM SOCKET CLIENT no handle - $rId - $data');
        }
        break;
      }
    } catch (ex) {
      print('$ex');
    }
  }

  void extensionMessageHandler({required String command, dynamic data}) {
    try {
      _onReceptionOfExtMessageFromServer(
          WsExtensionMessage(cmd: command, data: data)
      );
    } catch (ex) {
      print('$ex');
    }
  }

}

class JMsg {
  int cid = -1;
  int rid = -1;
  String data = "";

  JMsg({required this.cid, required this.rid, required this.data});

  String toJson() {
    var obj = {};
    obj[CONTROLLER_KEY] = cid;
    obj[REQUEST_KEY] = rid;
    obj[MESSAGE_KEY] = data;
    return json.encode(obj);
  }

  String toString() {
    var rs = "";
    rs += " controllerId: " + this.cid.toString() + "\r\n";
    rs += " requestId: " + this.rid.toString() + "\r\n";
    rs += " content: " + this.data.toString();
    return rs;
  }
}

enum ROOM_TYPE {
  GAME,
  STREAMING,
  LOBBY,
  CHAT,
  VOICE
}

extension ROOM_TYPE_EXT on ROOM_TYPE {
  int roomTypeId(ROOM_TYPE key) {
    switch (key) {
      case ROOM_TYPE.GAME: {
        return 0;
      }
      break;
      case ROOM_TYPE.STREAMING: {
        return 1;
      }
      break;
      case ROOM_TYPE.LOBBY: {
        return 10;
      }
      break;
      case ROOM_TYPE.CHAT: {
        return 11;
      }
      break;
      case ROOM_TYPE.VOICE: {
        return 12;
      }
      break;
      default:{
        return 0;
      }
      break;
    }
  }

  String roomTypeName(ROOM_TYPE key) {
    switch (key) {
      case ROOM_TYPE.GAME: {
        return "GAME";
      }
      break;
      case ROOM_TYPE.STREAMING: {
        return "STREAMING";
      }
      break;
      case ROOM_TYPE.LOBBY: {
        return "LOBBY";
      }
      break;
      case ROOM_TYPE.CHAT: {
        return "CHAT";
      }
      break;
      case ROOM_TYPE.VOICE: {
        return "VOICE";
      }
      break;
      default:{
        return "";
      }
      break;
    }
  }

  String getName(){
    return roomTypeName(this);
  }

  int getId(){
    return roomTypeId(this);
  }
}
