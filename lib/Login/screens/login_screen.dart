import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Login/bloc/set_user_bloc.dart';
import 'package:todo/utils/app_constants.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:todo/utils/utils.dart';
import 'package:todo/widget/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 30),
        child: SafeArea(
          child: BlocConsumer<SetUserBloc, SetUserState>(
            listener: (context, state) {
              if (state is UserStateLogin && state.isCompleted) {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              }
              if (state is UserStateLogin && state.hasError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("${state.errorMsg}")));
              }
              if (state is UserStateSigninWithGoogle && state.isCompleted) {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              }
              if (state is UserStateSigninWithGoogle && state.hasError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("${state.errorMsg}")));
              }
            },
            builder: (context, state) {
              return Form(
                key: _keyForm,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, //New
                            blurRadius: 25.0,
                            offset: Offset(0, 5))
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Welcome Onboard",
                          style: AppTheme.titleText,
                        ),
                        Text(
                          "Lets help you to do your task",
                          style: AppTheme.subtitleText,
                        ),
                        SizedBox(
                          height: AppConstants.height,
                        ),
                        CustomTextField(
                          controller: emailController,
                          labletxt: 'Email',
                          validator: (value) {
                            return Utils.validateEmail(value ?? '');
                          },
                          obscure: false,
                        ),
                        SizedBox(
                          height: AppConstants.height,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          labletxt: 'Password',
                          obscure: true,
                        ),
                        SizedBox(
                          height: AppConstants.height,
                        ),
                        ElevatedButton(
                          style: AppTheme.buttonStyle,
                          onPressed: () {
                            if (_keyForm.currentState!.validate()) {
                              BlocProvider.of<SetUserBloc>(context).add(
                                UserEventLogIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }
                          },
                          child: state is UserStateLogin && state.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Login",
                                ),
                        ),
                        SizedBox(
                          height: AppConstants.height,
                        ),
                        Text(
                          "OR",
                          style: AppTheme.subtitleText,
                        ),
                        SizedBox(
                          height: AppConstants.height,
                        ),
                        ElevatedButton(
                          style: AppTheme.buttonStyle,
                          onPressed: () {
                            BlocProvider.of<SetUserBloc>(context).add(UserEventSigninWithGoogle());
                          },
                          child: state is UserStateSigninWithGoogle && state.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Sign In With Google",
                                ),
                        ),
                        SizedBox(
                          height: AppConstants.height,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an Account?  ",
                              style: AppTheme.bodyText,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text(
                                "Signup here",
                                style: AppTheme.subtitleText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
