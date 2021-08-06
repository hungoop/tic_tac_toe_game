import 'package:flutter/material.dart';
import 'package:game_client_flutter/screens/screens.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TTTApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          Overlay(
            initialEntries: [
              OverlayEntry(
                //builder: (context) => TTTHomePage(title: 'TTT Home Page'),
                builder: (context) => TTTApp2(),
              ),
            ],
          ),
          maxWidth: 1000,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(MediaQuery.of(context).size.width, name: DESKTOP)
          ],
          background: Container(color: Color(0xFFF5F5F5))
      ),
    );
  }
  
}



