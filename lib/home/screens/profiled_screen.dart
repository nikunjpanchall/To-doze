import 'dart:io';
import 'package:flutter/cupertino.dart';
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
  List<TaskModel>? pendingtaskList = [];
  List<TaskModel>? completedtaskList = [];

  File? _image;

  @override
  void initState() {
    // TODO: implement initState
    _getUserData();
    _getpendingtaskData();
    _getCompletedtaskData();
    super.initState();
  }

  _getUserData() {
    BlocProvider.of<TasksBloc>(context).add(GetUserEvent(Authentication.auth.currentUser?.uid));
  }

  _getpendingtaskData() {
    BlocProvider.of<TasksBloc>(context).add(GetTaskEvent(Authentication.auth.currentUser?.uid));
  }

  _getCompletedtaskData() {
    BlocProvider.of<TasksBloc>(context)
        .add(GetCompletedTaskEvent(Authentication.auth.currentUser?.uid));
  }

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() {
      _image = imageTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: (context, state) {
        if (state is GetTaskState && state.isCompleted) {
          pendingtaskList = state.taskModel;
        }
        if (state is GetCompletedTaskState && state.isCompleted) {
          completedtaskList = state.taskModel;
        }
        if (state is GetUserState && state.isCompleted) {
          userModel = state.userModel;
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
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.black,
                          child: ClipOval(
                              child: Image.file(
                            _image!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )),
                        )
                      : const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.black,
                        ),
                  SizedBox(
                    width: AppConstants.width,
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
                                            onPressed: () => getImage(ImageSource.camera),
                                            icon: const Icon(Icons.camera_enhance),
                                            label: const Text("Select From Camera"),
                                          ),
                                          SizedBox(
                                            height: AppConstants.height,
                                          ),
                                          ElevatedButton.icon(
                                            style: AppTheme.buttonStyle,
                                            onPressed: () => getImage(ImageSource.gallery),
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
                  num: pendingtaskList?.length.toString() ?? "",
                  title: 'Pending Task',
                ),
                CustomTaskContainer(
                  num: completedtaskList?.length.toString() ?? "",
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
