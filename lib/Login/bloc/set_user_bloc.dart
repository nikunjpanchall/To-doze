import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:todo/Login/auth/firebase_auth.dart';

part 'set_user_event.dart';
part 'set_user_state.dart';

class SetUserBloc extends Bloc<SetUserEvent, SetUserState> {
  SetUserBloc() : super(UserStateSignup()) {
    on<UserEventRegister>(_onUserRegister);
    on<UserEventLogIn>(_onUserLogin);
    on<UserEventSigninWithGoogle>(_onUserSigninWithGoogle);
    on<UserEventLogout>(_onEventLogout);
  }

  void _onUserRegister(
      UserEventRegister event, Emitter<SetUserState> emit) async {
    try {
      emit((UserStateSignup(isLoading: true)));
      await Authentication().SignupWithEmailAndPassword(
          email: event.email, password: event.password, name: event.name);
      emit(UserStateSignup(isLoading: false, isCompleted: true));
    } on FirebaseAuthException catch (e) {
      print('error -- ${e.message}');
      emit(UserStateSignup(hasError: true, errorMsg: e.message));
    }
  }

  void _onUserLogin(UserEventLogIn event, Emitter<SetUserState> emit) async {
    try {
      emit((UserStateLogin(isLoading: true)));
      await Authentication().SigninWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(UserStateLogin(isLoading: false, isCompleted: true));
    } on FirebaseAuthException catch (e) {
      print('error -- ${e.message}');
      emit(UserStateLogin(hasError: true, errorMsg: e.message));
    }
  }

  void _onUserSigninWithGoogle(
      UserEventSigninWithGoogle event, Emitter<SetUserState> emit) async {
    try {
      emit((UserStateSigninWithGoogle(isLoading: true)));
      GoogleSignInAccount? googleSignInAccount =
          await Authentication().SigninWithGoogle();
      if (googleSignInAccount != null) {
        emit(UserStateSigninWithGoogle(isLoading: false, isCompleted: true));
      } else {
        emit(UserStateSigninWithGoogle(
            isLoading: false,
            isCompleted: false,
            errorMsg: "Something went wrong!!"));
      }
    } on FirebaseAuthException catch (e) {
      print('error -- ${e.message}');
      emit(UserStateSigninWithGoogle(hasError: true, errorMsg: e.message));
    }
  }

  void _onEventLogout(UserEventLogout event, Emitter<SetUserState> emit) async {
    try {
      emit((UserStateLogout(isLoading: true)));
      await Authentication().SignOut();
      emit(UserStateLogout(isLoading: false, isCompleted: true));
    } on FirebaseAuthException catch (e) {
      print('error -- ${e.message}');
      emit(UserStateLogout(hasError: true, errorMsg: e.message));
    }
  }
}
