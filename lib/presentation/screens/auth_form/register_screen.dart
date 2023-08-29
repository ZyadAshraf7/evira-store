import 'package:evira_store/data/models/user.dart';
import 'package:evira_store/presentation/cubits/register_user_cubit/register_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_router/route_names.dart';
import 'auth_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<RegisterUserCubit>(context);
    return Form(
      key: cubit.formKey,
      child: AuthForm(
          emailController: cubit.emailController,
          passwordController: cubit.passwordController,
          screenTitle: "Create your Account",
          buttonTitle: "Sign up",
          userHasAccount: "Already have an account?",
          emailValidator: (_) =>
              cubit.validateEmail(cubit.emailController.text),
          passwordValidator: (_) =>
              cubit.validatePassword(cubit.passwordController.text),
          obsecure: cubit.passwordObsecure,
          onTap: () {
            if (cubit.formKey.currentState!.validate()) {
              print("valid");
              Navigator.of(context).pushNamed(RouteNames.completeUserRegisterScreen,arguments: {
                'email': cubit.emailController.text,
                'password': cubit.passwordController.text
              });
              // cubit.createNewUser(user);
            }
          },
          navigateOnTap: () {
            Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
          },
          textButtonTitle: "Sign in"),
    );
  }
}
