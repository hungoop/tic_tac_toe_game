
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/exception/exception.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/utils/utils.dart';
import 'package:ota_update/ota_update.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {

  SplashScreenBloc() : super(SplashScreenStateInitial());

  @override
  Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) async* {
      var ssState = state;

      try {
        if(event is SplashScreenEventGotoLogin){
          RouteGenerator.pushNamedAndRemoveUntil(
              ScreenRoutes.LOGIN, (route) => false
          );
        }
        else if(event is SplashScreenEventShowMessage){
          yield SplashScreenStateShowMessage(message: event.message);
        }
        else if(event is SplashScreenEventNewUpdate){

          yield SplashScreenStateNewUpdate();
        }
        else if(event is SplashScreenEventDownloadConfirm){
          yield SplashScreenStateFlash();
          if(Utils.isIOS()){
            tryIOSUpdate(
                urlPlist: 'urlVersionLatest'
            );
          } else if(Utils.isAndroid()) {
            tryAndroidUpdate(
                urlApk: 'urlDownloadFileUpdate'
            );
          }
        }
        else if(event is SplashScreenEventUpdateStatus){
          if(event.status == OtaStatus.DOWNLOADING){
            yield SplashScreenStateDownloading(value: event.value);
          }
          else if(event.status == OtaStatus.INSTALLING){
            Future.delayed(const Duration(milliseconds: 2000), () {
              if(Utils.isIOS()){
                exit(0);
              } else {
                SystemNavigator.pop();
              }
            });
          }
          else {
            yield SplashScreenStateShowMessage(message: _mappingStatusToLanguage( event.status));
          }
        }

      } catch (ex, stacktrace) {
        if(ex is BaseChatException){
          yield SplashScreenStateShowMessage(message: ex.toString());
        } else {
          yield SplashScreenStateShowMessage(
              message: AppLanguage().translator(LanguageKeys.SOMETHING_FAILRURE)
          );
        }

        UtilLogger.recordError(
            ex,
            stack: stacktrace,
            fatal: true
        );
      }

  }

  String _mappingStatusToLanguage(OtaStatus status){
    if(status == OtaStatus.DOWNLOADING){
      return AppLanguage().translator(LanguageKeys.DOWNLOADING);
    }
    else if (status == OtaStatus.ALREADY_RUNNING_ERROR) {
      return AppLanguage().translator(LanguageKeys.ALREADY_RUNNING_ERROR);
    }
    else if (status == OtaStatus.CHECKSUM_ERROR) {
      return AppLanguage().translator(LanguageKeys.CHECKSUM_ERROR);
    }
    else if (status == OtaStatus.DOWNLOAD_ERROR) {
      return AppLanguage().translator(LanguageKeys.DOWNLOAD_ERROR);
    }
    else if (status == OtaStatus.INSTALLING) {
      return "";//Languages.INSTALLING;
    }
    else if (status == OtaStatus.INTERNAL_ERROR) {
      return AppLanguage().translator(LanguageKeys.INTERNAL_ERROR);
    }
    else if (status == OtaStatus.PERMISSION_NOT_GRANTED_ERROR) {
      return AppLanguage().translator(LanguageKeys.PERMISSION_NOT_GRANTED_ERROR);
    } else {
      return AppLanguage().translator(LanguageKeys.ProcessFail);
    }
  }

  Future<void> tryIOSUpdate({required String urlPlist}) async {
    try {
      UtilLogger.log('tryIOSUpdate', '$urlPlist');
      Utils.launchUrlUpdateIOS(urlPlist: urlPlist);
      this.add(SplashScreenEventUpdateStatus(status: OtaStatus.INSTALLING, value: "100"));
    } catch (e) {
      print('IOS update. Details: $e');
      throw e;
    }

  }

  Future<void> tryAndroidUpdate({required String urlApk}) async {
    try {
      UtilLogger.log('tryAndroidUpdate', '$urlApk');
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
      OtaUpdate().execute(
        urlApk,
        destinationFilename: 'ttt_game_app.apk',
        //FOR NOW ANDROID ONLY - ABILITY TO VALIDATE CHECKSUM OF FILE:
        //sha256checksum: "d6da28451a1e15cf7a75f2c3f151befad3b80ad0bb232ab15c20897e54f21478",
      ).listen((OtaEvent event) {
        this.add(SplashScreenEventUpdateStatus(
            status: event.status,
            value: event.value ?? "")
        );
      },);
    } catch (e, st) {
      print('Failed to make OTA update. Details: $e, $st');
      throw e;
    }
  }

}