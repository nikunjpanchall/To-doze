import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/home/models/task_model.dart';
import 'package:todo/home/models/user_model.dart';
import 'package:todo/home/repository/task_repo.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(GetUserState()) {
    on<GetUserEvent>(_getUserData);
    on<GetTaskEvent>(_getTaskData);
    on<CreateTaskEvent>(_createTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<UpdateTaskEvent>(_updateTask);
  }
  void _getUserData(GetUserEvent event, Emitter<TasksState> emit) async {
    try {
      emit(GetUserState(isLoading: true));
      final response = await TaskRepository().getUserData(event.userId);
      emit(GetUserState(isLoading: false, isCompleted: true, userModel: response));
    } on FirebaseException {
      emit(GetUserState(hasError: true));
    }
  }

  void _getTaskData(GetTaskEvent event, Emitter<TasksState> emit) async {
    try {
      emit(GetTaskState(isLoading: true));
      final response = await TaskRepository().getTaskData(event.userId);
      emit(GetTaskState(isLoading: false, isCompleted: true, taskModel: response));
    } on FirebaseException catch (e) {
      emit(GetTaskState(hasError: true));
    }
  }

  Future<void> _createTask(CreateTaskEvent event, Emitter<TasksState> emit) async {
    try {
      emit(CreateTastState(isLoading: true));
      await TaskRepository().createTask(event.todo, event.userId, event.isCompeted);
      emit(CreateTastState(
        isLoading: false,
        isCompleted: true,
      ));
    } catch (e) {
      emit(CreateTastState(hasError: true));
    }
  }

  Future<void> _deleteTask(DeleteTaskEvent event, Emitter<TasksState> emit) async {
    try {
      emit(CreateTastState(isLoading: true));
      TaskRepository().deleteTask(event.documentId);
      emit(CreateTastState(
        isLoading: false,
        isCompleted: true,
      ));
    } catch (e) {
      emit(CreateTastState(hasError: true));
    }
  }

  Future<void> _updateTask(UpdateTaskEvent event, Emitter<TasksState> emit) async {
    try {
      emit(UpdateTaskState(isLoading: true));
      TaskRepository().updateTask(event.isCompleted, event.todo, event.id);
      emit(UpdateTaskState(
        isLoading: false,
        isCompleted: true,
      ));
    } catch (e) {
      emit(UpdateTaskState(hasError: true));
    }
  }
}
