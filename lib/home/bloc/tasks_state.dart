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

class GetTaskState extends TasksState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  List<TaskModel>? taskModel;
  GetTaskState({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
    this.taskModel,
  });
}

class CreateTastState extends TasksState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  CreateTastState({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
  });
}

class DeleteTaskState extends TasksState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  DeleteTaskState({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
  });
}

class UpdateTaskState extends TasksState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  UpdateTaskState({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
  });
}


