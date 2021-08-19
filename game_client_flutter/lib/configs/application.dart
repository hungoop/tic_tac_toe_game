import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:game_client_flutter/repository/repository.dart';

class Application {
  static const bool IS_ActiveTest                     = false;
  static const bool IS_LOCAL                          = true;
  static final WebSocketTTTGame chatSocket            = WebSocketTTTGame();

  static String addressWsServer                   = 'ws://192.168.1.5:8722';
  static String zoneGameName                      = 'ttt_game';

  static String timeZoneName                      = DateTime.now().timeZoneName;
  static int delayTimeConnectFailCall             = 30;
  static int delayTimeCloseScreenCall             = 2;
  static int delayTimePingReconnectWS             = 60;
  static const int NUM_OF_PAGE                    = 20;

  static const int MAX_MEMBER_CALL                = 4;

  static const double FONT_SIZE_BIG               = 25.0;
  static const double FONT_SIZE_NORMAL            = 20.0;
  static const double FONT_SIZE_SMALL             = 16.0;
  static const double FONT_SIZE_MICRO             = 14.0;
  static const double FONT_SIZE_TIME_CHAT         = 10.0;

  static const double PADDING_ITEM_CHAT           = 8.0;
  static const double PADDING_ALL                 = 20.0;
  static const double PADDING_FRIEND_HEIGHT       = 30.0;
  static const double PADDING_CHILD_VERTICAL      = 10.0;

  static const Color COLOR_TEXT_DARK              = Color(0xff707070);
  static const Color COLOR_TEXT_USER_CHAT         = Colors.redAccent;
  static const Color COLOR_TEXT_LIGHT             = Colors.white;

  static const double HEIGHT_BUTTON_LOGIN         = 45.0;
  static const double BORDER_RADIUS_BUTTON        = 32.0;
  static const double BORDER_RADIUS_CHAT_BOX      = 10.0;

  static const int DELAY_TIME_MILI               = 200;

  static const double SIZE_ICON_EDIT_TEXT        = 20.0;
  static const double SIZE_ICON_ON_AVATAR        = 15.0;
  static const double SIZE_ICON_PROFILE          = 20.0;
  static const double SIZE_SHARE_CONTACT_BTN     = 30.0;

  static const Color COLOR_ICON_ACTIVE           = Colors.black;
  static const Color COLOR_ICON_DEACTIVE         = Colors.black38;
  static const Color COLOR_ICON_NUM_NEW          = Colors.redAccent;

  static const double SIZE_ICON_NUM_NEW          = 20.0;
  static const double SIZE_ICON_NUM_WAITING      = 15.0;

  static const double PADDING_CHILD_PROFILE      = 5;
  static const int DURATION_SNACKBAR             = 5;

  static const double SIZE_ICON_AVATAR           = 60.0;
  static const double SIZE_ICON_VOICE_CALL       = 50.0;
  static const double SIZE_ICON_AVATAR_SMALL     = 40.0;

  static const double SIZE_ICON_CHAT_BOX         = 25.0;
  static const double SIZE_BUTTON_CHAT_BOX       = 40.0;

  static const int DEBOUNCE_TIME_FETCH_DATA      = 300;

  static const int MAX_PLAYER_ROOM               = 30;
  static const int MAX_SPECTATOR_ROOM            = 300;

  static const int MAX_PLAYER_FRIEND             = 2;
  static const int MAX_SPECTATOR_FRIEND          = 2;

  static const double DIVIDER_HEIGHT             = 10;
  static const double DIVIDER_THICKNESS          = 2;

  static const int TIME_TIMEOUT_NOTIFICATION     = 8000;

  static const double COUNTRY_FLAG_WITH          = 28;
  static const List<String> COUNTRY_FAVORITE     = ['+84','+86','+886'];

  static const double CONTROL_PLAYER_VOICE_WITH  = 200;
  static const int MAX_TIME_RECORD_VOICE         = 60;

  static const String QR_CODE_COLOR_CODE         = "#ff6666";

  static const double QR_CODE_LOGIN_WITH_HEIGHT  = 150.0;

  static const SizedBox SPACE_HEIGHT             = SizedBox(height: 20.0);
  static const SizedBox SPACE_WIDTH              = SizedBox(width: 30.0);

  static const double WIDTH_SCREEN               = 800;
  static const double APPBAR_HEIGHT              = 60;

  static const int FILTER_MSG_PAGE_SIZE          = 30;
  static const int FILTER_MSG_SHORT_PAGE_SIZE    = 5;

  static const double MAX_FILE_SIZE_UPLOAD       = 100;//MB
  static const double THUMB_VIDEO_HEIGHT         = 100;

  // Toggle this to cause an async error to be thrown during initialization
  // and to test that runZonedGuarded() catches the error
  static const kShouldTestAsyncErrorOnInit       = false;

  // Toggle this for testing Crashlytics in your app locally.
  static const kTestingCrashlytics               = true;
  static const int NUMBER_ACCOUNT_SAVE           = 4;
  static const double BOX_HEIGHT_SWITCH_ACCOUNT  = 265;

}