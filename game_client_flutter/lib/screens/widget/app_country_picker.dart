import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:game_client_flutter/configs/configs.dart';
import 'package:game_client_flutter/utils/utils.dart';

class AppCountryPicker extends StatelessWidget {
  final Function(CountryCode? codeSelection) onCountryChange;
  final Function(CountryCode? codeInit) onCountryInit;
  final EdgeInsets padding;

  AppCountryPicker({required this.onCountryInit, required this.onCountryChange, this.padding = const EdgeInsets.only(bottom: 0)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CountryCodePicker(
        onInit: onCountryInit,
        onChanged: onCountryChange,
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
        initialSelection:UtilResource.getDefaultDialCode(),
        favorite: Application.COUNTRY_FAVORITE,
        // optional. Shows only country name and flag
        showCountryOnly: false,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,
        flagWidth: Application.COUNTRY_FLAG_WITH,
        dialogBackgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}