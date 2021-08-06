
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/models/models.dart';

abstract class ThemeEvent {}

class OnChangeTheme extends ThemeEvent {
  final ThemeModel? theme;
  final String? font;
  final DarkOption? darkOption;

  OnChangeTheme({
    this.theme,
    this.font,
    this.darkOption,
  });
}
