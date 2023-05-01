import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/Login/auth/firebase_auth.dart';
import 'package:todo/home/models/task_model.dart';
import 'package:todo/home/models/user_model.dart';

class TaskRepository {
  Future<void> createTask(String todo, String userId, bool isCompleted) async {
    await FirebaseFirestore.instance
        .collection("tasks")
        .doc()
        .set({"todo": todo, "isCompleted": isCompleted, "userId": userId});
  }

  Future<UserModel> getData(String? userId) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      return UserModel.fromJson(response.data() ?? {});
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
}
