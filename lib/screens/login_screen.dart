import 'package:flutter/material.dart';
import 'package:todo/utils/app_constants.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:todo/widget/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Onboard",
                style: AppTheme.titleText,
              ),
              Text(
                "Lets help you to do your task",
                style: AppTheme.bodyText,
              ),
              SizedBox(
                height: AppConstants.height,
              ),
              CustomTextField(
                emailController: emailController,
                labletxt: 'Email',
              ),
              CustomTextField(
                emailController: passwordController,
                labletxt: 'Password',
              ),
              SizedBox(
                height: AppConstants.height,
              ),
              ElevatedButton(
                style: AppTheme.buttonStyle,
                onPressed: () {},
                child: Text(
                  "Login",
                  style: AppTheme.bodyText,
                ),
              ),
              SizedBox(
                height: AppConstants.height,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Need an Account?",
                    style: TextStyle(fontFamily: "OpenSans-Light"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/signup', (route) => false);
                    },
                    child: const Text(" Register here"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
