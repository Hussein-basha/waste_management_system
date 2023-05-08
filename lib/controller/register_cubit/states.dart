abstract class RegisterStates {}

class RegisterInitialStates extends RegisterStates {}

class RegisterLoadingStates extends RegisterStates {}

class RegisterSuccessStates extends RegisterStates {}

class RegisterErrorStates extends RegisterStates {
  final String error;

  RegisterErrorStates(this.error);
}

class CreateUserSuccessStates extends RegisterStates {}

class CreateUserLoadingState extends RegisterStates {}

class CreateUserErrorStates extends RegisterStates {
  final String error;

  CreateUserErrorStates(this.error);
}

class SaveUserDataLoadingState extends RegisterStates {}

class SaveUserDataSuccessState extends RegisterStates {}

class SaveUserDataErrorState extends RegisterStates {
  String error;

  SaveUserDataErrorState(this.error);
}

class ChosenUserImageSuccessfullyState extends RegisterStates {}

class ChosenUserImageErrorState extends RegisterStates {}

class RegisterChangePasswordVisibilityStates extends RegisterStates {}
