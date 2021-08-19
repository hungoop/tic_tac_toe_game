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

              if(lobbyState is TabLobbyStateSuccess){
                dataViews = lobbyState.views;
              }

              return Column(
                children: [
                  AppConnectivity(),
                  if(dataViews.isEmpty)...[
                    Center(
                      child: Text(
                          'Lobby - data not found!'
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
          _lobbyBloc.add(TabLobbyEventJoinRoom(view.res));
        },
    );
  }

}