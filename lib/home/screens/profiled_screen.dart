import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Login/auth/firebase_auth.dart';
import 'package:todo/home/bloc/tasks_bloc.dart';
import 'package:todo/home/models/user_model.dart';
import 'package:todo/utils/app_constants.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:todo/widget/custom_task_container.dart';

class ProfiledScreen extends StatefulWidget {
  const ProfiledScreen({Key? key}) : super(key: key);

  @override
  State<ProfiledScreen> createState() => _ProfiledScreenState();
}

class _ProfiledScreenState extends State<ProfiledScreen> {
  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      bloc: TasksBloc()
        ..add(GetUserEvent(Authentication.auth.currentUser?.uid)),
      listener: (context, state) {
        if (state is GetUserState && state.isCompleted) {
          userModel = state.userModel;
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      '${Authentication.auth.currentUser?.photoURL} '),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello ${userModel?.name}",
                      style: AppTheme.subtitleText,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Keep plan for 1 day",
                      style: AppTheme.bodyText,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: AppConstants.height,
            ),
            Text(
              "Task Overview :",
              style: AppTheme.titleText.copyWith(fontSize: 22),
            ),
            SizedBox(
              height: AppConstants.height,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTaskContainer(
                  num: 1,
                  title: 'Pending Task',
                ),
                CustomTaskContainer(
                  num: 1,
                  title: 'Completed Task',
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Authentication().SignOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: const Text("Logout")),
          ],
        );
      },
    );
  }
}
