
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/screens/screens.dart';
import 'package:game_client_flutter/utils/utils.dart';

class TabSettingsPage extends StatefulWidget {
  TabSettingsPage({Key? key}) : super(key: key);

  @override
  _TabSettingsPage createState() {
    return _TabSettingsPage();
  }
}

class _TabSettingsPage extends State<TabSettingsPage> {
  late TabSettingBloc _tabSettingBloc;

  @override
  void initState() {
    super.initState();
    _tabSettingBloc = BlocProvider.of<TabSettingBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _showUpdateApp(bool hasNewUpdate) {
    if(hasNewUpdate){
      return AppListTitle(
        border: false,
        icon: Icon(
          Icons.system_update,
          color: Theme.of(context).primaryColor,
        ),
        title: '${AppLanguage().translator(LanguageKeys.APP_VERSION_STR)} (${AppLanguage().translator(AppLanguage().translator(LanguageKeys.CURRENT_LANG))})',
        onPressed: () {
          _tabSettingBloc.add(TabSettingEventNewUpdate());
        },
        trailing: Row(
          children: <Widget>[
            Icon(
              Icons.new_releases_outlined,
              color: Theme.of(context).primaryColor,
              size: Application.SIZE_ICON_NUM_NEW,
            ),
            Text(
              ' 1.0.0',
              style: Theme.of(context).textTheme.caption,
            ),
            RotatedBox(
              quarterTurns: 0,
              child: Icon(
                Icons.keyboard_arrow_right,
                textDirection: TextDirection.ltr,
              ),
            ),
          ],
        ),
      );

    } else {
      return AppListTitle(
        border: false,
        icon: Icon(
          Icons.new_releases_outlined,
          color: Theme.of(context).primaryColor,
        ),
        title: '${AppLanguage().translator(LanguageKeys.APP_VERSION_STR)} (${AppLanguage().translator(LanguageKeys.CURRENT_LANG)})',
        onPressed: () {
          _showUpdateInfo(
              errorMsg: '${AppLanguage().translator(LanguageKeys.NEWEST_VERSION_UPDATED)}'
          );
        },
        trailing: Row(
          children: <Widget>[
            Text(
              '1.0.0',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }
  }

  _showUpdateInfo({required String errorMsg}) {
    final baseDialog = AppAlertDialog (
        title: AppLanguage().translator(AppLanguage().translator(LanguageKeys.APP_TITLE)),
        content: Text(
          errorMsg,
        ),
        yesOnPressed: () {
          if(this.mounted){
            RouteGenerator.maybePop();
          }
        },
        noOnPressed: null,
        txtYes: AppLanguage().translator(LanguageKeys.AGREE_TEXT_ALERT),
        txtNo: AppLanguage().translator(LanguageKeys.CANCEL_TEXT_ALERT)
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  @override
  Widget build(BuildContext context) {
    bool hasNewUpdate = false;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TabSettingBloc, TabSettingState> (
          builder: (context, settingState) {

            hasNewUpdate = false;

            if(settingState is TabSettingStateLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              padding: EdgeInsets.only(top: 8),
              children: <Widget>[
                AppConnectivity(),
                //cai dat giao dien co ban
                AppSettingAppearance(),
                Divider(
                  height: 1,
                  thickness: 2,
                  color: Theme.of(context).dividerColor,
                ),
                AppListTitle(
                  title: AppLanguage().translator(
                      LanguageKeys.SETTING_PERMISSION
                  ),
                  icon: Icon(
                    Icons.perm_device_information_sharp,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: (){
                    UtilPermission.openPermissionAppSettings();
                  },
                  border: false,
                  trailing: Row(
                    children: <Widget>[
                      RotatedBox(
                        quarterTurns: 0,
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    ],
                  ),
                ),
                _showUpdateApp(hasNewUpdate),
              ],
            );
          },
        )
      )
    );
  }

}
