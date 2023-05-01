import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static final auth = FirebaseAuth.instance;
  static final googleSignIn = GoogleSignIn();

  Future<void> SigninWithEmailAndPassword(
      {required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> SignupWithEmailAndPassword(
      {String? name,
      required String email,
      required String password,
      String? userId}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => FirebaseFirestore.instance
                .collection("users")
                .doc(value.user?.uid)
                .set(
              {"email": email, "name": name, "userId": value.user?.uid},
            ),
          );
    } catch (e) {
      rethrow;
    }
  }

  Future<GoogleSignInAccount?> SigninWithGoogle() async {
    try {
      final googleAccount = await googleSignIn.signIn();
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        final credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        User? user = userCredential.user;
        if (user != null) {
          if (userCredential.additionalUserInfo?.isNewUser ?? true) {
            {
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(user.uid)
                  .set(
                {
                  "email": user.email,
                  "name": user.displayName,
                  "userId": user.uid
                },
              );
            }
          }
        }
        return googleAccount;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> SignOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }
}
