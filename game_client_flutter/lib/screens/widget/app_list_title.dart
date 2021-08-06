import 'package:flutter/material.dart';

class AppListTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? icon;
  final VoidCallback? onPressed;
  final bool border;
  final double subTopPadding;
  final double iconPaddingLeft;
  final double iconPaddingRight;

  AppListTitle({
    Key? key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.icon,
    this.onPressed,
    this.border = true,
    this.subTopPadding = 8,
    this.iconPaddingLeft = 16,
    this.iconPaddingRight = 16
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Border borderWidget = Border();
    Widget subTitle = Container();
    Widget iconWidget = Container();
    if (icon != null) {
      iconWidget = Padding(
        padding: EdgeInsets.only(left: iconPaddingLeft, right: iconPaddingRight),
        child: icon,
      );
    }
    if (subtitle != null) {
      subTitle = Padding(
        padding: EdgeInsets.only(top: subTopPadding),
        child: Text(
          subtitle!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Theme.of(context).primaryColor),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    if (border) {
      borderWidget = Border(
        bottom: BorderSide(
          width: 1,
          color: Theme.of(context).dividerColor,
        ),
      );
    }
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          iconWidget,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: borderWidget,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16, left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subTitle
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: iconPaddingLeft, right: iconPaddingRight),
                    child: trailing ?? Container(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
