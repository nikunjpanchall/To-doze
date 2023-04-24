part of 'set_user_bloc.dart';

@immutable
abstract class SetUserState {}

class SetUserInitial extends SetUserState {
  bool? isLoading;
  bool? isCompleted;
  bool? hasError;

  SetUserInitial({
    this.isLoading,
    this.isCompleted,
    this.hasError,
  });
}
