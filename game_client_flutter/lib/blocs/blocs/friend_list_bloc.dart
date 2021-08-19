import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/exception/exception.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/repository/repository.dart';
import 'package:game_client_flutter/utils/utils.dart';

class FriendListBloc extends Bloc<FriendListEvent, FriendListState> {
  late UserListModel friendListModel;
  final RoomRes roomRes;

  FriendListBloc(this.roomRes) : super(FriendListStateInitial());

  @override
  Stream<FriendListState> mapEventToState(FriendListEvent event) async* {
    var currState = state;

    try {
      if(event is FriendListEventFetched) {
        if(currState is FriendListStateInitial){
          initWSListening();
          friendListModel = UserListModel.fromRes([]);

          getUserInRoom();
        }
      }
      else if(event is FriendListEventUserList){
        friendListModel = UserListModel.fromRes(event.lst);

        yield FriendListStateSuccess(friendListModel.dataViews);
      }
      else if(event is FriendListEventSelected){
        if(currState is FriendListStateSuccess){
          UserRes userRes = event.res;
          friendListModel.updateSelected(userRes);

          yield currState.cloneWith(
            views: friendListModel.dataViews,
            countSelected: friendListModel.countSelected()
          );
        }

      }
      else if(event is FriendListEventInviteJoins){
        if(currState is FriendListStateSuccess){
          if(friendListModel.friendsSelected().isNotEmpty){
            inviteJoinGame();
          }
          RouteGenerator.pop();
        }
      }

    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield FriendListStateFailure(error: ex.toString());
      }
      else {
        yield FriendListStateFailure(
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

  void getUserInRoom(){
    var mes = {};
    mes["ri"] = roomRes.rID;
    Application.chatSocket.sendExtData(
        CMD.USER_IN_ROOM, mes
    );
  }

  void inviteJoinGame(){
    var mes = {};
    mes["ri"] = roomRes.rID;
    mes["fs"] = friendListModel.idsSelected();
    Application.chatSocket.sendExtData(
        CMD.INVITE_FRIEND, mes
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

          this.add(FriendListEventUserList(lst));
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