import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/screens/screens.dart';

class TabLobbyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabLobbyPage();
  }

}

class _TabLobbyPage extends State<TabLobbyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TabLobbyBloc, TabLobbyState> (
            builder: (context, settingState) {

              return Column(
                children: [
                  AppConnectivity(),
                  Center(
                    child: Text('Lobby'),
                  )
                ],
              );

            }),
      ),
    );
  }

}