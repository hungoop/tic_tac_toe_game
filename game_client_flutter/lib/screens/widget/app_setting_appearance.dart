import 'package:flutter/material.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/screens/screens.dart';
import 'package:game_client_flutter/utils/utils.dart';

class AppSettingAppearance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppSettingAppearance();
  }

}

class _AppSettingAppearance extends State<AppSettingAppearance> {
  DarkOption darkOption = AppTheme.darkThemeOption;

  ///On Change Dark Option
  void onChangeDarkOption() {
    AppBloc.themeBloc.add(OnChangeTheme(darkOption: darkOption));
  }

  void onNavigate(String route) {
    // TODO rootNavigator: true ?????
    Navigator.of(context, rootNavigator: true).pushNamed(route);
  }

  ///Show notification received
  Future<void> showDarkModeSetting() async {
    setState(() {
      darkOption = AppTheme.darkThemeOption;
    });
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              AppLanguage().translator(LanguageKeys.SETTING_DARK_MODE)
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CheckboxListTile(
                      title: Text(
                          UtilResource.exportLangTheme(DarkOption.dynamic)
                      ),
                      value: darkOption == DarkOption.dynamic,
                      onChanged: (bool? value) {
                        setState(() {
                          darkOption = DarkOption.dynamic;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        UtilResource.exportLangTheme(DarkOption.alwaysOn),
                      ),
                      value: darkOption == DarkOption.alwaysOn,
                      onChanged: (bool? value) {
                        setState(() {
                          darkOption = DarkOption.alwaysOn;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        UtilResource.exportLangTheme(DarkOption.alwaysOff),
                      ),
                      value: darkOption == DarkOption.alwaysOff,
                      onChanged: (bool? value) {
                        setState(() {
                          darkOption = DarkOption.alwaysOff;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            AppButton(
              AppLanguage().translator(LanguageKeys.CANCEL_TEXT_ALERT),
              onPressed: () {
                Navigator.pop(context, false);
              },
              type: ButtonType.outline,
            ),
            AppButton(
              AppLanguage().translator(LanguageKeys.AGREE_TEXT_ALERT),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
    if (result != null && result) {
      onChangeDarkOption();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(
              left: Application.PADDING_ALL,
              right: Application.PADDING_ALL,
              top: Application.PADDING_CHILD_VERTICAL
          ),
          child:  Text(
            'Appearance',
          ),
        ),
        AppListTitle(
          border: false,
          icon: Icon(
            Icons.language_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: AppLanguage().translator(LanguageKeys.SETTING_LANGUAGE),
          onPressed: () {
            onNavigate(ScreenRoutes.CHANGE_LANGUAGE);
          },
          trailing: Row(
            children: <Widget>[
              Text(AppLanguage().translator(LanguageKeys.APP_CURREN_LANGUAGE),
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
        ),
        AppListTitle(
          border: false,
          icon: Icon(
            Icons.color_lens_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: AppLanguage().translator(LanguageKeys.SETTING_THEME),
          onPressed: () {
            onNavigate(ScreenRoutes.THEME_OPTION);
          },
          trailing: Container(
            margin: EdgeInsets.only(right: 8),
            width: 16,
            height: 16,
            color: Theme.of(context).primaryColor,
          ),
        ),
        AppListTitle(
          border: false,
          icon: Icon(
            Icons.nights_stay_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: AppLanguage().translator(LanguageKeys.SETTING_DARK_MODE),
          onPressed: showDarkModeSetting,
          trailing: Row(
            children: <Widget>[
              Text(
                UtilResource.exportLangTheme(AppTheme.darkThemeOption),
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
        ),
        AppListTitle(
          border: false,
          icon: Icon(
            Icons.font_download_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: AppLanguage().translator(LanguageKeys.SETTING_FONT),
          onPressed: () {
            onNavigate(ScreenRoutes.FOND_SETTING);
          },
          trailing: Row(
            children: <Widget>[
              Text(
                AppTheme.currentFont,
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
        ),
        AppListTitle(
          border: false,
          icon: Icon(
            Icons.help_outline,
            color: Theme.of(context).primaryColor,
          ),
          title: AppLanguage().translator(LanguageKeys.HELP_SUPPORT_TEXT),
          onPressed: () {
            Utils.launchUrlToBrowser(urlOpen: "123.com");
          },
          trailing: Row(
            children: <Widget>[
              RotatedBox(
                //quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                quarterTurns: 0,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
        ),


      ],
    );
  }

}