part of 'set_user_bloc.dart';

@immutable
abstract class SetUserEvent {}

class UserEventLogout extends SetUserEvent {
  UserEventLogout();

  List<Object?> get pros => throw UnimplementedError();
}

class UserEventSigninWithGoogle extends SetUserEvent {
  UserEventSigninWithGoogle();

  List<Object?> get pros => throw UnimplementedError();
}

class UserEventLogIn extends SetUserEvent {
  final email;
  final password;
  UserEventLogIn({required this.email, required this.password});

  List<Object?> get pros => throw UnimplementedError();
}

class UserEventRegister extends SetUserEvent {
  String name;
  String email;
  String password;
  UserEventRegister(
      {required this.name, required this.email, required this.password});

  List<Object?> get pros => throw UnimplementedError();
}
