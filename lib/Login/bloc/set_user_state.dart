part of 'set_user_bloc.dart';

@immutable
abstract class SetUserState {}

class UserStateSignup extends SetUserState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  String? errorMsg;
  UserStateSignup(
      {this.isLoading = false,
      this.isCompleted = false,
      this.hasError = false,
      this.errorMsg});
}

class UserStateLogin extends SetUserState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  String? errorMsg;
  UserStateLogin({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
    this.errorMsg,
  });
}

class UserStateSigninWithGoogle extends SetUserState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  String? errorMsg;
  UserStateSigninWithGoogle({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
    this.errorMsg,
  });
}

class UserStateLogout extends SetUserState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  String? errorMsg;
  UserStateLogout({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
    this.errorMsg,
  });
}
