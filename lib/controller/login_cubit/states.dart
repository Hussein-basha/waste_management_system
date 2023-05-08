abstract class LoginStates {}

class LoginInitialStates extends LoginStates {}

class LoginLoadingStates extends LoginStates {}

class LoginSuccessStates extends LoginStates {
  final String uId;

  LoginSuccessStates(this.uId);
}

class LoginErrorStates extends LoginStates {
  final String error;

  LoginErrorStates(this.error);
}

class ChangePasswordVisibilityStates extends LoginStates {}
