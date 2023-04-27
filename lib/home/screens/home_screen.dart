import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Login/bloc/set_user_bloc.dart';
import 'package:todo/utils/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<SetUserBloc, SetUserState>(
            listener: (context, state) {
              if (state is UserStateLogout && state.isCompleted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                style: AppTheme.buttonStyle,
                onPressed: () {
                  BlocProvider.of<SetUserBloc>(context).add(UserEventLogout());
                },
                child: Text(
                  "Logout",
                  style: AppTheme.bodyText,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
