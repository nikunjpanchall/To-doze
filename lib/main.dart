import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Login/bloc/set_user_bloc.dart';
import 'package:todo/home/bloc/tasks_bloc.dart';
import 'package:todo/home/screens/home_screen.dart';
import 'package:todo/Login/screens/login_screen.dart';
import 'package:todo/Login/screens/signup_screen.dart';
import 'package:todo/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SetUserBloc(),
        ),
        BlocProvider(
          create: (context) => TasksBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        initialRoute: '/home',
        routes: {
          '/': (context) => const LoginScreen(),
          '/home': (context) => const HomePage(),
          '/signup': (context) => const SignupScreen(),
        },
      ),
    );
  }
}
