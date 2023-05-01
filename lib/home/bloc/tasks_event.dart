part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {}

class GetUserEvent extends TasksEvent {
  final String? userId;

  GetUserEvent(this.userId);
}
