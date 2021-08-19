import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/screens/screens.dart';
import 'package:flutter/material.dart';

class DrawerMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginStorage? store = LoginStorage.read();

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: Application.SIZE_ICON_AVATAR,
                    ),
                  ),
                  if(store != null)...[
                    AppTextField('User: ${store.identification}')
                  ],
                  if(store != null)...[
                    Text(
                      'token: ${store.token}',
                      overflow: TextOverflow.clip,
                      maxLines: 3,
                    )
                  ]
                ],
              )
          ),
          AppListTitle(
            title: 'Report bet',
            onPressed: () {
              //RouteGenerator.pushNamed(
              //    ScreenRoutes.RUNTIME_STATISTICS
              //);
            },
          ),
          AppListTitle(
            title: 'Report win-lose',
            onPressed: (){
              //RouteGenerator.pushNamed(
              //    ScreenRoutes.SERVER_PROPERTY
              //);
            },
          ),
          AppListTitle(
            title: 'Devices',
            onPressed: (){
              //RouteGenerator.pushNamed(
              //    ScreenRoutes.SERVER_PROTOCOL
              //);
            },
          ),
          AppListTitle(
            title: 'Game rule',
            onPressed: (){
              //RouteGenerator.pushNamed(
              //    ScreenRoutes.SERVER_PROTOCOL
              //);
            },
          ),
          AppListTitle(
            title: 'Logout',
            onPressed: () {
              AppBloc.authBloc.add(OnClear());
              RouteGenerator.pop();
            },
          ),
          AppListTitle(
            title: 'Close',
            onPressed: () {
              RouteGenerator.pop();
            },
          ),
        ],
      ),
    );
  }
  
}