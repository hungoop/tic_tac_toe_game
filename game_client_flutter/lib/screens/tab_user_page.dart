import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/screens/screens.dart';

class TabUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabUserPage();
  }

}

class _TabUserPage extends State<TabUserPage> {
  late TabUserBloc _tabUserBloc;

  @override
  void initState() {
    _tabUserBloc = BlocProvider.of<TabUserBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TabUserBloc, TabUserState> (
            builder: (context, userState) {
              List<UserView> dataViews = [];

              if(userState is TabUserStateSuccess){
                dataViews = userState.views;
              }

              return Column(
                children: [
                  AppConnectivity(),
                  if(dataViews.isEmpty)...[
                    Center(
                      child: Text(
                          'User - data not found!'
                      ),
                    )
                  ],
                  if(dataViews.isNotEmpty)...[
                    Expanded(
                        child:
                        ListView.builder(
                          itemBuilder: (BuildContext buildContext, int index){
                            if (index >= dataViews.length) {
                              return Center(
                                child: Text(AppLanguage().translator(LanguageKeys.LOADING_DATA)),
                              );
                            } else {
                              UserView bif = dataViews[index];
                              return _createUserItem(bif);
                            }
                          },
                          itemCount: dataViews.length,
                        )
                    )
                  ]
                ],
              );

            }),
      ),
    );

  }

  Widget _createUserItem(UserView view){
    return AppListTitle(
      title: view.title(),
      subtitle: view.subTitle(),
      onPressed: (){
        _tabUserBloc.add(TabUserEventJoinRoom(view.res));
      },
    );
  }

}