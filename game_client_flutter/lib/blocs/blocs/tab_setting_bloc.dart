
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/exception/base_chat_exception.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/utils/utils.dart';

class TabSettingBloc extends Bloc<TabSettingEvent, TabSettingState> {

  TabSettingBloc() : super(TabSettingStateInitial());

  @override
  Stream<TabSettingState> mapEventToState(TabSettingEvent event) async* {
    var currState = state;

    try {
      if(event is TabSettingEventFetched) {

        yield TabSettingStateSuccess([]);
      }
      else if (event is TabSettingEventRefresh){
        yield TabSettingStateSuccess([]);
      }
      else if (event is TabSettingEventNewUpdate) {
        //TODO
        UtilLogger.log('NewUpdate', 'NewUpdate checking');

        RouteGenerator.pushNamedAndRemoveUntil(
            ScreenRoutes.DOWNLOAD_UPDATE,
            (route) => false
        );
      }
      else if (event is TabSettingEventServiceNotify){
        UtilPreferences().saveAllowNotify(!event.isRun);
        yield TabSettingStateSuccess([]);

      }

    } catch (ex, stacktrace) {
      if(ex is BaseChatException){
        yield TabSettingStateFailure(error: ex.toString());
      }
      else {
        yield TabSettingStateFailure(
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