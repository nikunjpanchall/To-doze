import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/home/models/user_model.dart';
import 'package:todo/home/repository/task_repo.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(GetUserState()) {
    on<GetUserEvent>(_getUserData);
  }
  void _getUserData(GetUserEvent event, Emitter<TasksState> emit) async {
    try {
      emit(GetUserState(isLoading: true));
      final response = await TaskRepository().getData(event.userId);
      emit(GetUserState(
          isLoading: false, isCompleted: true, userModel: response));
    } on FirebaseException {
      emit(GetUserState(hasError: true));
    }
  }
}
