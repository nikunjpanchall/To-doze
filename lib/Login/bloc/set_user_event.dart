part of 'set_user_bloc.dart';

@immutable
abstract class SetUserEvent {}

class UserEventLogout extends SetUserEvent {
  UserEventLogout();

  List<Object?> get pros => throw UnimplementedError();
}

class UserEventSignInWithGoogle extends SetUserEvent {
  UserEventSignInWithGoogle();

  List<Object?> get pros => throw UnimplementedError();
}

class UserEventLogIn extends SetUserEvent {
  final String email;
  final String password;
  UserEventLogIn({required this.email, required this.password});

  List<Object?> get pros => throw UnimplementedError();
}

class UserEventRegister extends SetUserEvent {
  final String name;
  final String email;
  final String password;
  UserEventRegister({required this.name, required this.email, required this.password});

  List<Object?> get pros => throw UnimplementedError();
}
