abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String err;

  RegisterErrorState(this.err);
}

class RegisterCreateUserSuccessState extends RegisterState {
  final String uId;

  RegisterCreateUserSuccessState(this.uId);
}

class RegisterCreateUserErrorState extends RegisterState {
  final String err;

  RegisterCreateUserErrorState(this.err);
}

class RegisterChangePasswordVisibilityState extends RegisterState {}

class RegisterGetUserSuccessState extends RegisterState {}
class RegisterGetUserErrortate extends RegisterState {}
class RegisterGetUserloadingState extends RegisterState {}
