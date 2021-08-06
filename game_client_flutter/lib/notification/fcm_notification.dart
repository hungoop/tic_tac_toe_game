
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:game_client_flutter/utils/utils.dart';

Future<void> _backgroundHandlerNotificationFCM(RemoteMessage message) async {
  UtilLogger.log('backgroundNotificationFCM onMessage ', '$message');
  UtilLogger.log('backgroundNotificationFCM notification ', '${message.notification}');
  UtilLogger.log('backgroundNotificationFCM data ', '${message.data}');
  print("Handling a background message: ${message.messageId}");

}

class FCMNotification {
  static FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static String? _tokenFCM;

  Future<void> deleteTokenFCM() async {
    try {
      UtilLogger.log('deleteTokenFCM', 'deleteTokenFCM');

      return await _messaging.deleteToken();
    } catch (ex, stacktrace) {
      UtilLogger.recordError(
          ex,
          stack: stacktrace,
          fatal: true
      );

      return Future.value();
    }

  }

  Future<String?> getTokenFCM() async {
    if(_tokenFCM == null){
      _tokenFCM = await _messaging.getToken();
    }
    return _tokenFCM;
  }

  Future<String?> setLogUser() async {
    String? token = await FCMNotification().getTokenFCM();
    UtilLogger.setUserIdentifier(token ?? "");
    UtilLogger.log('FirebaseMessaging Token', '$token');
    print('$token');
    return token;
  }

  void registerNotification() async {
    setLogUser();

    FirebaseMessaging.onBackgroundMessage(_backgroundHandlerNotificationFCM);
    
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        UtilLogger.log('FirebaseMessaging onMessage ', '$message');
        UtilLogger.log('FirebaseMessaging notification ', '${message.notification}');
        UtilLogger.log('FirebaseMessaging data ', '${message.data}');

        UtilLogger.log('FirebaseMessaging notification?.title ', '${message.notification?.title}');
        UtilLogger.log('FirebaseMessaging notification?.body ', '${message.notification?.body}');
        UtilLogger.log('FirebaseMessaging messageId.hashCode ', '${message.messageId?.hashCode}');

      });
    }
    else {
      print('User declined or has not accepted permission');
    }

    _messaging.onTokenRefresh.listen((event) {
      UtilLogger.log('messaging.onTokenRefresh', '$event');
      getTokenFCM();
    });

  }

  ///Singleton factory
  static final FCMNotification _instance = FCMNotification._internal();

  factory FCMNotification() {
    return _instance;
  }

  FCMNotification._internal();

}