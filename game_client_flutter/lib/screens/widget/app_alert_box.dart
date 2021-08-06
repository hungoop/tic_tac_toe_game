
import 'package:flutter/material.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/screens/screens.dart';

class AppAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final String txtYes;
  final String txtNo;
  final Function()? yesOnPressed;
  final Function()? noOnPressed;

  AppAlertDialog({
    this.title = "",
    this.content = const Text('...'),
    this.yesOnPressed,
    this.noOnPressed,
    this.txtYes = "Yes",
    this.txtNo = "No"
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: content,
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(
              Application.BORDER_RADIUS_CHAT_BOX)
      ),
      actions: <Widget>[
        if(this.noOnPressed != null)...[
          AppButton(
            this.txtNo,
            onPressed: this.noOnPressed,
            type: ButtonType.outline,
          ),
        ],
        if(this.yesOnPressed != null)...[
          AppButton(
            this.txtYes,
            onPressed: this.yesOnPressed,
            //type: ButtonType.text,
          ),
        ]
      ],
    );
  }
}