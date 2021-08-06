
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/screens/screens.dart';
import 'package:game_client_flutter/utils/util_logger.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:easy_localization/easy_localization.dart';

class TTTApp2 extends StatefulWidget {

  const TTTApp2({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LvChatApp();
  }

}

class _LvChatApp extends State<TTTApp2> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    AppBloc.applicationBloc.add(OnSetupApplication());
    AppBloc.applicationBloc.add(OnInitWSListening());

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    //FCMNotification().registerNotification();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    AppBloc.connectivityBloc.add(ConnectivityEventConnect(result: result));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: BlocBuilder<LanguageBloc, LanguageState> (
        builder: (context, lang) {
          if(lang is LanguageUpdated) {
            print('LanguageUpdated languageCode =>> ${AppLanguage.defaultLocale.languageCode}');
            print('LanguageUpdated countryCode =>> ${AppLanguage.defaultLocale.countryCode}');
            //TODO : AppLanguage.defaultLocale No support is error

            //EasyLocalization.of(context).locale = AppLanguage.defaultLocale;
          }
            return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, theme) {
                  return BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, auth) {
                      UtilLogger.log('AuthBloc', '$auth');

                      return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        theme: AppTheme.lightTheme,
                        darkTheme: AppTheme.darkTheme,
                        navigatorKey: RouteGenerator.navigatorKey,
                        localizationsDelegates: _localizationsDelegates(
                            context.localizationDelegates
                        ),
                        supportedLocales: context.supportedLocales,
                        locale:  AppLanguage.defaultLocale,//AppLanguage.getSupportLocale(AppLanguage.defaultLocale),
                        title: AppLanguage().translator(LanguageKeys.APP_TITLE),
                        onGenerateRoute: RouteGenerator.generateRoute,
                        localeResolutionCallback: (locale, supportedLocales) {
                          print('locale:$locale, $supportedLocales');

                          for (var supportedLocale in supportedLocales) {
                            print(
                                'locale.languageCode:${locale?.languageCode},'
                                ' supportedLocale.languageCode:${supportedLocale.languageCode}'
                            );

                            print(
                                'locale.countryCode:${locale?.countryCode},'
                                ' supportedLocale.countryCode:${supportedLocale.countryCode}'
                            );

                            if (locale != null && locale.languageCode.contains(supportedLocale.languageCode)) {
                              print('supportedLocale locale:$locale');

                              return supportedLocale;
                            }
                          }

                          print('defaultLocale locale:${supportedLocales.last}');
                          return supportedLocales.last;
                          //return AppLanguage.defaultLanguage;
                        },

                        home: BlocBuilder<ApplicationBloc, ApplicationState>(
                          builder: (context, application) {
                            if (application is ApplicationCompleted) {
                              if (auth is AuthenticationFail) {
                                return LoginPage();
                              }
                              if (auth is AuthenticationSuccess) {
                                return BottomNavigation();
                              }
                            }
                            return SplashPage();
                          },
                        ),

                      );
                    },
                  );
                }
            );
        }
      )
    );
  }
}

_localizationsDelegates(List<LocalizationsDelegate> lst) {
  lst.add(CountryLocalizations.delegate);
  return lst;
}

