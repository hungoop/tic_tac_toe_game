
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/screens/screens.dart';

class SplashPage extends StatefulWidget {

  const SplashPage();

  @override
  State<StatefulWidget> createState() {
    return _SplashPage();
  }

}

class _SplashPage extends State<SplashPage> {

  late SplashScreenBloc _splashScreenBloc;

  @override
  void initState() {
    super.initState();

    _splashScreenBloc = BlocProvider.of<SplashScreenBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashScreenBloc, SplashScreenState>(
        builder: (context, ssState){

          if (ssState is SplashScreenStateShowMessage) {
            return _showMessage(ssState);
          }

          if (ssState is SplashScreenStateNewUpdate) {
            return _showNewUpdate(ssState);
          }

          if (ssState is SplashScreenStateDownloading) {
            return Center(
              child: Text(
                  '${AppLanguage().translator(LanguageKeys.DOWNLOADING)}: ${ssState.value}'
              ),
            );
          }

          return Center(
            child: Text(
              AppLanguage().translator(LanguageKeys.LOADING_DATA)
            ),
          );
        },
      )
    );
  }

  _showNewUpdate(SplashScreenStateNewUpdate splashState){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(Application.PADDING_ALL),
            child: Text(
              '${AppLanguage().translator(LanguageKeys.NEW_VERSION_UPDATE)}',
              style: TextStyle(
                fontSize: Application.FONT_SIZE_NORMAL,
              ),
              maxLines: 10,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Application.PADDING_ALL),
            child: _controlUpdatePress(),
          )
        ],
      ),
    );
  }

  _showMessage(SplashScreenStateShowMessage splashState){
    return AppErrorAutoRenew(
      splashState.message,
      onPressRenew: (){
        AppBloc.applicationBloc.add(OnSetupApplication());
      },
    );
  }

  _controlUpdatePress(){
    //TODO test
    bool hasForceUpdate = false;
    if(hasForceUpdate){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonTheme(
            height: Application.SIZE_ICON_VOICE_CALL,
            child: RaisedButton(
              color: Theme.of(context).buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(Application.HEIGHT_BUTTON_LOGIN)
              ),
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(
                    Icons.download_rounded,
                    color: Application.COLOR_ICON_ACTIVE,
                    size: Application.SIZE_ICON_CHAT_BOX,
                  ),
                  Text(
                      AppLanguage().translator(LanguageKeys.AGREE_TEXT_ALERT),
                      style: TextStyle(
                        color: Application.COLOR_TEXT_LIGHT,
                        fontSize: Application.FONT_SIZE_SMALL,
                      ))
                ],
              ),
              onPressed: () {
                _splashScreenBloc.add(SplashScreenEventDownloadConfirm());
              },
            ),
          ),
        ],
      );
    }
    else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonTheme(
            height: Application.SIZE_ICON_VOICE_CALL,
            child: RaisedButton(
              color: Theme.of(context).buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(Application.HEIGHT_BUTTON_LOGIN)),
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(
                    Icons.download_rounded,
                    color: Application.COLOR_ICON_ACTIVE,
                    size: Application.SIZE_ICON_CHAT_BOX,
                  ),
                  Text(AppLanguage().translator(LanguageKeys.AGREE_TEXT_ALERT),
                      style: TextStyle(
                        color: Application.COLOR_TEXT_LIGHT,
                        fontSize: Application.FONT_SIZE_SMALL,
                      ))
                ],
              ),
              onPressed: () {
                _splashScreenBloc.add(SplashScreenEventDownloadConfirm());
              },
            ),
          ),
          ButtonTheme(
            height: Application.SIZE_ICON_VOICE_CALL,
            child: RaisedButton(
              color: Theme.of(context).buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(Application.HEIGHT_BUTTON_LOGIN)),
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Application.COLOR_ICON_DEACTIVE,
                    size: Application.SIZE_ICON_CHAT_BOX,
                  ),
                  Text(
                      AppLanguage().translator(LanguageKeys.CANCEL_TEXT_ALERT),
                      style: TextStyle(
                        color: Application.COLOR_TEXT_LIGHT,
                        fontSize: Application.FONT_SIZE_SMALL,
                      ))
                ],
              ),
              onPressed: () {
                _splashScreenBloc.add(SplashScreenEventGotoLogin());
              },
            ),
          )
        ],
      );
    }

  }

}