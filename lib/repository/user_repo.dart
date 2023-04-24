import 'package:cloud_firestore/cloud_firestore.dart';

class UserRespository {
  static Future<void> setUserData(
      String name, String email, String password) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc()
        .set({'name': name, 'email': email, 'password': password});
  }
}
