
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/screens/screens.dart';

class FontSettingPage extends StatefulWidget {
  FontSettingPage({Key? key}) : super(key: key);

  @override
  _FontSettingPageState createState() {
    return _FontSettingPageState();
  }
}

class _FontSettingPageState extends State<FontSettingPage> {
  String currentFont = AppTheme.currentFont;

  ///On change Font
  Future<void> onChange() async {
    AppBloc.themeBloc.add(OnChangeTheme(font: currentFont));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
        AppLanguage().translator(LanguageKeys.SETTING_FONT)
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(left: 16, top: 8),
                itemBuilder: (context, index) {
                  Widget trailing = SizedBox();
                  final item = AppTheme.fontSupport[index];
                  if (item == currentFont) {
                    trailing = Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    );
                  }
                  return AppListTitle(
                    title: item,
                    trailing: trailing,
                    onPressed: () {
                      setState(() {
                        currentFont = item;
                      });
                    },
                  );
                },
                itemCount: AppTheme.fontSupport.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, theme) {
                  return AppButton(
                      AppLanguage().translator(LanguageKeys.AGREE_TEXT_ALERT),
                    onPressed: onChange,
                    loading: theme is ThemeUpdating,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
