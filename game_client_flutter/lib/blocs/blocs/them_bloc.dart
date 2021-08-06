import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/storage/storage.dart';
import 'package:game_client_flutter/utils/utils.dart';

const DARK_DYNAMIC = 'dynamic';
const DARK_ALWAYS_OFF = 'off';
const DARK_ALWAYS_ON = 'on';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(InitialThemeState());

  @override
  Stream<ThemeState> mapEventToState(event) async* {
    ///Update theme style and font
    try {
      if (event is OnChangeTheme) {
        yield ThemeUpdating();

        AppTheme.currentTheme = event.theme ?? AppTheme.currentTheme;
        AppTheme.currentFont = event.font ?? AppTheme.currentFont;
        AppTheme.darkThemeOption = event.darkOption ?? AppTheme.darkThemeOption;

        ///Setup Theme with setting darkOption
        switch (AppTheme.darkThemeOption) {
          case DarkOption.dynamic:
            AppTheme.lightTheme = CollectionTheme.getCollectionTheme(
              theme: AppTheme.currentTheme.lightTheme,
              font: AppTheme.currentFont,
            );
            AppTheme.darkTheme = CollectionTheme.getCollectionTheme(
              theme: AppTheme.currentTheme.darkTheme,
              font: AppTheme.currentFont,
            );
            break;
          case DarkOption.alwaysOn:
            AppTheme.lightTheme = CollectionTheme.getCollectionTheme(
              theme: AppTheme.currentTheme.darkTheme,
              font: AppTheme.currentFont,
            );
            AppTheme.darkTheme = CollectionTheme.getCollectionTheme(
              theme: AppTheme.currentTheme.darkTheme,
              font: AppTheme.currentFont,
            );
            break;
          case DarkOption.alwaysOff:
            AppTheme.lightTheme = CollectionTheme.getCollectionTheme(
              theme: AppTheme.currentTheme.lightTheme,
              font: AppTheme.currentFont,
            );
            AppTheme.darkTheme = CollectionTheme.getCollectionTheme(
              theme: AppTheme.currentTheme.lightTheme,
              font: AppTheme.currentFont,
            );
            break;
          default:
            AppTheme.lightTheme = CollectionTheme.getCollectionTheme(
              theme: AppTheme.currentTheme.lightTheme,
              font: AppTheme.currentFont,
            );
            AppTheme.darkTheme = CollectionTheme.getCollectionTheme(
              theme: AppTheme.currentTheme.darkTheme,
              font: AppTheme.currentFont,
            );
            break;
        }

        ///Preference save
        SharedData().setString(Preferences.theme, AppTheme.currentTheme.name);

        ///Preference save
        SharedData().setString(Preferences.font, AppTheme.currentFont);

        ///Preference save
        switch (AppTheme.darkThemeOption) {
          case DarkOption.dynamic:
            SharedData().setString(Preferences.darkOption, DARK_DYNAMIC);
            break;
          case DarkOption.alwaysOn:
            SharedData().setString(Preferences.darkOption, DARK_ALWAYS_ON);
            break;
          case DarkOption.alwaysOff:
            SharedData().setString(Preferences.darkOption, DARK_ALWAYS_OFF);
            break;
          default:
            break;
        }

        ///Notification UI
        yield ThemeUpdated();
      }
    } catch (ex, stacktrace) {
      UtilLogger.recordError(
          ex,
          stack: stacktrace,
          fatal: true
      );
    }

  }
}