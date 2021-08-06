import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/screens/screens.dart';

class TabGamePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabGamePage();
  }

}

class _TabGamePage extends State<TabGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TabGameBloc, TabGameState> (
          builder: (context, settingState) {

            return Column(
              children: [
                AppConnectivity(),
                Center(
                  child: Text('Game'),
                )
              ],
            );
          }),
      ),
    );
  }

}