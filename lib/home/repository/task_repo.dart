import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo/home/models/task_model.dart';
import 'package:todo/home/models/user_model.dart';

class TaskRepository {
  // Get User Data From Firebase

  final auth = FirebaseAuth.instance;
  final ref = FirebaseFirestore.instance;

  Future<UserModel> getUserData(String? userId) async {
    try {
      final response = await ref.collection('users').doc(userId).get();
      return UserModel.fromJson(response.data() ?? {});
    } on FirebaseException {
      rethrow;
    }
  }

  // Get Task Data From Firebase
  Future<List<TaskModel>> getTaskData(String? userId) async {
    List<TaskModel>? taskList = [];
    try {
      final response = await ref
          .collection("tasks")
          .where("userId", isEqualTo: userId)
          .where("isCompleted", isEqualTo: false)
          .get();
      response.docs.forEach((element) {
        return taskList.add(TaskModel.fromJson(element.data()));
      });
      return taskList;
    } on FirebaseException {
      rethrow;
    }
  }

  Future<List<TaskModel>> getCompletedTask(String? userId) async {
    List<TaskModel>? taskList = [];
    try {
      final response = await ref
          .collection("tasks")
          .where("userId", isEqualTo: userId)
          .where("isCompleted", isEqualTo: true)
          .get();
      response.docs.forEach((element) {
        return taskList.add(TaskModel.fromJson(element.data()));
      });
      return taskList;
    } on FirebaseException {
      rethrow;
    }
  }

  // Create A task in Firebase
  Future<void> createTask(String todo, String userId, bool isCompleted) async {
    final reference = ref.collection("tasks");
    String documentId = reference.doc().id;
    reference
        .doc(documentId)
        .set({"id": documentId, "todo": todo, "isCompleted": isCompleted, "userId": userId});
  }

  Future<void> deleteTask(String id) async {
    await ref.collection("tasks").doc(id).delete();
  }

  Future<void> updateTask(bool isCompleted, String todo, String id) async {
    await ref
        .collection("tasks")
        .doc(id)
        .update({'todo': todo, 'isCompleted': isCompleted})
        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));
  }

  Future getImage(String path) async {
    String? imageUrl;
    Reference ref = FirebaseStorage.instance.ref().child(auth.currentUser!.uid);
    await ref.putFile(File(path));
    ref.getDownloadURL().then((value) {
      imageUrl = value;
    });
    Future.delayed(
        const Duration(milliseconds: 500),
        () => {
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(auth.currentUser!.uid)
                  .update({"profiledPhoto": imageUrl})
            });
  }
}
