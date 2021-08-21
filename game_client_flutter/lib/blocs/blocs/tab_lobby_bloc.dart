import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/exception/exception.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/repository/repository.dart';
import 'package:game_client_flutter/utils/utils.dart';

class TabLobbyBloc extends Bloc<TabLobbyEvent, TabLobbyState> {
  late RoomListModel roomListModel;

  TabLobbyBloc() : super(TabLobbyStateInitial());

  @override
  Stream<TabLobbyState> mapEventToState(TabLobbyEvent event) async* {
    var currState = state;

    try {
      if(event is TabLobbyEventFetched) {
        if(currState is TabLobbyStateInitial){
          initWSListening();
          roomListModel = RoomListModel.fromRes([]);
        }
      }
      else if(event is TabLobbyEventRoomList){
        roomListModel = RoomListModel.fromRes(event.lst);

        yield TabLobbyStateSuccess(roomListModel.dataViews);
      }
      else if(event is TabLobbyEventJoinRoom){
        if(currState is TabLobbyStateSuccess){
          if(event.isAccept) {
            RouteGenerator.pushNamed(
                ScreenRoutes.JOIN_GAME,
                arguments: event.res
            );
          }

          if(currState is TabLobbyStateConfirm){
            yield TabLobbyStateSuccess(
                roomListModel.dataViews
            );
          }
        }

      }
      else if(event is TabLobbyEventCreateRoom){
        if(currState is TabLobbyStateSuccess){
          //Application.chatSocket.createOrJoinRoom(
          //    GUIDGen.generate(),
          //);
          RouteGenerator.pushNamed(
              ScreenRoutes.CREATE_GAME,
          );
        }
      }
      else if(event is TabLobbyEventInvitedJoin){
        if(currState is TabLobbyStateSuccess){
          yield TabLobbyStateConfirm(
              roomListModel.dataViews,
              event.res
          );
        }
      }

    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield TabLobbyStateFailure(error: ex.toString());
      }
      else {
        yield TabLobbyStateFailure(
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
    return super.close();
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
      case CMD.ROOM_LIST:{
        DataPackage data = DataPackage.fromJson(event.data);

        if(data.isOK(iSuccess: 0)){
          List<RoomRes> lst = RoomListModel.parseRes(data);

          this.add(TabLobbyEventRoomList(lst));
        }
      }
      break;
      case CMD.INVITE_FRIEND:{
        DataPackage data = DataPackage.fromJson(event.data);

        if(data.isOK(iSuccess: 0)){
          UtilLogger.log('INVITE_FRIEND', '$data');

          RoomRes res = RoomRes.fromJson(data.dataToJson());
          this.add(TabLobbyEventInvitedJoin(res));
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
      default:{
        //UtilLogger.log('TTT SYSTEM ${event.cmd}', '${event.data}');
      }
    }
  }

}