part of 'tasks_bloc.dart';

@immutable
abstract class TasksState {}

class GetUserState extends TasksState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  UserModel? userModel;
  GetUserState({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
    this.userModel,
  });
}
