import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/screens/screens.dart';

class PlayTTTGamePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlayTTTGamePage();
  }

}

class _PlayTTTGamePage extends State<PlayTTTGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Game'),
      ),
      body: SafeArea(
        child: BlocBuilder<PlayGameBloc, PlayGameState> (
            builder: (context, gameState) {
              RoomView? view;

              if(gameState is PlayGameStateSuccess) {
                view = gameState.dataView;
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
                ],
              );

            }),
      ),
    );
  }

}