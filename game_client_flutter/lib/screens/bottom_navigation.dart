import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/screens/screens.dart';

class BottomNavigation extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _BottomNavigation();
  }

}

class _BottomNavigation extends State<BottomNavigation> with WidgetsBindingObserver {
  int selectedIndex = 1;

  @override
  void initState() {
    if(WidgetsBinding.instance != null){
      WidgetsBinding.instance!.addObserver(this);
    }

    super.initState();
  }

  @override
  void dispose() {
    if(WidgetsBinding.instance != null){
      WidgetsBinding.instance!.removeObserver(this);
    }

    super.dispose();
  }

  ///Handle AppState
  @override
  Future<void> didChangeAppLifecycleState(state) async {
    if (state == AppLifecycleState.resumed) {
      AppBloc.appStateBloc.add(OnResume());
      AppBloc.authBloc.add(OnAuthUpdate());
    }
    else if (state == AppLifecycleState.paused) {
      print('BottomNavigation is AppLifecycleState paused. $state');
      AppBloc.appStateBloc.add(OnBackground());
    }
    else if (state == AppLifecycleState.detached) {
      print('BottomNavigation is AppLifecycleState ====== detached=========. $state');
    }
    else if (state == AppLifecycleState.inactive) {
      print('BottomNavigation is AppLifecycleState inactive. $state');
    }
    else {
      print('BottomNavigation is AppLifecycleState mode. $state');
    }

    super.didChangeAppLifecycleState(state);
  }

  ///On change tab bottom menu
  Future<void> _onItemTapped(index) async {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          TabLobbyPage(),
          TabGamePage(),
          TabSettingsPage()
        ],
        index: selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts_outlined),
            label: AppLanguage().translator(LanguageKeys.TAB_LOBBY_TEXT),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: AppLanguage().translator(LanguageKeys.TAB_GAME_TEXT),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppLanguage().translator(LanguageKeys.TAB_SETTING_TEXT),
          ),
        ],
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }

}