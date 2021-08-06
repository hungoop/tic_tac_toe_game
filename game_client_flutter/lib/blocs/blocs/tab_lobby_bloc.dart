import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/exception/exception.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/utils/utils.dart';

class TabLobbyBloc extends Bloc<TabLobbyEvent, TabLobbyState> {

  TabLobbyBloc() : super(TabLobbyStateInitial());

  @override
  Stream<TabLobbyState> mapEventToState(TabLobbyEvent event) async* {
    var currState = state;

    try {
      if(event is TabLobbyEventFetched) {
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

}