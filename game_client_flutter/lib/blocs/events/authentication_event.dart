abstract class AuthEvent {}

class OnAuthCheck extends AuthEvent {}

class OnAuthProcess extends AuthEvent {
  OnAuthProcess();
}

class OnAuthUpdate extends AuthEvent {}

class OnClear extends AuthEvent {}