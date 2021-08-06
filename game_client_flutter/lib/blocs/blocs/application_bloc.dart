import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/exception/exception.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/storage/storage.dart';
import 'package:game_client_flutter/utils/utils.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(InitialApplicationState());

  @override
  Stream<ApplicationState> mapEventToState(ApplicationEvent event) async* {
    try {
      if (event is OnSetupApplication) {
        await Future.wait([
          SharedData().setPreferences(),
        ]);

        ///Get old Theme & Font & Language
        final oldTheme = SharedData().getString(Preferences.theme);
        final oldFont = SharedData().getString(Preferences.font);
        //final oldLanguage = UtilPreferences.getString(Preferences.language);
        final oldDarkOption = SharedData().getString(Preferences.darkOption);

        DarkOption darkOption = DarkOption.dynamic;

        ///Find font support available
        final String? font = AppTheme.fontSupport.firstWhere((item) {
          return item == oldFont;
        }, orElse: () {
          return AppTheme.currentFont;
        });

        ///Find theme support available
        final ThemeModel theme = AppTheme.themeSupport.firstWhere((item) {
          return item.name == oldTheme;
        }, orElse: () {
          return AppTheme.currentTheme;
        });

        ///check old dark option
        if (oldDarkOption != null) {
          switch (oldDarkOption) {
            case DARK_ALWAYS_OFF:
              darkOption = DarkOption.alwaysOff;
              break;
            case DARK_ALWAYS_ON:
              darkOption = DarkOption.alwaysOn;
              break;
            default:
              darkOption = DarkOption.dynamic;
          }
        }

        ///Setup Theme & Font with dark Option
        AppBloc.themeBloc.add(
          OnChangeTheme(
            theme: theme,
            font: font,
            darkOption: darkOption,
          ),
        );

        yield ApplicationCompleted();

        //Add Test
        AppBloc.authBloc.add(OnAuthCheck());

      }
    } catch (ex, stacktrace) {
      UtilLogger.recordError(
          ex,
          stack: stacktrace,
          fatal: true
      );

      if(ex is BaseChatException){
        AppBloc.splashBloc.add(
            SplashScreenEventShowMessage(message: '$ex')
        );
      } else {
        AppBloc.splashBloc.add(SplashScreenEventShowMessage(
            message: AppLanguage().translator(
                LanguageKeys.CONNECT_SERVER_FAILRURE
            ))
        );
      }

    }

  }

}