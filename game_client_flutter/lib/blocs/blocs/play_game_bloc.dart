import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/exception/exception.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/repository/repository.dart';
import 'package:game_client_flutter/utils/util_logger.dart';
import 'package:game_client_flutter/utils/utils.dart';

class PlayGameBloc extends Bloc<PlayGameEvent, PlayGameState> {
  late RoomRes? res;
  late UserListModel userListModel;
  late GameTTTModel gameTTTModel;

  PlayGameBloc() : super(PlayGameStateInitial());

  @override
  Stream<PlayGameState> mapEventToState(PlayGameEvent event) async* {
    var currState = state;

    try {
      if(event is PlayGameEventCreate) {
        if(currState is PlayGameStateInitial){
          this.res = RoomRes.newRes(Application.zoneGameName);

          initWSListening();
          createOrJoinRoom();
          userListModel = UserListModel.fromRes([]);
          gameTTTModel = GameTTTModel.fromRes([]);

        }

        yield PlayGameStateSuccess(
            RoomView(res!),
            userListModel.dataViews,
            gameTTTModel.dataViews
        );
      }
      else if(event is PlayGameEventFetched) {
        this.res = event.res;
        if(currState is PlayGameStateInitial){
          initWSListening();
          joinRoom();
          userListModel = UserListModel.fromRes([]);
          gameTTTModel = GameTTTModel.fromRes([]);
        }

        yield PlayGameStateSuccess(
            RoomView(res!),
            userListModel.dataViews,
            gameTTTModel.dataViews
        );
      }
      else if(event is PlayGameEventUserList){
        if(currState is PlayGameStateSuccess){
          userListModel = UserListModel.fromRes(event.lst);

          yield currState.cloneWith(
              userViews: userListModel.dataViews
          );
        }
      }
      else if(event is PlayGameEventRoadMap){
        if(currState is PlayGameStateSuccess){
          gameTTTModel = GameTTTModel.fromRes(event.lst);

          yield currState.cloneWith(
              roadMapViews: gameTTTModel.dataViews
          );
        }
      }
      else if(event is PlayGameEventPosChoose){
        if(currState is PlayGameStateSuccess){
          PositionView posView = event.pos;
          sendPlayGame(posView.res);
        }

      }
    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield PlayGameStateFailure(error: ex.toString());
      }
      else {
        yield PlayGameStateFailure(
            error: AppLanguage().translator(
                LanguageKeys.CONNECT_SERVER_FAILRURE
            )
        );
      }

      UtilLogger.recordError(
          ex,
          stack: stacktrace,
          fatal: true
      );
    }
  }

  @override
  Future<void> close() {
    destroyWSListening();
    leaveRoom();
    return super.close();
  }

  void createOrJoinRoom(){
    Application.chatSocket.createOrJoinRoom(
      res?.rName ?? GUIDGen.generate(),
    );
  }

  void joinRoom(){
    Application.chatSocket.joinRoom(
        roomId: res?.rID ?? -1
    );
  }

  void leaveRoom(){
    Application.chatSocket.leaveRoom(
        roomId: res?.rID ?? -1
    );
  }

  void getUserInRoom(){
    var mes = {};
    mes["ri"] = res?.rID ?? -1;
    Application.chatSocket.sendExtData(
        CMD.USER_IN_ROOM, mes
    );
  }

  void sendPlayGame(PositionRes res){
    var mes = {};
    mes["x"] = res.x;
    mes["y"] = res.y;
    Application.chatSocket.sendExtData(
        CMD.PLAY_GAME, mes
    );
  }

  void initWSListening(){
    Application.chatSocket.addExtListener(_onExtMessageReceived);
    Application.chatSocket.addSysListener(_onSysMessageReceived);
  }

  void destroyWSListening(){
    Application.chatSocket.removeExtListener(_onExtMessageReceived);
    Application.chatSocket.removeSysListener(_onSysMessageReceived);
  }

  _onExtMessageReceived(WsExtensionMessage event) async {
    switch(event.cmd) {
      case CMD.USER_IN_ROOM:{
        DataPackage data = DataPackage.fromJson(event.data);

        if(data.isOK(iSuccess: 0)){
          List<UserRes> lst = UserListModel.parseRes(data);
          this.add(PlayGameEventUserList(lst));
        }
      }
      break;
      case CMD.GAME_DATA:{
        DataPackage data = DataPackage.fromJson(event.data);

        if(data.isOK(iSuccess: 0)){
          //UtilLogger.log('GAME_DATA', '$data');

          List<PositionRes> lst = GameTTTModel.parseRes(data);
          this.add(PlayGameEventRoadMap(lst));
        }
      }
      break;
      default:{
        UtilLogger.log(
            'TTT EXT ${event.cmd}', 'hide data'
        );
      }
    }
  }

  _onSysMessageReceived(WsSystemMessage event) {
    switch(event.cmd) {
      case WsSystemMessage.JOINT_ROOM:{
        UtilLogger.log('JOINT_ROOM ', '${event.data}');
        getUserInRoom();
      }
      break;
      case WsSystemMessage.CREATE_ROOM:{
        UtilLogger.log('CREATE_OR_JOIN_ROOM ', '${event.data}');
        int roomID = event.data['r'];

        UtilLogger.log('roomID ', '$roomID');

        res?.rID = roomID;

        getUserInRoom();
      }
      break;
      case WsSystemMessage.ON_USER_ENTER_ROOM:{
        UtilLogger.log('ON_USER_ENTER_ROOM ', '${event.data}');
        getUserInRoom();

        // TODO : xu ly play  game TTT
      }
      break;
      case WsSystemMessage.ON_ROOM_LOST:{
        UtilLogger.log('ON_ROOM_LOST ', '${event.data}');
        getUserInRoom();
      }
      break;
      case WsSystemMessage.LEAVE_ROOM:{
        UtilLogger.log('LEAVE_ROOM ', '${event.data}');
        getUserInRoom();
      }
      break;
      case WsSystemMessage.ON_USER_LOST:{
        UtilLogger.log('ON_USER_LOST ', '${event.data}');
        getUserInRoom();
      }
      break;
      case WsSystemMessage.ON_USER_LEAVE_ROOM:{
        UtilLogger.log('ON_USER_LEAVE_ROOM ', '${event.data}');
        getUserInRoom();
      }
      break;
      default:{
        UtilLogger.log('TTT SYSTEM ${event.cmd}', '${event.data}');
      }
    }
  }

}