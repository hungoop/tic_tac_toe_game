import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/screens/screens.dart';

class FriendListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FriendListPage();
  }

}

class _FriendListPage extends State<FriendListPage> {
  late FriendListBloc _friendBloc;
  ValueNotifier<int> _valueNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    _friendBloc = BlocProvider.of<FriendListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite join'),
      ),
      body: SafeArea(
        child: BlocBuilder<FriendListBloc, FriendListState> (
            builder: (context, friendsState) {
              List<UserView> dataViews = [];

              if(friendsState is FriendListStateSuccess){
                dataViews = friendsState.views;

                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  _valueNotifier.value = friendsState.countSelected;
                }
               );
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
                              var data = dataViews[index];
                              return _createRoomItem(data);
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
      floatingActionButton: _buildButtonConfirm(),
    );
  }

  Widget _createRoomItem(UserView view){
    return AppListTitle(
      title: view.title(),
      subtitle: view.subTitle(),
      trailing: view.choose ? Icon(Icons.check_circle_outline)
          : Icon(Icons.add_circle_rounded),
      onPressed: (){
        _friendBloc.add(FriendListEventSelected(view.res));
      },
    );
  }

  Widget _buildButtonConfirm(){
    return ValueListenableBuilder(
        valueListenable: _valueNotifier,
        builder: (context, int val, Widget? child) {
          if(val == 0){
            return SizedBox();
          }
          else {
            return FloatingActionButton(
              onPressed: (){
                _friendBloc.add(FriendListEventInviteJoins());
              },
              tooltip: 'Done',
              mini: true,
              child: Icon(
                Icons.done_all_outlined,
                //size: Application.SIZE_ICON_AVATAR_SMALL,
                color: AppTheme.currentTheme.color,
              ),
            );
          }
        }
    );
  }

}