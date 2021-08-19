import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final txt;

  AppTextField(this.txt);

  @override
  Widget build(BuildContext context) {
    return Text(
        '$txt',
      //overflow: TextOverflow.fade,
      textAlign: TextAlign.start,
    );
  }

}