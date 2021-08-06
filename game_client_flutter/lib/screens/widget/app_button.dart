import 'package:flutter/material.dart';
import 'package:game_client_flutter/configs/configs.dart';

enum ButtonType {
  normal,
  outline,
  round,
  roundOutline,
  text,
  bigWith,
  bigNo,
  chat,
  call,
  roundText
}

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool loading;
  final bool disabled;
  final ButtonType type;
  final Widget? icon;
  final Color? backgroundColor;

  AppButton(
    this.text, {
    Key? key,
    this.onPressed,
    this.icon,
    this.loading = false,
    this.disabled = false,
    this.type = ButtonType.normal,
    this.backgroundColor
  }) : super(key: key);

  Widget _buildLoading() {
    if (!loading) return Container();
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      width: 14,
      height: 14,
      child: CircularProgressIndicator(strokeWidth: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {


    switch (type) {
      case ButtonType.call:
        Widget button = FloatingActionButton(
          heroTag: text,
          tooltip: text,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text(text), _buildLoading()],
          ),
          backgroundColor: backgroundColor ?? Theme.of(context).floatingActionButtonTheme.backgroundColor,
          onPressed: disabled ? null : onPressed,
        );

        if (icon != null) {
          button = FloatingActionButton(
            heroTag: text,
            tooltip: text,
            child: icon!,
            backgroundColor: backgroundColor ?? Theme.of(context).floatingActionButtonTheme.backgroundColor,
            onPressed: disabled ? null : onPressed,
          );
        }

        return button;

      case ButtonType.chat:
        final baseButton = Material(
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            minWidth: 30,
            padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
            onPressed: onPressed,
            child: icon,
          ),
        );
        return baseButton;

      case ButtonType.bigNo:
        final baseButton = Material(
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: disabled ? null : onPressed,
            child: Text(
                text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Application.FONT_SIZE_SMALL
                ),
            ),
          ),
        );
        return baseButton;

      case ButtonType.bigWith:
        Widget button = ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Application.BORDER_RADIUS_BUTTON),
                )
            )
          ),
          onPressed: disabled ? null : onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: Application.FONT_SIZE_SMALL
                ),
              ),
              _buildLoading()
            ],
          ),
        );
        if (icon != null) {
          button = ElevatedButton.icon(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Application.BORDER_RADIUS_BUTTON),
                    )
                )
            ),
            onPressed: disabled ? null : onPressed,
            icon: icon!,
            label: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.white),
                ),
                _buildLoading()
              ],
            ),
          );
        }

        return button;

      case ButtonType.outline:
        Widget button = OutlinedButton(
          onPressed: disabled ? null : onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text(text), _buildLoading()],
          ),
        );
        if (icon != null) {
          button = OutlinedButton.icon(
            onPressed: disabled ? null : onPressed,
            icon: icon!,
            label: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(text), _buildLoading()],
            ),
          );
        }

        return button;

      case ButtonType.round:
        Widget button = ElevatedButton(
          onPressed: disabled ? null : onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text(text), _buildLoading()],
          ),
        );
        if (icon != null) {
          button = ElevatedButton.icon(
            onPressed: disabled ? null : onPressed,
            icon: icon!,
            label: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(text), _buildLoading()],
            ),
          );
        }

        return button;

      case ButtonType.roundOutline:
        Widget button = OutlinedButton(
          onPressed: disabled ? null : onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text(text), _buildLoading()],
          ),
        );
        if (icon != null) {
          button = OutlinedButton.icon(
            onPressed: disabled ? null : onPressed,
            icon: icon!,
            label: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(text), _buildLoading()],
            ),
          );
        }

        return button;

      case ButtonType.text:
        Widget button = TextButton(
          onPressed: disabled ? null : onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text(text), _buildLoading()],
          ),
        );
        if (icon != null) {
          button = TextButton.icon(
            onPressed: disabled ? null : onPressed,
            icon: icon!,
            label: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(text), _buildLoading()],
            ),
          );
        }

        return button;
      case ButtonType.roundText:
        Widget button = Container(
            width: 60,
            child: Column(
                children: [
          ClipOval(
            child: Material(
              color: Theme.of(context).primaryColor, // button color
              child: InkWell(
                splashColor: Colors.red, // inkwell color
                child: SizedBox(width: 33, height: 33, child: icon != null ? icon : Container()),
                onTap: disabled ? null : onPressed,
              ),
            ),
          ),
          Text(text, style: TextStyle(fontSize: 10),textAlign: TextAlign.center,)
        ]));
        return button;
      default:
        Widget button = ElevatedButton(
          onPressed: disabled ? null : onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Colors.white),
              ),
              _buildLoading()
            ],
          ),
        );
        if (icon != null) {
          button = ElevatedButton.icon(
            onPressed: disabled ? null : onPressed,
            icon: icon!,
            label: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.white),
                ),
                _buildLoading()
              ],
            ),
          );
        }

        return button;
    }
  }
}
