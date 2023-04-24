part of 'set_user_bloc.dart';

@immutable
abstract class SetUserEvent {}

class SetUser extends SetUserEvent {
  String? name;
  String? email;
  String? password;
  SetUser(this.name, this.email, this.password);
}
