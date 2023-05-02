part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {}

class GetUserEvent extends TasksEvent {
  final String? userId;

  GetUserEvent(this.userId);
}

class GetTaskEvent extends TasksEvent {
  final String? userId;

  GetTaskEvent(this.userId);
}

class CreateTaskEvent extends TasksEvent {
  final String todo;
  final String userId;
  final bool isCompeted;
  CreateTaskEvent(this.todo, this.userId, this.isCompeted);
}

class DeleteTaskEvent extends TasksEvent {
  final String documentId;
  DeleteTaskEvent(this.documentId);
}

class UpdateTaskEvent extends TasksEvent {
  final bool isCompleted;
  final String todo;
  final String id;
  UpdateTaskEvent({required this.isCompleted, required this.todo, required this.id});
}
