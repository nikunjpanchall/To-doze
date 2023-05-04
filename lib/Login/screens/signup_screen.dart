import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Login/bloc/set_user_bloc.dart';
import 'package:todo/utils/app_constants.dart';
import 'package:todo/utils/app_theme.dart';
import 'package:todo/utils/utils.dart';
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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 30),
        child: SafeArea(
          child: BlocConsumer<SetUserBloc, SetUserState>(
            listener: (context, state) {
              if (state is UserStateSignup && state.isCompleted) {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              }
              if (state is UserStateSignup && state.hasError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('${state.errorMsg}')));
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Welcome!",
                            style: AppTheme.titleText,
                          ),
                          Text(
                            "Signup To Get Started",
                            style: AppTheme.subtitleText,
                          ),
                          SizedBox(
                            height: AppConstants.height,
                          ),
                          CustomTextField(
                            controller: nameController,
                            labletxt: 'Name',
                            obscure: false,
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
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<SetUserBloc>(context).add(
                                  UserEventRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text),
                                );
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/login", (route) => false);
                              }
                            },
                            child: state is UserStateSignup && state.isLoading
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "SignUp",
                                  ),
                          ),
                          SizedBox(
                            height: AppConstants.height,
                          ),
                        ],
                      ),
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
