
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/screens/friend_list_page.dart';
import 'package:game_client_flutter/screens/play_ttt_game_page.dart';
import 'package:game_client_flutter/screens/screens.dart';
import 'package:game_client_flutter/utils/utils.dart';

class RouteGenerator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static String currRouteScreen        = "";

  static bool voipRunning               = false;

  static void updateVoipRunning(bool val){
    voipRunning = val;
  }

  static Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) async {
    if(navigatorKey.currentState != null){
      await navigatorKey.currentState!.pushReplacementNamed(
          routeName, arguments: arguments
      );
    }
  }

  static Future<dynamic> pushNamedAndRemoveUntil(String newRouteName,
        RoutePredicate predicate,
        {Object? arguments}
      ) async {

    if(navigatorKey.currentState != null){
      await navigatorKey.currentState!.pushNamedAndRemoveUntil(
          newRouteName,
          predicate,
          arguments: arguments
      );
    }

  }

  static Future<void> pushNamed(String routeName, {Object? arguments}) async {
    if(navigatorKey.currentState != null){
      await navigatorKey.currentState!.pushNamed(
          routeName,
          arguments: arguments
      );
    }

  }

  static void pop(){
    if(navigatorKey.currentState != null){
      navigatorKey.currentState!.pop();
    }
  }

  static Future<bool?> maybePop() async {
    if(navigatorKey.currentState != null){
      return await navigatorKey.currentState!.maybePop("1");
    }
  }

  static void maybePopUntil(String screenShow) {
    if(navigatorKey.currentState != null && navigatorKey.currentState!.canPop()){
      navigatorKey.currentState!.popUntil(
              (Route<dynamic> route) {
                UtilLogger.log('maybePopUntil ==>> ', '$route');
                return route.settings.name == screenShow;
              }
      );
    }
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.LOGIN: {
        return MaterialPageRoute(
            settings: settings,
            builder: (_){
              return LoginPage();
            }
        );
      }
      case ScreenRoutes.THEME_OPTION: {
        return MaterialPageRoute(
            settings: settings,
            builder: (_){
              return ThemeOptionPage();
            }
        );
      }
      case ScreenRoutes.FOND_SETTING: {
        return MaterialPageRoute(
            settings: settings,
            builder: (_){
              return FontSettingPage();
            }
        );
      }
      case ScreenRoutes.CHANGE_LANGUAGE: {
        return MaterialPageRoute(
            settings: settings,
            builder: (_){
              return LanguageOptionPage();
            }
        );
      }
      case ScreenRoutes.JOIN_GAME: {
        var res = settings.arguments;
        if(res is RoomRes){
          return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              return BlocProvider<PlayGameBloc>(
                create: (context) {
                  return PlayGameBloc()
                    ..add(PlayGameEventFetched(res));
                },
                child: PlayTTTGamePage(),
              );
            });
        }

        return _errorRoute(settings);
      }
      case ScreenRoutes.CREATE_GAME: {
        return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              return BlocProvider<PlayGameBloc>(
                create: (context) {
                  return PlayGameBloc()
                    ..add(PlayGameEventCreate());
                },
                child: PlayTTTGamePage(),
              );
            }
          );
      }
      case ScreenRoutes.FRIEND_LIST: {
        var res = settings.arguments;
        if(res is RoomRes){
          return MaterialPageRoute(
              settings: settings,
              builder: (_) {
                return BlocProvider<FriendListBloc>(
                  create: (context) {
                    return FriendListBloc(res)
                      ..add(FriendListEventFetched());
                  },
                  child: FriendListPage(),
                );
              });
        }

        return _errorRoute(settings);
      }
      default:
        return _errorRoute(settings);
    }

  }

  static Route<dynamic> _errorRoute(RouteSettings settings){
    UtilLogger.recordError(
        settings,
        reason: 'errorRoute, DATA input open  screen is null or wrong'
    );

    return MaterialPageRoute(
    settings: settings,
      builder: (_) {
        return  BlocProvider<SplashScreenBloc> (
          create: (context) {
            return SplashScreenBloc()..add(
                SplashScreenEventShowMessage(
                    message: '${AppLanguage().translator(
                        LanguageKeys.ERROR_DATA_INPUT_WRONG
                    )}, ${settings.name}'
                )
            );
          },
          child: SplashPage(),
        );
      }
    );
  }

  static bool isScreen(String routeName){
    if (currRouteScreen == routeName){
      return true;
    }
    return false;
  }

  static Widget? currentWidget(){
    return navigatorKey.currentWidget;
  }

  static void toPrint() {
    UtilLogger.log('currentContext', '${navigatorKey.currentContext}');
    UtilLogger.log('currentWidget', '${currentWidget()}');
    UtilLogger.log('currentState', '${navigatorKey.currentState}');
    UtilLogger.log('currRouteScreen', '$currRouteScreen');
  }

}