abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginState {
  final String err;

  LoginErrorState(this.err);
}

class LoginChangePasswordVisibilityState extends LoginState {}

class LoginRememberState extends LoginState {}

class LoginGetUserLoadingStates extends LoginState {}

class LoginGetUserSuccessStates extends LoginState {}

class LoginGetUserErrorStates extends LoginState {}
