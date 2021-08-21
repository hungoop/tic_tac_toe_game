import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/screens/screens.dart';

class TabLobbyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabLobbyPage();
  }

}

class _TabLobbyPage extends State<TabLobbyPage> {
  late TabLobbyBloc _lobbyBloc;
  
  @override
  void initState() {
    super.initState();

    _lobbyBloc = BlocProvider.of<TabLobbyBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenuPage(),
      appBar: AppBar(
        title: Text('Lobby'),
      ),
      body: SafeArea(
        child: BlocBuilder<TabLobbyBloc, TabLobbyState> (
            builder: (context, lobbyState) {
              List<RoomView> dataViews = [];

              if(lobbyState is TabLobbyStateConfirm){
                dataViews = lobbyState.views;
                RoomRes res = lobbyState.res;

                Future.delayed(Duration(milliseconds: 1000),(){
                  _confirmJoinGame(
                      errorMsg: 'You invated join game ${res.rName}',
                      roomRes: res
                  );
                });
              }

              if(lobbyState is TabLobbyStateSuccess){
                dataViews = lobbyState.views;
              }

              return Column(
                children: [
                  AppConnectivity(),
                  if(dataViews.isEmpty)...[
                    Center(
                      child: Text(
                          'data not found!'
                      ),
                    )
                  ],
                  if(dataViews.isNotEmpty)...[
                    Expanded(
                      child: ListView.builder(
                          itemBuilder: (BuildContext buildContext, int index){
                            if (index >= dataViews.length) {
                              return Center(
                                child: Text(AppLanguage().translator(LanguageKeys.LOADING_DATA)),
                              );
                            } else {
                              RoomView bif = dataViews[index];
                              return _createRoomItem(bif);
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _lobbyBloc.add(TabLobbyEventCreateRoom());
        },
        tooltip: 'Add',
        mini: true,
        child: Icon(
          Icons.add,
          //size: Application.SIZE_ICON_VOICE_CALL,
          color: AppTheme.currentTheme.color,
        ),
      ),
    );
  }

  Widget _createRoomItem(RoomView view){
    return AppListTitle(
        title: view.title(),
        subtitle: view.subTitle(),
        onPressed: (){
          _lobbyBloc.add(
              TabLobbyEventJoinRoom(
                  view.res,
                  true
              )
          );
        },
    );
  }

  _confirmJoinGame({required String errorMsg, required RoomRes roomRes}) {
    final baseDialog = AppAlertDialog (
        title: AppLanguage().translator(
            AppLanguage().translator(LanguageKeys.APP_TITLE)
        ),
        content: Text(
            errorMsg
        ),
        yesOnPressed: () {
          if(this.mounted){
            RouteGenerator.maybePop();
            _lobbyBloc.add(TabLobbyEventJoinRoom(
                roomRes,
                true
            ));
          }
        },
        noOnPressed: (){
          if(this.mounted){
            RouteGenerator.maybePop();
            _lobbyBloc.add(TabLobbyEventJoinRoom(
                roomRes,
                false
            ));
          }
        },
        txtYes: AppLanguage().translator(LanguageKeys.AGREE_TEXT_ALERT),
        txtNo: AppLanguage().translator(LanguageKeys.CANCEL_TEXT_ALERT)
    );

    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }
}