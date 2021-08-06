import 'package:flutter/material.dart';
import 'package:game_client_flutter/utils/utils.dart';

class UtilOther {
  static fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode next,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static hiddenKeyboard(BuildContext context) {
    try {
      FocusScope.of(context).requestFocus(new FocusNode());
    } catch (ex, st) {
      UtilLogger.log('hiddenKeyboard', '$ex, $st');
    }
  }

  ///Singleton factory
  static final UtilOther _instance = UtilOther._internal();

  factory UtilOther() {
    return _instance;
  }

  UtilOther._internal();
}
