import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/exception/exception.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/repository/repository.dart';
import 'package:game_client_flutter/utils/utils.dart';

class TabUserBloc extends Bloc<TabUserEvent, TabUserState> {
  late UserListModel userListModel;

  TabUserBloc() : super(TabUserStateInitial());

  @override
  Stream<TabUserState> mapEventToState(TabUserEvent event) async* {
    var currState = state;

    try {
      if(event is TabUserEventFetched) {
        if(currState is TabUserStateInitial){
          initWSListening();
          userListModel = UserListModel.fromRes([]);
        }
      }
      else if(event is TabUserEventUserList){
        userListModel = UserListModel.fromRes(event.lst);

        yield TabUserStateSuccess(userListModel.dataViews);
      }
      else if(event is TabUserEventJoinRoom){
        if(currState is TabLobbyStateSuccess){
          RouteGenerator.pushNamed(
              ScreenRoutes.PLAY_GAME,
              arguments: event.res
          );
        }

      }

    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield TabUserStateFailure(error: ex.toString());
      } else {
        yield TabUserStateFailure(
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
      case CMD.USER_LIST:{
        DataPackage data = DataPackage.fromJson(event.data);

        if(data.isOK(iSuccess: 0)){
          List<UserRes> lst = UserListModel.parseRes(data);

          this.add(TabUserEventUserList(lst));
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