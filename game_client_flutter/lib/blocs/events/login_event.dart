
import 'package:country_code_picker/country_code.dart';
import 'package:equatable/equatable.dart';
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];

}

class LoginEventIdentificationChanged extends LoginEvent {
  final String identification;// dinh danh : telephone, email or userName
  final LOGIN_TYPE loginType;

  const LoginEventIdentificationChanged(this.identification, this.loginType);

  @override
  List<Object> get props => [identification, loginType];

  @override
  String toString() {
    return 'Email changed: $identification';
  }
}

class LoginEventPasswordChanged extends LoginEvent {
  final String password;
  final String identification;// dinh danh : telephone, email or userName
  final LOGIN_TYPE loginType;

  const LoginEventPasswordChanged({required this.password,required this.identification,required this.loginType});
  @override
  List<Object> get props => [password];

  @override
  String toString() {
    return 'Password changed $password';
  }
}

class LoginEventWithEmailAndPasswordPress extends LoginEvent {
  final CountryCode countryCode;
  final String identification;
  final String password;
  final LOGIN_TYPE loginType;


  const LoginEventWithEmailAndPasswordPress(
    this.identification,
    this.password,
    this.loginType, {
    required this.countryCode
  });

  @override
  List<Object> get props => [identification, password, loginType, countryCode];

  @override
  String toString() {
    return 'email = $identification, password = $password, loginType = $loginType';
  }

  String fullIdentification(){
    if(loginType == LOGIN_TYPE.TELEPHONE_PWD){
      return '${getCountryCode()}$identification';
    } else {
      return '$identification';
    }
    
  }

  String getCountryCode(){
    return countryCode.dialCode ?? "";
  }

}

class LoginEventStarted extends LoginEvent {
  final bool isLogout;
  const LoginEventStarted({required this.isLogout});

  @override
  List<Object> get props => [isLogout];
}

class LoginEventSuccess extends LoginEvent {}

class LoginEventFailure extends LoginEvent {
  final String messError;

  LoginEventFailure(this.messError);

  @override
  List<Object> get props => [messError];
}

enum LOGIN_TYPE {
  TOKEN,
  USERNAME_PWD,
  TELEPHONE_PWD,
  EMAIL,
  EMAIL_OR_ID
}

extension LOGIN_TYPE_EXT on LOGIN_TYPE {
  static LOGIN_TYPE parse(int typeId){
    return LOGIN_TYPE.values.firstWhere((element) {
      return element.getId() == typeId;
    }, orElse: () => LOGIN_TYPE.TELEPHONE_PWD);
  }

  //0.By Token 1.By UserName  2.By Telephone 3.By Email
  _lgTypeId(LOGIN_TYPE key){
    switch (key) {
      case LOGIN_TYPE.TOKEN: {
        return 0;
      }
      break;
      case LOGIN_TYPE.USERNAME_PWD: {
        return 1;
      }
      break;
      case LOGIN_TYPE.TELEPHONE_PWD: {
        return 2;
      }
      break;
      case LOGIN_TYPE.EMAIL: {
        return 3;
      }
      break;
      case LOGIN_TYPE.EMAIL_OR_ID: {
        return -1;
      }
      break;
      default:{
        return 2;
      }
      break;
    }
  }

  int getId(){
    return _lgTypeId(this);
  }
}

enum DEVICE_TYPE {
  UNKNOWN,//0
  WIN_APP,//1
  WEB,//2
  ANDROID,//3
  IOS//4
}

extension DEVICE_TYPE_EXT on DEVICE_TYPE {
  static DEVICE_TYPE parse(int typeId){
    return DEVICE_TYPE.values.firstWhere((element) {
      return element.getId() == typeId;
    }, orElse: () => DEVICE_TYPE.UNKNOWN);
  }

  _lgTypeId(DEVICE_TYPE key){
    switch (key) {
      case DEVICE_TYPE.UNKNOWN: {
        return 0;
      }
      break;
      case DEVICE_TYPE.WIN_APP: {
        return 1;
      }
      break;
      case DEVICE_TYPE.WEB: {
        return 2;
      }
      break;
      case DEVICE_TYPE.ANDROID: {
        return 3;
      }
      case DEVICE_TYPE.IOS: {
        return 4;
      }
      default:{
        return 0;
      }
      break;
    }
  }

  _lgTypeName(DEVICE_TYPE key){
    switch (key) {
      case DEVICE_TYPE.UNKNOWN: {
        return "UNKNOWN";
      }
      break;
      case DEVICE_TYPE.WIN_APP: {
        return "WIN_APP";
      }
      break;
      case DEVICE_TYPE.WEB: {
        return "WEB";
      }
      break;
      case DEVICE_TYPE.ANDROID: {
        return "ANDROID";
      }
      case DEVICE_TYPE.IOS: {
        return "IOS";
      }
      default:{
        return "UNKNOWN";
      }
      break;
    }
  }

  int getId(){
    return _lgTypeId(this);
  }

  String getName(){
    return _lgTypeName(this);
  }
}