import 'package:evira_store/core/app_router/route_names.dart';
import 'package:evira_store/presentation/cubits/get_user_info/get_user_info_cubit.dart';
import 'package:evira_store/presentation/cubits/login_user_cubit/login_user_cubit.dart';
import 'package:evira_store/presentation/screens/auth_form/auth_form.dart';
import 'package:evira_store/presentation/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/register_user_cubit/register_user_cubit.dart';
import '../../widgets/custom_alert_dialog.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LoginUserCubit>(context);
    final registerCubit = BlocProvider.of<RegisterUserCubit>(context);
    return BlocListener<LoginUserCubit, LoginUserState>(
      listener: (context, state) {
        if (state is LoginUserFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(cubit.errorMessage)));
        }
        /*if (state is LoginUserLoading) {
          showDialog(
              context: context,
              builder: (_) =>  AlertDialog(
                    title: Center(
                        child: loadingSpinner(),
                  )));
        }*/
        if(state is LoginUserDone){
          // Navigator.of(context).pop();
        }
      },
      child: Form(
        key: cubit.loginFormKey,
        child: AuthForm(
            obsecure: true,
            emailController: cubit.emailController,
            passwordController: cubit.passwordController,
            emailValidator: (_) =>
                registerCubit.validateEmail(cubit.emailController.text),
            passwordValidator: (_) =>
                registerCubit.validatePassword(cubit.passwordController.text),
            screenTitle: "Login to your Account",
            buttonTitle: "Sign in",
            userHasAccount: "Don't have an account?",
            onTap: () {
              if (cubit.loginFormKey.currentState!.validate()) {
                print(cubit.emailController.text);
                print(cubit.passwordController.text);
                cubit.loginUser(
                    cubit.emailController.text, cubit.passwordController.text).then((value){
                  context.read<GetUserInfoCubit>().getUserInfo().then((value){
                    Navigator.pushReplacementNamed(context, RouteNames.bottomNavBarScreen);
                      });
                });
              }
            },
            navigateOnTap: () {
              Navigator.pushNamed(context, RouteNames.registerScreen);
            },
            textButtonTitle: "Sign up"),
      ),
    );
  }
}
