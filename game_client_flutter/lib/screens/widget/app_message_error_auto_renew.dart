import 'package:flutter/material.dart';
import 'package:game_client_flutter/configs/configs.dart';

class AppErrorAutoRenew extends StatelessWidget {
  final String errorMsg;
  final Function() onPressRenew;

  AppErrorAutoRenew(this.errorMsg, {required this.onPressRenew});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              errorMsg,
              style: TextStyle(
                fontSize: Application.FONT_SIZE_NORMAL,
              ),
              maxLines: 10,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            InkWell(
              child: Icon(
                Icons.autorenew,
                color: Theme.of(context).buttonColor,
                size: Application.SIZE_BUTTON_CHAT_BOX,
              ),
              onTap: onPressRenew,
            )
          ],
        )
    );
  }

}