abstract class WasteAppState {}

class WasteAppInitialState extends WasteAppState {}

class WasteAppChangeBottomNavState extends WasteAppState {}

class WasteAppGetUserLoadingState extends WasteAppState {}

class WasteAppGetUserSuccessState extends WasteAppState {}

class GetUsersDataSuccessState extends WasteAppState {}

class WasteAppGetUserErrorState extends WasteAppState {
  final String error;

  WasteAppGetUserErrorState(this.error);
}

class WasteAppProfileImageSuccessState extends WasteAppState {}

class GetProfileImageLoadingState extends WasteAppState {}

class WasteAppProfileImageErrorState extends WasteAppState {}

class WasteAppPostImageErrorState extends WasteAppState {}

class WasteAppCreatePostLoadingState extends WasteAppState {}

class WasteAppCreatePostErrorState extends WasteAppState {}

class WasteAppCreatePostSuccessState extends WasteAppState {}

class WasteAppRemovePostImageState extends WasteAppState {}

class WasteAppGetPostsSuccessState extends WasteAppState {}

class GetUsersPostsSuccessState extends WasteAppState {
  final int usersPostsLength;

  GetUsersPostsSuccessState(this.usersPostsLength);
}

class DeletePostSuccessfullyState extends WasteAppState {}

class GetUsersPostsLoadingState extends WasteAppState {}

class WasteAppPostImageSuccessState extends WasteAppState {}

class WasteAppUploadProfileImageSuccessState extends WasteAppState {}

class WasteAppUploadProfileImageErrorState extends WasteAppState {}

class WasteAppUserUpdateErrorState extends WasteAppState {}

class WasteAppUserUpdateSuccessState extends WasteAppState {}

class WasteAppUserUpdateLoadingState extends WasteAppState {}

class SendMessageSuccessState extends WasteAppState {}

class SendMessageLoadingState extends WasteAppState {}

class GetMessageSuccessState extends WasteAppState {}

class GetMessageLoadingState extends WasteAppState {}

class AppChangeModeState extends WasteAppState {}
