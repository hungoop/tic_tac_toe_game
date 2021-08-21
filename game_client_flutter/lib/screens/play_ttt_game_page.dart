import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/screens/screens.dart';

class PlayTTTGamePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlayTTTGamePage();
  }

}

class _PlayTTTGamePage extends State<PlayTTTGamePage> {
  late PlayGameBloc _playGameBloc;

  @override
  void initState() {
    super.initState();

    _playGameBloc = BlocProvider.of<PlayGameBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Game'),
        actions: <Widget> [
          IconButton(
            icon: Icon(
                Icons.list
            ),
            onPressed: (){
              RoomRes? view = _playGameBloc.res;
              if(view != null){
                List<UserView> userViews = _playGameBloc.userListModel.dataViews;
                showBoxReadMembers(userViews, view);
              }

            },
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle_rounded
            ),
            onPressed: (){
              RoomRes? view = _playGameBloc.res;
              if(view != null){
                //List<UserView> userViews = _playGameBloc.userListModel.dataViews;
                //showBoxReadMembers(userViews, view);

                RoomRes? res = _playGameBloc.res;
                if(res != null){
                  RouteGenerator.pushNamed(
                      ScreenRoutes.FRIEND_LIST,
                      arguments: res
                  );
                }
              }

            },
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<PlayGameBloc, PlayGameState> (
            builder: (context, gameState) {
              RoomView? view;
              List<UserView> userViews = [];
              List<PositionView> roadMapViews = [];

              if(gameState is PlayGameStateSuccess) {
                view = gameState.dataView;
                userViews = gameState.userViews;
                roadMapViews = gameState.roadMapViews;
              }

              return Column(
                children: [
                  AppConnectivity(),
                  Center(
                    child: Text('Join Game'),
                  ),
                  if(view != null)...[
                    Text(' Game ${view.title()}'),
                  ],
                  if(view != null)...[
                    Text(' Game ${view.subTitle()}'),
                  ],
                  if(roadMapViews.isNotEmpty)...[
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 5,
                        children: roadMapViews.map((e) {
                          return _createPositionItem(e);
                        }).toList(),
                      ),
                        /*child: ListView.builder(
                          itemBuilder: (BuildContext buildContext, int index){
                            if (index >= roadMapViews.length) {
                              return Center(
                                child: Text(AppLanguage().translator(LanguageKeys.LOADING_DATA)),
                              );
                            }
                            else {
                              PositionView bif = roadMapViews[index];
                              return _createPositionItem(bif);
                            }
                          },
                          itemCount: roadMapViews.length,
                        )*/
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

      },
    );
  }

  Widget _createPositionItem(PositionView view){
    return Container(
      child: InkWell(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField('${view.getX()}-${view.getY()}'),
            AppTextField('${view.getType()}'),
            Icon(getIcon(view.res.type))
          ],
        ),
        onTap: (){
          _playGameBloc.add(PlayGameEventPosChoose(view));
        },
      ),
    );
  }

  void showBoxReadMembers(List<UserView> userViews, RoomRes res){
    var boxLstMember = AppAlertDialog(
      title: 'User list',
      txtYes: AppLanguage().translator(LanguageKeys.AGREE_TEXT_ALERT),
      yesOnPressed: (){
        RouteGenerator.maybePop();
      },
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            if(userViews.isNotEmpty)...[
              Expanded(
                  child:
                  ListView.builder(
                    itemBuilder: (BuildContext buildContext, int index){
                      if (index >= userViews.length) {
                        return Center(
                          child: Text(AppLanguage().translator(LanguageKeys.LOADING_DATA)),
                        );
                      } else {
                        UserView bif = userViews[index];
                        return _createUserItem(bif);
                      }
                    },
                    itemCount: userViews.length,
                  )
              )
            ],
          ],
        ),
      ),
    );

    showDialog(context: context, builder: (BuildContext context) => boxLstMember);
  }

 IconData getIcon(TEAM_TYPE type){
    if(type == TEAM_TYPE.GREEN){
      return Icons.ac_unit_outlined;
    }
    else if(type == TEAM_TYPE.BLUE){
      return Icons.api;
    }
    else {
      return Icons.access_time_outlined;
    }
 }

}