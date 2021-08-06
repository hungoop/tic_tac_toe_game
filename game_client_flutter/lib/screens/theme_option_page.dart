
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/screens/screens.dart';

class ThemeOptionPage extends StatefulWidget {
  ThemeOptionPage({Key? key}) : super(key: key);

  @override
  _ThemeOptionPageState createState() {
    return _ThemeOptionPageState();
  }
}

class _ThemeOptionPageState extends State<ThemeOptionPage> {
  ThemeModel currentTheme = AppTheme.currentTheme;

  ///On Change Theme
  void onChange() {
    AppBloc.themeBloc.add(OnChangeTheme(theme: currentTheme));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
        AppLanguage().translator(LanguageKeys.SETTING_THEME),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                itemBuilder: (context, index) {
                  Widget selected = Container();
                  final item = AppTheme.themeSupport[index];
                  if (item.name == currentTheme.name) {
                    selected = Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      setState(() {
                        currentTheme = item;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 24,
                                  height: 24,
                                  color: item.color,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                ),
                                Text(
                                  item.name,
                                  style: Theme.of(context).textTheme.subtitle2,
                                )
                              ],
                            ),
                            selected,
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: AppTheme.themeSupport.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 15,
                bottom: 15,
              ),
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
