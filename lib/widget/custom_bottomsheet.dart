import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo/home/models/task_model.dart';
import 'package:todo/utils/app_theme.dart';

import '../utils/app_constants.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {super.key, required this.taskList, required this.todoController, required this.buttonClick});

  final List<TaskModel>? taskList;
  final TextEditingController todoController;
  final Function() buttonClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: todoController,
              style: AppTheme.subtitleText.copyWith(fontSize: 30),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "What Do You Need To-do?",
                hintStyle: AppTheme.subtitleText.copyWith(fontSize: 30),
              ),
            ),
            SizedBox(
              height: AppConstants.height,
            ),
            ElevatedButton(
              style: AppTheme.buttonStyle,
              onPressed: buttonClick,
              child: const Text("Add New Task"),
            ),
          ],
        ),
      ),
    );
  }
}
