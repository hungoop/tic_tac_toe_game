import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/screens/screens.dart';
import 'package:game_client_flutter/storage/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await SharedData().setPreferences();

  //runZonedGuarded(() {
    runApp(EasyLocalization(
      startLocale: AppLanguage.defaultLocale,
      supportedLocales: AppLanguage.supportLanguage,
      path: 'assets/translations',
      //useOnlyLangCode: true,
      fallbackLocale: AppLanguage.defaultLocale, // AppLanguage.getSupportLocale(AppLanguage.defaultLocale),
      child: TTTApp2(),
    ));
  //}, FirebaseCrashlytics.instance.recordError);
}
