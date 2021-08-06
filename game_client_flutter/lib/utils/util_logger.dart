
import 'dart:developer' as developer;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/utils/utils.dart';

class UtilLogger {
  static const String TAG = "TTT_GAME";

  static log([String tag = TAG, dynamic msg]) {
    if (Application.IS_LOCAL) {
      if(Utils.isWeb()){
        print('$tag:$msg');
      } else {
        //developer.log('$msg', name: tag);
        print('$tag:$msg');
      }
    }
  }

  ///Singleton factory
  static final UtilLogger _instance = UtilLogger._internal();

  factory UtilLogger() {
    return _instance;
  }

  static setUserIdentifier(String logUUID){
    FirebaseCrashlytics.instance.setUserIdentifier(logUUID);
  }

  static logLive64([String tag = TAG, dynamic msg]){
    // To avoid slowing down your app,
    // Crashlytics limits logs to 64kB and deletes
    // older log entries when a session's logs go over that limit.
    FirebaseCrashlytics.instance.log('$tag, $msg');
  }

  static recordError(
      dynamic exception, {
        StackTrace? stack,
        dynamic reason,
        Iterable<DiagnosticsNode> information = const [],
        bool? printDetails,
        bool fatal = false
      }
  ) async{
    await FirebaseCrashlytics.instance.recordError(
        exception,
        stack,
        reason: reason,
        information: information,
        printDetails: printDetails,
        fatal: fatal);
  }

  UtilLogger._internal();
}
