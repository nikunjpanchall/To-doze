import 'package:firebase_auth/firebase_auth.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Stream<User?> authState;

  @override
  void initState() {
    authState = FirebaseAuth.instance.authStateChanges();
    super.initState();
  }

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
        home: StreamBuilder(
          stream: authState,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const LoginScreen();
          },
        ),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomePage(),
          '/signup': (context) => const SignupScreen(),
        },
      ),
    );
  }
}
