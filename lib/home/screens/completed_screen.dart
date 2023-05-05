import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/Login/auth/firebase_auth.dart';
import 'package:todo/home/bloc/tasks_bloc.dart';
import 'package:todo/home/models/task_model.dart';
import 'package:todo/utils/app_theme.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  List<TaskModel>? taskList = [];
  bool ischeck = false;

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }

  _getData() {
    BlocProvider.of<TasksBloc>(context)
        .add(GetCompletedTaskEvent(Authentication.auth.currentUser?.uid));
  }

  _updateTask({required bool isCompleted, required String todo, required String id}) {
    BlocProvider.of<TasksBloc>(context)
        .add(UpdateTaskEvent(isCompleted: isCompleted, todo: todo, id: id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: (context, state) {
        if (state is GetCompletedTaskState && state.isCompleted) {
          taskList = state.taskModel;
        }
      },
      builder: (context, state) {
        return state is GetCompletedTaskState && state.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : taskList!.isEmpty
                ? Center(
                    child: SvgPicture.asset(
                      "assets/svg/completed.svg",
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 1,
                    ),
                  )
                : AnimationLimiter(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      itemCount: taskList?.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 100),
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: FadeInAnimation(
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  color: Colors.white,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    leading: Checkbox(
                                      activeColor: Colors.black,
                                      checkColor: Colors.white,
                                      value: taskList?[index].isCompleted,
                                      onChanged: (newValue) {
                                        taskList?[index].isCompleted = newValue;
                                        _updateTask(
                                            isCompleted: taskList?[index].isCompleted ?? false,
                                            todo: taskList?[index].todo ?? "",
                                            id: taskList?[index].id ?? "");
                                      },
                                    ),
                                    title: Text(
                                      "${taskList?[index].todo}",
                                      style: AppTheme.bodyText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
      },
    );
  }
}
