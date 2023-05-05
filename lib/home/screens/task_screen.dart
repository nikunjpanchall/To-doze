import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/Login/auth/firebase_auth.dart';
import 'package:todo/home/bloc/tasks_bloc.dart';
import 'package:todo/home/models/task_model.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:todo/widget/custom_bottomsheet.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController todoController = TextEditingController();
  List<TaskModel>? taskList = [];

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }

  _getData() {
    BlocProvider.of<TasksBloc>(context).add(GetTaskEvent(Authentication.auth.currentUser?.uid));
  }

  _deleteTask(String documentId) {
    BlocProvider.of<TasksBloc>(context).add(DeleteTaskEvent(documentId));
  }

  _updateTask({required bool isCompleted, required String todo, required String id}) {
    BlocProvider.of<TasksBloc>(context)
        .add(UpdateTaskEvent(isCompleted: isCompleted, todo: todo, id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocConsumer<TasksBloc, TasksState>(
          listener: (context, state) {
            if (state is GetTaskState && state.isCompleted) {
              taskList = state.taskModel;
            }
            if (state is CreateTastState && state.isCompleted) {
              _getData();
            }
            if (state is UpdateTaskState && state.isCompleted) {
              _getData();
            }
          },
          builder: (context, state) {
            return state is GetTaskState && state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : taskList!.isEmpty
                    ? Center(
                        child: SvgPicture.asset(
                          "assets/svg/To do.svg",
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 1,
                        ),
                      )
                    : AnimationLimiter(
                        child: ListView.builder(
                          physics:
                              const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          itemCount: taskList?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 100),
                              child: ScaleAnimation(
                                duration: const Duration(milliseconds: 2500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FlipAnimation(
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Slidable(
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            flex: 1,
                                            onPressed: (value) {
                                              showBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return CustomBottomSheet(
                                                    taskList: taskList,
                                                    todoController: todoController,
                                                    buttonClick: () {
                                                      _updateTask(
                                                          isCompleted:
                                                              taskList?[index].isCompleted ?? false,
                                                          todo: todoController.text,
                                                          id: taskList?[index].id ?? "");
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            backgroundColor: Colors.grey.shade900,
                                            foregroundColor: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            icon: Icons.edit,
                                            label: 'Edit',
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          SlidableAction(
                                            onPressed: (value) {
                                              _deleteTask(taskList?[index].id ?? "");
                                            },
                                            backgroundColor: Colors.grey.shade900,
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            borderRadius: BorderRadius.circular(12),
                                            label: 'Delete',
                                          ),
                                        ],
                                      ),
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: ListTile(
                                          contentPadding: const EdgeInsets.all(5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          leading: StatefulBuilder(builder: (context, setState) {
                                            return Checkbox(
                                              value: taskList?[index].isCompleted,
                                              activeColor: Colors.black,
                                              checkColor: Colors.white,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  taskList?[index].isCompleted = newValue;
                                                });
                                                Future.delayed(
                                                  const Duration(milliseconds: 500),
                                                  () {
                                                    _updateTask(
                                                        isCompleted:
                                                            taskList?[index].isCompleted ?? false,
                                                        todo: taskList?[index].todo ?? "",
                                                        id: taskList?[index].id ?? "");
                                                  },
                                                );
                                              },
                                            );
                                          }),
                                          title: Text(
                                            "${taskList?[index].todo}",
                                            style: AppTheme.bodyText,
                                          ),
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
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Ink(
              height: 70,
              width: 60,
              decoration: const ShapeDecoration(
                color: Colors.black,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.add),
                color: Colors.white,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return CustomBottomSheet(
                        taskList: taskList,
                        todoController: todoController,
                        buttonClick: () {
                          if (todoController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Please Add the task"),
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            BlocProvider.of<TasksBloc>(context).add(CreateTaskEvent(
                                todoController.text, Authentication.auth.currentUser!.uid, false));
                            todoController.clear();
                          }
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
