import 'package:game_client_flutter/blocs/blocs.dart';
import 'package:string_validator/string_validator.dart';

class Validators {

  static isValidIdentification(String accountKey, LOGIN_TYPE loginType) {
    if(loginType == LOGIN_TYPE.TELEPHONE_PWD){
      return isValidPhoneNumber(accountKey);
    }
    else if (loginType == LOGIN_TYPE.EMAIL) {
      return isValidEmail(accountKey);
    }
    else if (loginType == LOGIN_TYPE.EMAIL_OR_ID){
      return isValidPassword(accountKey);
    }
    else {
      return true;
    }
  }

  static isValidEmail(String email) {
    final regularExpression = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    return regularExpression.hasMatch(email);
  }

  static isValidPhoneNumber(String phoneNumber) {
      final regularExpression = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
      return regularExpression.hasMatch(phoneNumber);
  }

  static isValidPassword(String password){
    return password.length >= 3;
  }

  static isValidSMSCode(String code){
    return code.length >= 6;
  }

  static isValidRePassword(String password, String rePassword){
    return isValidPassword(password) && isValidPassword(rePassword) && password == rePassword;
  }

  static isValidNewPassword(String oldPassword, String newPassword){
    return isValidPassword(oldPassword) && isValidPassword(newPassword) && oldPassword != newPassword;
  }

  static isValidChatMessage(String msg){
    return msg.trim().length > 0;
  }

  static isValidEditMessage(String msg, String original){
    return msg.trim().length > 0 && msg != original;
  }

  static isValidDisplayName(String msg){
    return msg.trim().length > 0 ;//&& isValidNOTSpecial(msg);
  }

  static isValidNOTSpecial(String msg){
    final validSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if(msg.contains(validSpecial)){
      return false;
    } else {
      return true;
    }
  }

  static isValidAlphanumeric(String msg){
    return isAlphanumeric(msg);
  }

  static isValidSearch(String msg, String original){
    return msg.trim().length > 0 && msg != original;
  }

  static isValidSearchLength(String? searchTex){
    if(searchTex == null){
      return false;
    }
    return searchTex.length >= 2;
  }

}