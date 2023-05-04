import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/Login/auth/firebase_auth.dart';
import 'package:todo/home/bloc/tasks_bloc.dart';
import 'package:todo/home/models/task_model.dart';
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
  List<TaskModel>? pendingTaskList = [];
  List<TaskModel>? completedTaskList = [];

  @override
  void initState() {
    // TODO: implement initState
    _getUserData();
    _getPendingTaskData();
    _getCompletedTaskData();
    super.initState();
  }

  _getUserData() {
    BlocProvider.of<TasksBloc>(context).add(GetUserEvent(Authentication.auth.currentUser?.uid));
  }

  _getPendingTaskData() {
    BlocProvider.of<TasksBloc>(context).add(GetTaskEvent(Authentication.auth.currentUser?.uid));
  }

  _getCompletedTaskData() {
    BlocProvider.of<TasksBloc>(context)
        .add(GetCompletedTaskEvent(Authentication.auth.currentUser?.uid));
  }

  _updateProfiled(String path) {
    BlocProvider.of<TasksBloc>(context).add(UpdateUserProfiledEvent(imgPath: path));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: (context, state) {
        if (state is GetTaskState && state.isCompleted) {
          pendingTaskList = state.taskModel;
        }
        if (state is GetCompletedTaskState && state.isCompleted) {
          completedTaskList = state.taskModel;
        }
        if (state is GetUserState && state.isCompleted) {
          userModel = state.userModel;
        }
        if (state is UpdateUserProfiledState && state.isCompleted) {
          _getUserData();
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.black54,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  state is UpdateUserProfiledState && state.isLoading
                      ? const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.black,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.black,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: userModel?.profiledPhoto ?? "",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => CachedNetworkImage(
                                  imageUrl:
                                      "https://icon-library.com/images/my-profile-icon-png/my-profile-icon-png-3.jpg"),
                            ),
                          ),
                        ),
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
                  SizedBox(
                    width: AppConstants.width,
                  ),
                  PopupMenuButton(
                    onSelected: (value) {},
                    itemBuilder: (BuildContext bc) {
                      return [
                        PopupMenuItem(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: MediaQuery.of(context).size.height / 5,
                                      width: MediaQuery.of(context).size.height / 2,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          topRight: Radius.circular(30.0),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey, //New
                                              blurRadius: 25.0,
                                              offset: Offset(0, 5))
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton.icon(
                                            style: AppTheme.buttonStyle,
                                            onPressed: () async {
                                              final image = await ImagePicker()
                                                  .pickImage(source: ImageSource.camera);
                                              if (image != null) {
                                                _updateProfiled(image.path);
                                                Navigator.pop(context);
                                              }
                                            },
                                            icon: const Icon(Icons.camera_enhance),
                                            label: const Text("Select From Camera"),
                                          ),
                                          SizedBox(
                                            height: AppConstants.height,
                                          ),
                                          ElevatedButton.icon(
                                            style: AppTheme.buttonStyle,
                                            onPressed: () async {
                                              final image = await ImagePicker()
                                                  .pickImage(source: ImageSource.gallery);
                                              if (image != null) {
                                                _updateProfiled(image.path);
                                                Navigator.pop(context);
                                              }
                                            },
                                            icon: const Icon(Icons.upload),
                                            label: const Text("Select From Gallery"),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: const Text("Edit Profiled"),
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
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
                  num: pendingTaskList?.length.toString() ?? "",
                  title: 'Pending Task',
                ),
                CustomTaskContainer(
                  num: completedTaskList?.length.toString() ?? "",
                  title: 'Completed Task',
                ),
              ],
            ),
            SizedBox(
              height: AppConstants.height,
            ),
            ElevatedButton(
                style: AppTheme.buttonStyle,
                onPressed: () {
                  Authentication().SignOut();
                  Navigator.pushNamedAndRemoveUntil(context, '/logout', (route) => false);
                },
                child: const Text("Logout")),
          ],
        );
      },
    );
  }
}
