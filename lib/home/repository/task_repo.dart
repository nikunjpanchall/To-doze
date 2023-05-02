import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/home/models/task_model.dart';
import 'package:todo/home/models/user_model.dart';

class TaskRepository {
  // Get User Data From Firebase
  Future<UserModel> getUserData(String? userId) async {
    try {
      final response = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      return UserModel.fromJson(response.data() ?? {});
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  // Get Task Data From Firebase
  Future<List<TaskModel>> getTaskData(String? userId) async {
    List<TaskModel>? taskList = [];
    try {
      final response = await FirebaseFirestore.instance
          .collection("tasks")
          .where("userId", isEqualTo: userId)
          .get();
      response.docs.forEach((element) {
        return taskList.add(TaskModel.fromJson(element.data()));
      });
      return taskList;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  // Create A task in Firebase
  Future<void> createTask(String todo, String userId, bool isCompleted) async {
    final reference = await FirebaseFirestore.instance.collection("tasks");
    String documentId = reference.doc().id;
    reference
        .doc(documentId)
        .set({"id": documentId, "todo": todo, "isCompleted": isCompleted, "userId": userId});
  }

  Future<void> deleteTask(String id) async {
    await FirebaseFirestore.instance.collection("tasks").doc(id).delete();
  }

  Future<void> updateTask(bool isCompleted, String todo, String id) async {
    await FirebaseFirestore.instance
        .collection("tasks")
        .doc(id)
        .update({'todo': todo, 'isCompleted': isCompleted})
        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));
  }
}
