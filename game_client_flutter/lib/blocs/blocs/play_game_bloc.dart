import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/exception/exception.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/utils/util_logger.dart';

class PlayGameBloc extends Bloc<PlayGameEvent, PlayGameState> {
  RoomRes res;

  PlayGameBloc(this.res) : super(PlayGameStateInitial());

  @override
  Stream<PlayGameState> mapEventToState(PlayGameEvent event) async* {
    var currState = state;

    try {
      if(event is PlayGameEventFetched) {
        yield PlayGameStateSuccess(
            RoomView(res)
        );
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

}