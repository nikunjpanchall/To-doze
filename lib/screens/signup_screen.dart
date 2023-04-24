import 'package:flutter/material.dart';
import 'package:todo/utils/app_constants.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:todo/widget/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome",
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
                emailController: nameController,
                labletxt: 'Name',
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
                  "SignUp",
                  style: AppTheme.bodyText,
                ),
              ),
              SizedBox(
                height: AppConstants.height,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
