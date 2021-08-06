
import 'package:flutter/material.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/screens/screens.dart';
import 'package:game_client_flutter/utils/utils.dart';

class LanguageOptionPage extends StatefulWidget {
  LanguageOptionPage({Key? key}) : super(key: key);

  @override
  _LanguageOptionPageState createState() {
    return _LanguageOptionPageState();
  }
}

class _LanguageOptionPageState extends State<LanguageOptionPage> {
  final textLanguageController = TextEditingController();

  List<Locale> listLanguage = AppLanguage.supportLanguage;
  Locale languageSelected = AppLanguage.defaultLocale;

  ///On filter language
  void onFilter(String text) {
    if (text.isEmpty) {
      setState(() {
        listLanguage = AppLanguage.supportLanguage;
      });
      return;
    }
    setState(() {
      listLanguage = listLanguage.where(((item) {
        return UtilResource.getGlobalLanguageName(
            item.languageCode,
            item.countryCode ?? "VN"
        )
            .toUpperCase()
            .contains(text.toUpperCase());
      })).toList();
    });
  }

  ///On change language
  Future<void> changeLanguage() async {
    UtilOther.hiddenKeyboard(context);
    AppBloc.languageBloc.add(OnChangeLanguage(languageSelected));
  }

  @override
  Widget build(BuildContext context) {
    var isTWLang=false;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            AppLanguage().translator(LanguageKeys.CHANGE_LANGUAGE_TEXT)),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
              child: AppTextInput(
                labelText: AppLanguage().translator(LanguageKeys.SETTING_LANGUAGE),
                hintText: AppLanguage().translator(
                    LanguageKeys.SEARCH_BOX_TEXT
                ),
                controller: textLanguageController,
                maxLines: 1,
                onChanged: onFilter,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(left: 16),
                itemBuilder: (context, index) {
                  Widget trailing = SizedBox();
                  final item = listLanguage[index];
                  if (item.countryCode != null) {
                    if(item.countryCode ==languageSelected.countryCode) {
                      isTWLang = true;
                      trailing = Icon(
                        Icons.check,
                        color: Theme
                            .of(context)
                            .primaryColor,
                      );
                    }
                  }
                  else if (item.countryCode == null) {
                     if(item.languageCode.toUpperCase() == languageSelected.languageCode.toUpperCase() && !isTWLang) {
                       trailing = Icon(
                         Icons.check,
                         color: Theme
                             .of(context)
                             .primaryColor,);
                     }
                  }
                  return AppListTitle(
                    title: UtilResource.getGlobalLanguageName(
                        item.languageCode,
                        item.countryCode ?? 'VN'
                    ),
                    trailing: trailing,
                    onPressed: () {
                      setState(() {
                        languageSelected = item;
                      });
                    },
                  );
                },
                itemCount: listLanguage.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: AppButton(
                AppLanguage().translator(LanguageKeys.AGREE_TEXT_ALERT),
                onPressed: () async {
                  //changeLanguage();
                  AppBloc.languageBloc.add(OnChangeLanguage(languageSelected));
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
