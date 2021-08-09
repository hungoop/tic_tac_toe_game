
import 'package:equatable/equatable.dart';
import 'package:game_client_flutter/language/languages.dart';
import 'package:game_client_flutter/utils/utils.dart';

class LoginState extends Equatable {
  LoginState();

  @override
  List<Object> get props => [];
}

class LoginStateInitial extends LoginState {}

class LoginStateSuccess extends LoginState {
  final bool isValidIdentification;
  final bool isValidPassword;
  final int force = Utils.randomNext(0, 1000);

  LoginStateSuccess({
    this.isValidIdentification = false,
    this.isValidPassword = false
  });

  @override
  List<Object> get props => [
    isValidIdentification,
    isValidPassword,
    force
  ];

  LoginStateSuccess cloneWith({
    bool? isValidIdentification,
    bool? isValidPassword
  }){
    return LoginStateSuccess(
      isValidIdentification: isValidIdentification ?? this.isValidIdentification,
      isValidPassword: isValidPassword ?? this.isValidPassword
    );
  }

  bool isLoginButtonEnabled() {
    return isValidIdentification && isValidPassword;
  }
}

class LoginStateLoading extends LoginState {}

class LoginStateFailure extends LoginState{
  final String error;
  final int force = Utils.randomNext(0, 1000);

  LoginStateFailure({required this.error});

  @override
  List<Object> get props => [error, force];

  String getErrorMsg(){
    if (!Utils.checkDataEmpty(error)){
      return error;
    }
    return LanguageKeys.ERROR_MY_CLIENT;
  }

  @override
  String toString() {
    return '$error';
  }
}