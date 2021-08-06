import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/exception/exception.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/utils/utils.dart';

class TabGameBloc extends Bloc<TabGameEvent, TabGameState> {

  TabGameBloc() : super(TabGameStateInitial());

  @override
  Stream<TabGameState> mapEventToState(TabGameEvent event) async* {
    var currState = state;

    try {
      if(event is TabGameEventFetched) {

      }

    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield TabGameStateFailure(error: ex.toString());
      } else {
        yield TabGameStateFailure(
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